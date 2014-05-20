<div id="contentArea">
    <h1 class="first">Registreeru kliendiks</h1>
    <?= $errors2; ?>

    <form class="lahe-vorm" method="post">
        <label
            class="kohustuslik <?= is_null($errors[0]) && is_null($errors[1]) && is_null($errors[2]) && is_null($errors[8]) ? '' : 'error' ?>">E-mail</label>
        <input
            class="<?= is_null($errors[0]) && is_null($errors[1]) && is_null($errors[2]) && is_null($errors[8]) ? '' : 'error' ?>"
            id="client[email]" name="client[email]" type="text"><br>
        <label class="kohustuslik">Parool</label> <input id="client[password]" name="client[password]"
                                                         type="password"><br>
        <label class="kohustuslik">Parool teist korda</label> <input id="client[password_confirmation]"
                                                                     name="client[password_confirmation]"
                                                                     type="password"><br>
        <label <?= is_null($errors[3]) && is_null($errors[9]) ? '' : "class = 'error'" ?>>Telefon</label>
        <input <?= is_null($errors[3]) && is_null($errors[9]) ? '' : "class = 'error'" ?> id="client[phone]"
                                                                                          name="client[phone]"
                                                                                          type="text"><br>
        <label class="kohustuslik <?= is_null($errors[5]) && is_null($errors[10]) ? '' : 'error' ?>">Eesnimi</label>
        <input
            class="<?= is_null($errors[5]) && is_null($errors[10]) ? '' : 'error' ?>"
            id="client[first_name]"
            name="client[first_name]" type="text"><br>
        <label
            class="kohustuslik <?= is_null($errors[6]) && is_null($errors[11]) ? '' : 'error' ?>">Perekonnanimi</label>
        <input
            class="<?= is_null($errors[6]) && is_null($errors[11]) ? '' : 'error' ?>"
            id="client[last_name]"
            name="client[last_name]" type="text">
        <br>
        <br>
        <label class="form"></label>
        <input class="btn btn-default button" name="commit" type="submit" value="Registreeru">
    </form>
</div>
