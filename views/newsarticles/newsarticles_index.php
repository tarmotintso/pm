<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="content-language" content="et">
    <meta name="keywords"
          content="pilet, piletid, teater, kino, kontsert, teatripiletid, kontserdipiletid, laulupidu, tants, ballett, piletilevi, ticketpro">
    <meta name="description"
          content="Piletimaailm Online - piletite müük internetis. Piletid enamike Eesti teatrite etendustele, konstertidele ja muudele kultuurisündmustele.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Piletimaailm Online</title>


    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <script src="assets/components/javascripts/jquery-1-11-0.js" type="text/javascript"></script>
    <script src="assets/components/javascripts/jquery-ui-1-10-03-custom.js" type="text/javascript"></script>
    <script src="assets/components/javascripts/shop_base_1395698490.js" type="text/javascript"></script>

    <script src="assets/components/javascripts/calendar-et.js" type="text/javascript"></script>


    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600&subset=latin,cyrillic'
          rel='stylesheet' type='text/css'>
    <script language='JavaScript' type='text/javascript' src='https://www.piletimaailm.com/openads/adx.js'></script>

    <!-- GOOGLE ANALYTICS -->
    <script type="text/javascript">

		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-17153962-1']);
		_gaq.push(['_setDomainName', '.piletimaailm.com']);
		_gaq.push(['_trackPageview']);

		(function () {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();


    </script>
    <!-- END GOOGLE ANALYTICS -->
</head>
<body>

<div id="hideall" style="display:none;"></div>


<div id="banner">
    <div id="mainbanner">
        <script language='JavaScript' type='text/javascript'>
			<!--
			if (!document.phpAds_used) document.phpAds_used = ',';
			phpAds_random = new String(Math.random());
			phpAds_random = phpAds_random.substring(2, 11);

			document.write("<" + "script language='JavaScript' type='text/javascript' src='");
			document.write("https://www.piletimaailm.com/openads/adjs.php?n=" + phpAds_random);
			document.write("&amp;what=zone:3&amp;target=_self");
			document.write("&amp;exclude=" + document.phpAds_used);
			if (document.referrer)
				document.write("&amp;referer=" + escape(document.referrer));
			document.write("'><" + "/script>");
			//-->

        </script>
        <noscript><a href='https://www.piletimaailm.com/openads/adclick.php?n=a5d2b0b0'><img
                    src='https://www.piletimaailm.com/openads/adview.php?what=zone:3&amp;n=a5d2b0b0' border='0' alt=''/></a>
        </noscript>
    </div>
</div>

<div id="content">
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
        href="https://www.piletimaailm.com/performances/46147-eile-nagin-ma-eestimaad"><?= $event['name'] ?></a></h1>

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
</div>



</body>
</html>
