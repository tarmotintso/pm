<div id="contentArea">
    <h1 class="first">Logi sisse</h1>

    <?= $errors2; ?>

    <form class="lahe-vorm" method="post">
        <label>E-mail</label> <input id="email" placeholder="username@mail.com" name="email"
                                                                                         type="text"><br>
        <label>Parool</label> <input id="password" placeholder="*******" name="password" type="password"><br>


        <br>
        <label class="form"></label>
        <input class="btn btn-default button" name="commit" type="submit" value="Logi sisse"><a
            href="<?= BASE_URL ?>password_reminders" class="btn btn-link">Taasta parool</a>
        <br>
    </form>

</div>
