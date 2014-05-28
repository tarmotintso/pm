<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= PROJECT_NAME ?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css" rel="stylesheet">

    <style type="text/css">
        <!--
        .text {
            font-family: Trebuchet MS, Verdana, Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #000000;
        }

        .style3 {
            font-family: Trebuchet MS, Verdana, Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #000000;
            font-weight: bold;
        }

        -->
    </style>


</head>

<body>

<div class="container">
    <br/>
    <br/>
    <? if (isset($errors)): ?>
        <? foreach ($errors as $error): ?>
            <div class="alert alert-danger">
                <?= $error ?>
            </div>
        <? endforeach; ?>
    <? elseif (isset($error_file_name_or_msg)): ?>
        <? require 'views/alerts/' . $error_file_name_or_msg . '_error_view.php' ?>
    <?
    else: ?>
        Tundmatu viga!
    <? endif; ?>

</div>
<!-- /container -->

<div align="center"><a href="<?=BASE_URL?>"><img src="./assets/img/error.jpg" width="286" height="118"></a><span class="text"><br>

    </span>


    <p class="text">Viidatud addressile vastavat faili või teenust ei õnnestunud leida.</p>
    <br/>

    <p class="text">
        Kontrollige sisestatud aadressi või teavitage vea olemasolust Piletimaailma<br/>
        e-posti aadressile <a href="<?= BASE_URL ?>">piletimaailm@piletimaailm.com</a>,<br/>
        kuhu kirjutage sammud mis tegite enne kui siia lehele jõudsite. <br/>Lisage juurde ka enda kontaktandmed.<br>
        <br/>
        Aitäh!
    </p>
</div>


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>
