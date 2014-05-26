<?php
require 'controllers/streams.php';
require 'controllers/gettext.php';
header('Content-type: text/html; charset=utf-8');
header('Cache-control: private'); // IE 6 FIX
if (isSet($_GET['lang'])) {
    $lang = $_GET['lang'];

// register the session and set the cookie
    $_SESSION['lang'] = $lang;

    setcookie('lang', $lang, time() + (3600 * 24 * 30));
} else if (isSet($_SESSION['lang'])) {
    $lang = $_SESSION['lang'];
} else if (isSet($_COOKIE['lang'])) {
    $lang = $_COOKIE['lang'];
} else {
    $lang = 'et_EE';
}
$streamer = new FileReader('locale/' . $lang . '/LC_MESSAGES/piletimaailm.mo');
$w = new gettext_reader($streamer, false);
 /*<?= $w->translate("Esileht");?> Näide!!!*/

?>