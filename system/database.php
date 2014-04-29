<?php
/**
 * Database functions
 * Not included in class to shorten typing effort.
 */

connect_db();
function connect_db()
{
	global $db;
	@$db = pg_connect("host=" . DATABASE_HOSTNAME . " port=5432 dbname=" . DATABASE_DATABASE . " user=" . DATABASE_USERNAME . " password=" . DATABASE_PASSWORD . " options='--client_encoding=UTF8'");
	$error = pg_last_error();
	if (!empty($error)) {
		$errors[] = 'There was an error trying to connect to database at ' . DATABASE_HOSTNAME . ':<br><b>' . $error . '</b>';
		require 'templates/error_template.php';
		die();
	}

}

function q($sql, & $query_pointer = NULL, $debug = FALSE)
{
	global $db;
	if ($debug) {
		print "<pre>$sql</pre>";
	}
	$query_pointer = pg_query($db, $sql) or db_error_out();
	switch (substr($sql, 0, 6)) {
		case 'SELECT':
			exit("q($sql): Please don't use q() for SELECTs, use get_one() or get_first() or get_all() instead.");
		case '#INSE':
			exit("q($sql): Please don't use q() for INSERTs, use insert() instead.");
		case 'UPDA':
			exit("q($sql): Please don't use q() for UPDATEs, use update() instead.");
		default:
			return pg_affected_rows($query_pointer);
	}
}

function get_one($sql, $debug = FALSE)
{
	global $db;

	if ($debug) { // kui debug on TRUE
		print "<pre>$sql</pre>";
	}
	switch (substr($sql, 0, 6)) {
		case 'SELECT':
			$q = pg_query($db, $sql) or db_error_out();
			$result = pg_fetch_array($q);
			return empty($result) ? NULL : $result[0];
		default:
			exit('get_one("' . $sql . '") failed because get_one expects SELECT statement.');
	}
}

function get_all($sql)
{
	global $db;
	$q = pg_query($db, $sql) or db_error_out();
	while (($result[] = pg_fetch_assoc($q)) || array_pop($result)) {
		;
	}
	return $result;
}

function get_first($sql)
{
	global $db;
	$q = pg_query($db, $sql) or db_error_out();
	$first_row = pg_fetch_assoc($q);
	return empty($first_row) ? array() : $first_row;
}

function get_col($sql, $col_nr = 0, $debug=false)
{
	global $db;
	if ($debug) {
		print "<pre>$sql</pre>";
	}
	$q = pg_query($db, $sql) or db_error_out();
	$col = pg_fetch_all_columns($q, $col_nr);
	return empty($col) ? array() : $col;
}

function db_error_out()
{
	global $db;
	$db_error = pg_last_error($db);

	if (strpos($db_error, 'You have an error in SQL syntax') !== FALSE) {
		$db_error = '<b>Syntax error in</b><pre> ' . substr($db_error, 135) . '</pre>';

	}
	$backtrace = debug_backtrace();
	$file = $backtrace[0]['file'];
	$line = $backtrace[0]['line'];
	$function = isset($backtrace[2]['function']) ? $backtrace[2]['function'] : NULL;
	$args = isset($backtrace[2]['args']) ? $backtrace[2]['args'] : NULL;
	if (!empty($args)) {
		foreach ($args as $arg) {
			if (is_array($arg)) {
				$args2[] = implode(',', $arg);
			} else {
				$args2[] = $arg;
			}
		}
	}

	$args = empty($args2) ? '' : '"' . implode('", "', $args2) . '"';
	$s = "In file <b>$file</b>, line <b>$line</b>";
	if (!empty($function)) {
		$s .= ", function <b>$function</b>( $args )";
	}

	// Display <pre>SQL QUERY</pre> only if it is set
	$sql = isset($sql) ? '<pre style="text-align: left;">' . $sql . '</pre><br/>' : '';

	$output = '<h2><strong style="color: red">' . $db_error . '</strong></h2><br/>' . $sql . '<p>' . $s . '</p>';

	if (isset($_GET['ajax'])) {
		ob_end_clean();
		echo strip_tags($output);
	} else {
		$errors[] = $output;
		require '../templates/error_template.php';
	}
	die();

}

/**
 * @param $table string The name of the table to be inserted into.
 * @param $data array Array of data. For example: array('field1' => 'mystring', 'field2' => 3);
 * @return bool|int Returns the ID of the inserted row or FALSE when fails.
 */
function insert($table, $data)
{
	global $db;
	if ($table and is_array($data) and !empty($data)) {
		$values = implode(',', escape($data));
		$sql = "INSERT INTO `{$table}` SET {$values} ON DUPLICATE KEY UPDATE {$values}";
		$q = pg_query($db, $sql) or db_error_out();
		$result = pg_query($db, $sql);
		$insert_row = pg_fetch_row($result);
		$id = $insert_row[0];
		return ($id > 0) ? $id : FALSE;
	} else {
		return FALSE;
	}
}

function update($table, array $data, $where)
{
	global $db;
	if ($table and is_array($data) and !empty($data)) {
		$values = implode(',', escape($data));

		if (isset($where)) {
			$sql = "UPDATE `{$table}` SET {$values} WHERE {$where}";
		} else {
			$sql = "UPDATE `{$table}` SET {$values}";
		}
		$id = pg_query($db, $sql) or db_error_out();
		return ($id > 0) ? $id : FALSE;
	} else {
		return FALSE;
	}
}

function escape(array $data)
{
	global $db;
	$values = array();
	if (!empty($data)) {
		foreach ($data as $field => $value) {
			if ($value === NULL) {
				$values[] = "`$field`=NULL";
			} elseif (is_array($value) && isset($value['no_escape'])) {
				$values[] = "`$field`=" . pg_escape_literal($db, $value['no_escape']);
			} else {
				$values[] = "`$field`='" . pg_escape_literal($db, $value) . "'";
			}
		}
	}
	return $values;
}