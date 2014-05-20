<div id="flash">
    <div class="flash_error alert alert-error"><?= $error_title ?></div>
</div>

<div class="errorExplanation" id="errorExplanation">
    <h2><?=count($this->errors)?> viga takistas valitud kliendi salvestamist</h2>

    <p>Viga järgmiste väljadega:</p>
    <ul>
        <? foreach ($this->errors as $error): ?>
            <li><?=$error?></li>
        <? endforeach ?>
    </ul>

</div>

