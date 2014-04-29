<?php
$row_count= 100;
// This script subsets live database to minimal database for testing purposes, leaving only last $row_count rows to each table
// plus related rows in foreign tables.

// Connecting to DB
require '../config.php';
require '../system/database.php';

// Get all tables
$tables = get_col("SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname= 'small_piletimaailm' AND tableowner='piletimaailm' AND tablename!='schema_info' AND tablename!='invalid_seats'");

// Disable FK constraints on all tables
foreach ($tables as $table) {
	q("alter table small_piletimaailm.$table disable trigger all");
}

// Insert some data into test schema
/**
 * @param $table
 * @param $row_count
 * @return int
 */
function delete_possible_duplicate_rows($table, $row_count)
{
	return q("DELETE FROM small_piletimaailm.$table WHERE ID IN(SELECT id FROM public.$table ORDER BY id DESC LIMIT $row_count)");
}

/**
 * @param $table
 * @param $row_count
 * @return int
 */
function copy_last_rows_to_new_database($table, $row_count)
{
	return q("INSERT INTO small_piletimaailm.$table SELECT * FROM public.$table ORDER BY id DESC LIMIT $row_count");
}

/**
 * @param $table
 * @return array
 */
function find_fks_for_table(& $q_fk, $table)
{
	$sql = "select
				f.relname as foreign_table,
				(select a.attname
				 from pg_attribute a
				 where a.attrelid = f.oid
				   and a.attnum = o.confkey[1]
				   and a.attisdropped = false) as foreign_colname,
				(select a.attname
				 from pg_attribute a
				 where a.attrelid = m.oid
				   and a.attnum = o.conkey[1]
				   and a.attisdropped = false) as target_colname
			from pg_constraint o
			  left join pg_class c on c.oid = o.conrelid
			  left join pg_class f on f.oid = o.confrelid
			  left join pg_class m on m.oid = o.conrelid
			where o.contype = 'f'
			  and o.conrelid in (select oid from pg_class c where c.relkind = 'r')
			  and m.relname = '$table'
			  and  (select nspname
				 from pg_namespace
				 where oid=f.relnamespace) = 'public'";
	 q($sql, $q_fk);
}

/**
 * @param $target_colname
 * @param $table
 * @return array
 */
function get_id_for_related_foreign_table_rows($target_colname, $table)
{
	return get_col("SELECT DISTINCT $target_colname FROM small_piletimaailm.$table",0, true);
}

/**
 * @param $foreign_table
 * @param $ids
 * @return int
 */
function delete_rows($foreign_table, $ids)
{
	return q("DELETE FROM small_piletimaailm.$foreign_table WHERE ID IN($ids)");
}

/**
 * @param $foreign_table
 * @param $ids
 * @return int
 */
function insert_rows($foreign_table, $ids)
{
	return q("INSERT INTO small_piletimaailm.$foreign_table SELECT * FROM public.$foreign_table WHERE ID IN($ids)");
}
$n=0;
foreach ($tables as $table) {
	// Display table count
	echo $n++.". $table<br>";

	// Delete possibly existing duplicate rows to avoid duplicates
	delete_possible_duplicate_rows($table, $row_count);

	// Copy last $row_count rows to new database
	copy_last_rows_to_new_database($table, $row_count);

	// Find all FKs for $table
	find_fks_for_table($q_fk, $table);

	while ($rows = pg_fetch_array($q_fk, null, PGSQL_ASSOC)) {
		/** Loop all FKs, gather all foreign IDs and then insert those missing rows to foreign tables **/

		// Set some shortcuts
		$foreign_col = $rows['foreign_colname'];
		$foreign_table = $rows['foreign_table'];
		$target_colname = $rows['target_colname'];

		// Get IDs of related foreign table rows
		$ids = get_id_for_related_foreign_table_rows($target_colname, $table);

		// Serialize $ids
		$ids = implode(',', array_filter($ids));

		// Insert related foreign table rows.
		if (!empty($ids)) {

			// Delete possibly existing duplicate rows to avoid duplicates
			delete_rows($foreign_table, $ids);

			// Insert same rows
			insert_rows($foreign_table, $ids);

		}
	}
}
// Enable FK constraints on all tables
foreach ($tables as $table) {
	q("alter table small_piletimaailm.$table enable trigger all");
}