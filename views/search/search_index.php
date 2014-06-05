<div id="flash">


</div>
<div id="contentArea"><h1 class="first">Leitud üritused</h1>

    <div class="search_header">
        <div id="search_results_selector">Näita nimekiri:
            <span>ürituste kaupa</span>
            <a href="/performances/timeline_search?from=&amp;performance%5Bfull_name_et%5D=mesa&amp;to=&amp;venue%5Bname%5D=">ajalises
                järjestuses</a>
        </div>

    </div>

    <div class="div_pager clearfix">
        <?
        echo $this->prevlink;
        if ($this->pages == 1) {
            echo '';
        } else {
            for ($i = 1; $i <= $this->pages; $i++) {
                if ($i == $this->page) {
                    echo '<span class="current_page">', $i, '</span>';
                } else {
                    echo '<a href="' . $_SERVER['PHP_SELF'] . '?page=' . $i . '">' . $i . '</a>';
                }
            }
        }
        echo $this->nextlink;

        ?>


    </div>

    <div class="eventlist">


        <? if (!empty($this->events)) foreach ($this->events as $event): ?>
            <div class="event eventtimeline odd row">

                <div class="col-md-8 col-xs-6">
                    <div class="event-title">
                        <h2>
                            <a href="https://www.piletimaailm.com/performances/32121-mesallianss"><?= $event['name'] ?></a>
                        </h2>

                    </div>

                    <div>

                        <a><?= $event['name2'] ?></a>
                        <br>
                        <a href="#"><?
                            $count_events = count($event['locations']);
                            for ($i = 0; $i < $count_events; $i++) {
                                echo $event['locations'][$i];
                            }
                            ?>
                        </a>


                    </div>
                </div>
                <div class="col-md-4 col-xs-6">
                    <div class="pull-right event-button">


                        <form method="get" action="https://www.piletimaailm.com/performances/32121-mesallianss"
                              class="button-to">
                            <div><input class="btn btn-default button" type="submit"
                                        value="Vali kuupäev ja osta pilet">
                            </div>
                        </form>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="col-md-12 col-xs-12 price-desc">

                    <div>
      <span class="nowrap">Tavahinnad: <strong>
              <?
              if (!($event['normalprices_min']) && !($event['normalprices_max'])) {
                  echo "-";
              } elseif ($event['normalprices_min'] == $event['normalprices_max']) {
                  echo $event['normalprices_min'] . " €";
              } else {
                  echo $event['normalprices_min'] . " - " . $event['normalprices_max'] . " €";
              }
              ?>
          </strong></span>,
      <span class="nowrap">Soodushinnad: <strong>
              <?
              if ($event['discountprices_min'] == null && $evente['discountprices_max'] == null) {
                  echo "-";
              } elseif ($event['discountprices_min'] == $event['discountprices_max']) {
                  echo $event['discountprices_min'] . " €";
              } else {
                  echo $event['discountprices_min'] . " - " . $event['discountprices_max'] . " €";
              }
              ?>
          </strong></span>
                    </div>
                </div>

                <div class="col-md-12">
    <span>Toimumisajad: <strong>
            <?

            $count_events = count($event['dates']);
            for ($i = 0; $i < $count_events; $i++) {
                if ($i < 8) {
                    if ($i == $count_events - 1 || $i == 7) {
                        echo $event['dates'][$i];
                    } else {
                        echo "{$event['dates'][$i]}, ";
                    }
                } else {
                    echo ' ... ';
                    echo $event['dates'][$count_events - 1];
                    $i = $count_events - 1;
                }
            }
            ?>


        </strong></span>
                </div>
            </div>
        <? endforeach ?>

        <div class="div_pager clearfix">
            <?
            echo $prevlink;
            if ($pages == 1) {
                echo '';
            } else {
                for ($i = 1;
                     $i <= $pages;
                     $i++) {
                    if ($i == $page) {
                        echo '<span class="current_page">', $i, '</span>';
                    } else {
                        echo '<a href="' . $_SERVER['PHP_SELF'] . '?page=' . $i . '">' . $i . '</a>';
                    }
                }
            }
            echo $nextlink;

            ?>


        </div>


    </div>


</div>