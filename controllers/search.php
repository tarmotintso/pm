<?php

class search extends Controller
{

    function index()
    {
        $words = $_POST['performance']['full_name_et'];

        $this->eventcount = get_all(" SELECT * FROM events E WHERE id in (SELECT event_id FROM events
                                  WHERE name iLIKE '%$words%'
                                  AND type='Performance'
                                  AND state='on_sale'
                                  AND (web_sales_start IS NULL
                                  OR web_sales_start <= NOW())
                                  AND time - CAST(web_sales_end || ' seconds' AS INTERVAL) > NOW())
                                  AND (SELECT COUNT(event_id) FROM events X WHERE X.event_id = E.id) > 0 ");

        // How many items to list per page
        $this->max_per_page = 5;
        // How many events there are
        $this->count_events = count($this->eventcount);
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


        $this->events = get_all(" SELECT * FROM events E WHERE id in (SELECT event_id FROM events
                                  WHERE name iLIKE '%$words%'
                                  AND type='Performance'
                                  AND state='on_sale'
                                  AND (web_sales_start IS NULL
                                  OR web_sales_start <= NOW())
                                  AND time - CAST(web_sales_end || ' seconds' AS INTERVAL) > NOW())
                                  AND (SELECT COUNT(event_id) FROM events X WHERE X.event_id = E.id) > 0
                                  ORDER BY name LIMIT " . $this->max_per_page . " OFFSET " . $this->offset . "");


        $newArray = array();
        if (!empty($this->events)) {
            foreach ($this->events as $event) {
                $event['hall_plan_id'] = get_col("SELECT hall_plan_id FROM events WHERE type='Performance' AND state='on_sale' AND event_id = '{$event['id']}'");
                $event['all_hall_plan_id'] = implode(", ", $event['hall_plan_id']);
                if (!($event['all_hall_plan_id'])) {
                    $event['seats'] = 0;
                } else {
                    $event['seats'] = get_one("SELECT SUM(count_all), hall_plan_id FROM ( SELECT COUNT(DISTINCT hall_elements.id) AS count_all, hall_elements.hall_plan_id FROM hall_elements WHERE hall_elements.hall_plan_id IN ({$event['all_hall_plan_id']}) AND ( hall_elements.type = 'SeatMarked' ) AND ( hall_elements.sale_permission_web = TRUE ) AND ( COALESCE( (SELECT st.type FROM seat_transactions st WHERE st.seat_id = hall_elements.id AND st.created_at = (SELECT MAX(st2.created_at) FROM seat_transactions st2 WHERE st2.seat_id = hall_elements.id)), 'SeatTransactionFree' ) IN ( E'SeatTransactionFree',E'SeatTransactionBookingCancellation', E'SeatTransactionBookingExpiry',E'SeatTransactionRefund', E'SeatTransactionReservationCancellation') ) GROUP BY hall_elements.hall_plan_id UNION ALL SELECT -COUNT(DISTINCT hall_elements.id) AS count_all, hall_elements.hall_plan_id FROM hall_elements WHERE hall_elements.hall_plan_id IN ({$event['all_hall_plan_id']}) AND ( hall_elements.type = 'SeatUnmarked' ) AND ( (SELECT st.type FROM seat_transactions st WHERE st.seat_id = hall_elements.id AND st.created_at = (SELECT MAX(st2.created_at) FROM seat_transactions st2 WHERE st2.seat_id = hall_elements.id)) NOT IN ( E'SeatTransactionFree',E'SeatTransactionBookingCancellation', E'SeatTransactionBookingExpiry',E'SeatTransactionRefund', E'SeatTransactionReservationCancellation') ) GROUP BY hall_elements.hall_plan_id UNION ALL SELECT SUM(unmarked_seat_count) AS count_all, hall_areas.hall_plan_id FROM hall_areas WHERE hall_areas.hall_plan_id IN ({$event['all_hall_plan_id']}) GROUP BY hall_areas.hall_plan_id ) AS x GROUP BY hall_plan_id;");
                }
                $event['dates'] = get_col("SELECT to_char(time, 'DD.MM') AS aeg FROM events WHERE event_id='{$event['id']}' order by time");
                $event['locations'] = get_col("SELECT D.name FROM (hall_plans A JOIN events B ON A.id = B.hall_plan_id) JOIN halls C ON A.hall_id = C.id JOIN venues D ON C.venue_id = D.id WHERE B.state = 'on_sale' AND B.id='{$event['id']}'");
                $event['normalprices_min'] = get_one("SELECT MIN(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event['id']}'
                              AND E.state='on_sale'
                              AND M.type = 'NormalPrice'
                              AND M.valid_for_web_sales IS NOT FALSE
                              AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $event['normalprices_max'] = get_one("SELECT MAX(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event['id']}'
                              AND E.state='on_sale'
                              AND M.type = 'NormalPrice'
                              AND M.valid_for_web_sales IS NOT FALSE
                              AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $event['discountprices_min'] = get_one("SELECT MIN(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event['id']}'
                              AND E.state='on_sale'
                                AND M.type = 'PercentDiscount'
                                AND M.valid_for_web_sales IS NOT FALSE
                                AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");
                $event['discountprices_max'] = get_one("SELECT MAX(P.value) FROM events E
                            JOIN price_models M ON E.id = M.event_id
                            JOIN prices P ON P.price_model_id = M.id
                            WHERE E.event_id='{$event['id']}'
                              AND E.state='on_sale'
                                AND M.type = 'PercentDiscount'
                                AND M.valid_for_web_sales IS NOT FALSE
                                AND (E.web_sales_start IS NULL
                                   OR E.web_sales_start <= NOW())
                              AND ((E.time - (E.web_sales_end||' seconds')::interval) > NOW())");

                array_push($newArray, $event);
            }
        }
        $this->events = $newArray;
    }
}

