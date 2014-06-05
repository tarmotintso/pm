<div id="contentArea">
    <h1 class="first">Muuda andmeid</h1>
    <?= $errors2; ?>
    <form class="lahe-vorm" method="post">
        <div style="margin:0;padding:0">
        <input name="_method" type="hidden" value="put"></div>
        <label class="form" for="private_client_first_name">Eesnimi</label>
        <input id="private_client_first_name" name="private_client[first_name]" size="30" type="text"
               value=<?= $user['first_name'] ?>> <br>
        <label class="form" for="private_client_last_name">Perekonnanimi</label>
        <input id="private_client_last_name" name="private_client[last_name]" size="30" type="text"
               value=<?= $user['last_name'] ?>> <br>
        <label class="form" for="private_client_phone">Telefon</label>
        <input id="private_client_phone" name="private_client[phone]" size="30" type="text" value=<?= $user['phone'] ?>>
        <br>
        <br>
        <label class="form" for="private_client_"></label>
        <input class="btn btn-default button" name="contact_info_commit" type="submit" value="Salvesta muudatused">
    </form>

    <br>

    <h1 class="first">Muuda parooli</h1>

    <form class="lahe-vorm" id="edit_private_client" method="post">
        <div style="margin:0;padding:0"><input name="_method" type="hidden" value="put"></div>
        <label class="form" for="private_client_password">Parool</label>
        <input id="private_client_password" name="private_client[password]" size="30" type="password"> <br>
        <label class="form" for="private_client_password_confirmation">Parool uuesti</label>
        <input id="private_client_password_confirmation" name="private_client[password_confirmation]" size="30"
               type="password">
        <br>
        <br>
        <label class="form" for="private_client_"></label>
        <input class="btn btn-default button" name="password_commit" type="submit" value="Salvesta parool">
    </form>
</div>