<div id="content">
    <div id="contentArea">
        <script>
            jQuery(document).ready(function () {
                initTimer();
            });

            function on_time_out() {
                hideEditor();
                show_time_out_message();
            }
        </script>

        <h1 class="first">Unustasid parooli?</h1>

        <p>Parooli taastamiseks sisestage palun oma e-maili aadress, mida kasutasite kliendiks registreerumisel.</p>

        <form action="/password_reminders" class="lahe-vorm" method="post"><label>E-mail</label>
            <input id="email" name="email" type="text"/><br/>

            <br/>
            <label class="form"></label>
            <input class="btn btn-default button" name="commit" type="submit" value="Saada"/>
        </form>
    </div>
</div>
