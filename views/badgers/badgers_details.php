<? if (isset($_GET['update']) && $_GET['update'] == 'success'): ?>
<div id="flash">
    <div class="flash_notice alert alert-error">
        Andmed uuendatud
    </div>
</div>
<? endif ?>

<div id="contentArea">
    <h1 class="first"><?=$user['first_name'] . ' ' . $user['last_name'];?></h1>
    <span class="label">E-mail</span><span class="field"><?=$user['email']?></span><br>
    <span class="label">Telefon</span><span class="field"><?=$user['phone']?></span><br>
    <span class="label"></span><span class="field"><a href="<?=BASE_URL?>badgers/edit" class="btn btn-default">Muuda andmeid</a></span>
</div>