<div id="flash">


</div>
<div id="contentArea">
    <? if (!empty($events)) foreach ($events as $event): ?>
        <div id="containers">
            <div id="container_1055" class="news-container">
                <div id="news_articles_of_container_1055" class="news_articles">


                    <div id="news_article_1140" class="news_article1 news_article"
                         data-url="https://www.piletimaailm.com/performances/46147-eile-nagin-ma-eestimaad">
                        <h1 id="news_article_1140_header" class="news_header"><a
                                href="https://www.piletimaailm.com/performances/46147-eile-nagin-ma-eestimaad"><?= $event['name'] ?></a>
                        </h1>

                        <div id="news_article_1140_image" class="news_imageleft">
                            <a id="news_article_1140_image_link"
                               href="https://www.piletimaailm.com/performances/46147-eile-nagin-ma-eestimaad">
                                <img src="https://www.piletimaailm.com/pictures/109970/show" alt=""/>
                            </a>
                        </div>

                        <div id="news_article_1140_content" class="news_content">
                            <?= $event['name2'] ?>
                            <?= $event['additional_information'] ?>
                        </div>
                        <div class="clear"></div>
                    </div>

                    <div class="clear"></div>
                </div>
                <div id="container_1055_foot" class="foot"></div>
            </div>

            <div id="foot"></div>
        </div>
    <? endforeach ?>
</div>