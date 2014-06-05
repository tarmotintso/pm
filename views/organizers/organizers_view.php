<div id="flash">
</div>
<div id="contentArea">
    <h1 class="first"><?= "$title1 $title2" ?></h1>
    <? if (empty($this->event_pages)): ?>
        Ei leidnud ühtegi üritust
    <? else : ?>
        <div class="search_header">
            <div id="search_results_selector">Näita nimekiri:
                <span>ürituste kaupa</span>
                <a href="<?= BASE_URL ?>organizers/timeline/<?= $this->params[0] ?>-<?= toAscii($this->title2) ?>">ajalises
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
            <?
            foreach ($this->event_pages as $event_page):?>

                <div class="event eventtimeline odd row">

                    <div class="col-md-8 col-xs-6">
                        <div class="event-title">
                            <h2><?= $event_page['name'] ?></a></h2>
                        </div>
                        <div>

                            <a><?= $event_page['name2'] ?></a>
                            <br>
                            <a href="#"><?
                                $count_events = count($event_page['locations']);
                                for ($i = 0; $i < $count_events; $i++) {
                                    echo $event_page['locations'][$i];
                                }
                                ?>
                            </a>

                        </div>
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <div class="pull-right event-button">


                            <form method="get" action="https://www.piletimaailm.com/performances/41609-hortus-musicus"
                                  class="button-to">
                                <? if (!empty($event_page['seats']) && $event_page['seats'] != 0): ?>
                                    <div><input class="btn btn-default button" type="submit"
                                                value="Vali kuupäev ja osta pilet"></div>
                                <? else: ?>
                                    <div><input class="btn btn-white button" type="submit" value="Vaata toimumisaegu">
                                    </div>
                                <?endif; ?>
                            </form>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                    <div class="col-md-12 col-xs-12 price-desc">

                        <div>
      <span class="nowrap">Tavahinnad: <strong>
              <?
              if (!($event_page['normalprices_min']) && !($event_page['normalprices_max'])) {
                  echo "-";
              } elseif ($event_page['normalprices_min'] == $event_page['normalprices_max']) {
                  echo $event_page['normalprices_min'] . " €";
              } else {
                  echo $event_page['normalprices_min'] . " - " . $event_page['normalprices_max'] . " €";
              }
              ?>
          </strong></span>,
      <span class="nowrap">Soodushinnad: <strong>
              <?
              if ($event_page['discountprices_min'] == null && $event_page['discountprices_max'] == null) {
                  echo "-";
              } elseif ($event_page['discountprices_min'] == $event_page['discountprices_max']) {
                  echo $event_page['discountprices_min'] . " €";
              } else {
                  echo $event_page['discountprices_min'] . " - " . $event_page['discountprices_max'] . " €";
              }
              ?>
          </strong></span>
                        </div>
                    </div>

                    <div class="col-md-12">
    <span>Toimumisajad: <strong>
            <?

            $count_events = count($event_page['dates']);
            for ($i = 0; $i < $count_events; $i++) {
                if ($i < 8) {
                    if ($i == $count_events - 1 || $i == 7) {
                        echo $event_page['dates'][$i];
                    } else {
                        echo "{$event_page['dates'][$i]}, ";
                    }
                } else {
                    echo ' ... ';
                    echo $event_page['dates'][$count_events - 1];
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
    <? endif; ?>
</div>
