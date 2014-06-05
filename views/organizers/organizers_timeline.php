<div id="contentArea">
    <h1 class="first"><?= "$title1 $title2" ?></h1>

    <div class="search_header">
        <div id="search_results_selector">Näita nimekiri:
            <a href="<?= BASE_URL ?>organizers/<?= $this->params[0] ?>-<?= toAscii($this->title2) ?>">ürituste kaupa</a>

            <span>ajalises järjestuses</span>
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


        <? if (!empty($performances)) foreach ($performances as $performance): ?>
            <div class="event eventtimeline odd row">

                <div class="col-md-8 col-xs-6">
                    <div class="event-title">
                        <h2>
                            <div class="time">
                                <span
                                    class="date"><?= $performance['time_day'] . " " . $performance['time_date'] ?></span>
                                <?= $performance['time_clock'] ?>
                            </div>
                            <div class="title">
                                <a href="<?= BASE_URL ?>performances/<?= $performance['event_id'] ?>"><?= $performance['name'] ?></a>
                            </div>
                        </h2>

                    </div>

                    <div>
                        <?if (!($performance['locations']) && (($performance['name2']) != "")) {
                            $performance['locations'] = "";
                        } elseif (!($performance['locations']) && (($performance['name2']) == "")) {
                            $performance['locations'] = "";
                        } elseif ($performance['locations'] && (($performance['name2']) != "")) {
                            $performance['name2'] = $performance['name2'] . ", ";
                        }
                        ?>
                        <a href="<?= BASE_URL ?>performances/<?= $performance['event_id'] ?>"><?= $performance['name2'] . $performance['locations'] ?>
                            <br></a>


                    </div>
                </div>
                <div class="col-md-4 col-xs-6">
                    <div class="pull-right event-button">


                        <form method="get" action="<?= BASE_URL ?>performances/<?= $performance['event_id'] ?>"
                              class="button-to">
                            <div>
                                <? if (!empty($performance['seats']) && $performance['seats'] != 0): ?>
                                    <input type="submit" value="Osta pilet" class="btn btn-default pull-right button">
                                <? else : ?>
                                    <div class="sold-out">Välja müüdud!</div>
                                <?endif; ?>
                            </div>


                        </form>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="col-md-12 col-xs-12 price-desc">

                    <div>
                        <span class="nowrap">Vabu kohti: <strong>
                                <?
                                if (!($performance['seats'])) {
                                    echo "-";
                                } else {
                                    echo $performance['seats'];
                                }
                                ?>
                            </strong></span>,

                        <span class="nowrap">Tavahinnad: <strong>
                                <?
                                if (!($performance['normalprices'])) {
                                    echo "-";
                                } else {
                                    echo $performance['normalprices'] . " €";
                                }
                                ?>
                            </strong></span>,
                        <span class="nowrap">Soodushinnad: <strong>
                                <?
                                if (!($performance['discountprices'])) {
                                    echo "-";
                                } else {
                                    echo $performance['discountprices'] . " €";
                                }
                                ?>
                            </strong></span>
                    </div>
                </div>


            </div>
        <? endforeach ?>

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


    </div>
</div>
