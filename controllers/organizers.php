<?php

class organizers extends Controller
{

    function index()
    {

    }
    function timeline()
    {
        list($id, $city)=explode('-',$this->params[0]);
        $this->title2 = get_one("SELECT title
            FROM web_organizer_menus
            WHERE organizer_id = '$id'");

        $this->organizer_level = get_one("SELECT is_level_2
            FROM web_organizer_menus
            WHERE organizer_id = '$id'");


        $this->organizer_position = get_one("SELECT position
            FROM web_organizer_menus
            WHERE organizer_id = '$id'");


        if ($this->organizer_level == 't') {
            $this->title1 = get_one("SELECT title
                FROM web_organizer_menus
                WHERE position < $this->organizer_position
                    AND  is_level_2 = FALSE
                ORDER BY position DESC");
        }
        $this->performances = get_all("SELECT * FROM events WHERE type='Performance' AND state='on_sale' AND organizer_id ='$id' ORDER BY time");
        // How many items to list per page
        $this->max_per_page = 25;
        // How many events there are
        $this->count_performances = count($this->performances);
        // How many pages will there be
        $this->pages = ceil($this->count_performances / $this->max_per_page);

        // What page are we currently on?
        $this->page = min($this->pages, filter_input(INPUT_GET, 'page', FILTER_VALIDATE_INT, array(
            'options' => array(
                'default' => 1,
                'min_range' => 1,
            ),
        )));
        // Calculate the offset for the query
        if ((($this->page - 1) * $this->max_per_page) >= 0) {
            $this->offset = ($this->page - 1) * $this->max_per_page;
        } else {
            $this->offset = 0;
        }
        // The "back" link
        $this->prevlink = ($this->page > 1) ? '<a href="' . $_SERVER['PHP_SELF'] . '?page=' . ($this->page - 1) . '" title="Eelmine">Eelmine</a>' : '';
        // The "forward" link
        $this->nextlink = ($this->page < $this->pages) ? '<a href="' . $_SERVER['PHP_SELF'] . '?page=' . ($this->page + 1) . '" title="Järgmine">Järgmine</a>' : '';

        $newArray = array();
        $sql_command = "SELECT * FROM events WHERE type='Performance' AND state='on_sale' AND organizer_id ='$id' ORDER BY time LIMIT " . $this->max_per_page . " OFFSET " . $this->offset . "";
        $this->performances = get_all($sql_command);
        if (!empty($this->performances)) {
            foreach ($this->performances as $performance) {
                $performance['locations'] = get_one("SELECT D.name FROM (hall_plans A JOIN events B ON A.id = B.hall_plan_id) JOIN halls C ON A.hall_id = C.id JOIN venues D ON C.venue_id = D.id WHERE B.state = 'on_sale' AND B.id='{$performance['id']}'");
                $performance['hall_plan_id'] = get_one("SELECT hall_plan_id FROM events WHERE type='Performance' AND state='on_sale' AND organizer_id ='$id' AND event_id = '{$performance['event_id']}'");
                $performance['seats'] = get_one("SELECT SUM(count_all), hall_plan_id FROM ( SELECT COUNT(DISTINCT hall_elements.id) AS count_all, hall_elements.hall_plan_id FROM hall_elements WHERE hall_elements.hall_plan_id = '{$performance['hall_plan_id']}' AND ( hall_elements.type = 'SeatMarked' ) AND ( hall_elements.sale_permission_web = TRUE ) AND ( COALESCE( (SELECT st.type FROM seat_transactions st WHERE st.seat_id = hall_elements.id AND st.created_at = (SELECT MAX(st2.created_at) FROM seat_transactions st2 WHERE st2.seat_id = hall_elements.id)), 'SeatTransactionFree' ) IN ( E'SeatTransactionFree',E'SeatTransactionBookingCancellation', E'SeatTransactionBookingExpiry',E'SeatTransactionRefund', E'SeatTransactionReservationCancellation') ) GROUP BY hall_elements.hall_plan_id UNION ALL SELECT -COUNT(DISTINCT hall_elements.id) AS count_all, hall_elements.hall_plan_id FROM hall_elements WHERE hall_elements.hall_plan_id = '{$performance['hall_plan_id']}' AND ( hall_elements.type = 'SeatUnmarked' ) AND ( (SELECT st.type FROM seat_transactions st WHERE st.seat_id = hall_elements.id AND st.created_at = (SELECT MAX(st2.created_at) FROM seat_transactions st2 WHERE st2.seat_id = hall_elements.id)) NOT IN ( E'SeatTransactionFree',E'SeatTransactionBookingCancellation', E'SeatTransactionBookingExpiry',E'SeatTransactionRefund', E'SeatTransactionReservationCancellation') ) GROUP BY hall_elements.hall_plan_id UNION ALL SELECT SUM(unmarked_seat_count) AS count_all, hall_areas.hall_plan_id FROM hall_areas WHERE hall_areas.hall_plan_id = '{$performance['hall_plan_id']}' GROUP BY hall_areas.hall_plan_id ) AS x GROUP BY hall_plan_id;");
                $exploded_date=explode(" ",$performance['time']);
                $performance['time_date'] =date("d.m.Y", strtotime($exploded_date[0]));
                $day =date("D", strtotime($exploded_date[0]));
                $performance['normalprices'] = get_one("SELECT P.value FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.id='{$performance['id']}'
                              AND E.state='on_sale'
                              AND M.type = 'NormalPrice'
                              AND M.valid_for_web_sales IS NOT FALSE
                              AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $performance['discountprices'] = get_one("SELECT P.value FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.id='{$performance['id']}'
                              AND E.state='on_sale'
                                AND M.type = 'PercentDiscount'
                                AND M.valid_for_web_sales IS NOT FALSE
                                AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");

                switch($day){
                    case "Mon":
                        $performance['time_day']="E";
                        break;
                    case "Tue":
                        $performance['time_day']="T";
                        break;
                    case "Wed":
                        $performance['time_day']="K";
                        break;
                    case "Thu":
                        $performance['time_day']="N";
                        break;
                    case "Fri":
                        $performance['time_day']="R";
                        break;
                    case "Sat":
                        $performance['time_day']="L";
                        break;
                    case "Sun":
                        $performance['time_day']="P";
                        break;
                }
                $performance['time_clock'] =date("H:i",strtotime($exploded_date[1]));
                array_push($newArray, $performance);

            }
            $this->performances=$newArray;
        }

    }

    function view()
    {
        $this->events = get_all("SELECT * FROM events WHERE type='Event' AND state='on_sale' AND organizer_id ='{$this->params[0]}'");
        $this->organizer_name = get_one("SELECT name FROM partners WHERE id ='{$this->params[0]}'");
        if (!empty($this->events)) {
            foreach ($this->events as & $event) {
                $event['performances'] = get_col("SELECT to_char(time, 'DD.MM') AS aeg FROM events WHERE event_id='{$event['id']}' order by time");
            }
        }
        // How many items to list per page
        $this->max_per_page = 25;
        // How many events there are
        $this->count_events = count($this->events);
        // How many pages will there be
        $this->pages = ceil($this->count_events / $this->max_per_page);

        // What page are we currently on?
        $this->page = min($this->pages, filter_input(INPUT_GET, 'page', FILTER_VALIDATE_INT, array(
            'options' => array(
                'default' => 1,
                'min_range' => 1,
            ),
        )));
        // Calculate the offset for the query
        if ((($this->page - 1) * $this->max_per_page) >= 0) {
            $this->offset = ($this->page - 1) * $this->max_per_page;
        } else {
            $this->offset = 0;
        }
        // The "back" link
        $this->prevlink = ($this->page > 1) ? '<a href="' . $_SERVER['PHP_SELF'] . '?page=' . ($this->page - 1) . '" title="Eelmine">Eelmine</a>' : '';
        // The "forward" link
        $this->nextlink = ($this->page < $this->pages) ? '<a href="' . $_SERVER['PHP_SELF'] . '?page=' . ($this->page + 1) . '" title="Järgmine">Järgmine</a>' : '';

        $sql_command = "SELECT * FROM events WHERE type='Event' AND state='on_sale' AND organizer_id ='{$this->params[0]}' ORDER BY name LIMIT " . $this->max_per_page . " OFFSET " . $this->offset . "";
        $this->event_pages = get_all($sql_command);
        $newArray = array();
        if (!empty($this->event_pages)) {
            foreach ($this->event_pages as $event_page) {
                $event_page['hall_plan_id'] = get_col("SELECT hall_plan_id FROM events WHERE type='Performance' AND state='on_sale' AND organizer_id ='{$this->params[0]}' AND event_id = '{$event_page['id']}'");
                $event_page['all_hall_plan_id'] =  implode(", ", $event_page['hall_plan_id']);
                $event_page['seats'] = get_one("SELECT SUM(count_all), hall_plan_id FROM ( SELECT COUNT(DISTINCT hall_elements.id) AS count_all, hall_elements.hall_plan_id FROM hall_elements WHERE hall_elements.hall_plan_id IN ({$event_page['all_hall_plan_id']}) AND ( hall_elements.type = 'SeatMarked' ) AND ( hall_elements.sale_permission_web = TRUE ) AND ( COALESCE( (SELECT st.type FROM seat_transactions st WHERE st.seat_id = hall_elements.id AND st.created_at = (SELECT MAX(st2.created_at) FROM seat_transactions st2 WHERE st2.seat_id = hall_elements.id)), 'SeatTransactionFree' ) IN ( E'SeatTransactionFree',E'SeatTransactionBookingCancellation', E'SeatTransactionBookingExpiry',E'SeatTransactionRefund', E'SeatTransactionReservationCancellation') ) GROUP BY hall_elements.hall_plan_id UNION ALL SELECT -COUNT(DISTINCT hall_elements.id) AS count_all, hall_elements.hall_plan_id FROM hall_elements WHERE hall_elements.hall_plan_id IN ({$event_page['all_hall_plan_id']}) AND ( hall_elements.type = 'SeatUnmarked' ) AND ( (SELECT st.type FROM seat_transactions st WHERE st.seat_id = hall_elements.id AND st.created_at = (SELECT MAX(st2.created_at) FROM seat_transactions st2 WHERE st2.seat_id = hall_elements.id)) NOT IN ( E'SeatTransactionFree',E'SeatTransactionBookingCancellation', E'SeatTransactionBookingExpiry',E'SeatTransactionRefund', E'SeatTransactionReservationCancellation') ) GROUP BY hall_elements.hall_plan_id UNION ALL SELECT SUM(unmarked_seat_count) AS count_all, hall_areas.hall_plan_id FROM hall_areas WHERE hall_areas.hall_plan_id IN ({$event_page['all_hall_plan_id']}) GROUP BY hall_areas.hall_plan_id ) AS x GROUP BY hall_plan_id;");
                $event_page['dates'] = get_col("SELECT to_char(time, 'DD.MM') AS aeg FROM events WHERE event_id='{$event_page['id']}' order by time");
                $event_page['locations'] = get_col("SELECT D.name FROM (hall_plans A JOIN events B ON A.id = B.hall_plan_id) JOIN halls C ON A.hall_id = C.id JOIN venues D ON C.venue_id = D.id WHERE B.state = 'on_sale' AND B.id='{$event_page['id']}'");
                $event_page['normalprices_min'] = get_one("SELECT MIN(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event_page['id']}'
                              AND E.state='on_sale'
                              AND M.type = 'NormalPrice'
                              AND M.valid_for_web_sales IS NOT FALSE
                              AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $event_page['normalprices_max'] = get_one("SELECT MAX(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event_page['id']}'
                              AND E.state='on_sale'
                              AND M.type = 'NormalPrice'
                              AND M.valid_for_web_sales IS NOT FALSE
                              AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $event_page['discountprices_min'] = get_one("SELECT MIN(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event_page['id']}'
                              AND E.state='on_sale'
                                AND M.type = 'PercentDiscount'
                                AND M.valid_for_web_sales IS NOT FALSE
                                AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $event_page['discountprices_max'] = get_one("SELECT MAX(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event_page['id']}'
                              AND E.state='on_sale'
                                AND M.type = 'PercentDiscount'
                                AND M.valid_for_web_sales IS NOT FALSE
                                AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");

                array_push($newArray, $event_page);
            }
        }
        $this->event_pages = $newArray;

        $this->title2 = get_one("SELECT title
            FROM web_organizer_menus
            WHERE organizer_id = '{$this->params[0]}'");

        $this->organizer_level = get_one("SELECT is_level_2
            FROM web_organizer_menus
            WHERE organizer_id = '{$this->params[0]}'");


        $this->organizer_position = get_one("SELECT position
            FROM web_organizer_menus
            WHERE organizer_id = '{$this->params[0]}'");


        if ($this->organizer_level == 't') {
            $this->title1 = get_one("SELECT title
                FROM web_organizer_menus
                WHERE position < $this->organizer_position
                    AND  is_level_2 = FALSE
                ORDER BY position DESC");
        }

    }

}
