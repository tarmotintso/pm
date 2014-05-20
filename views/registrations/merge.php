<!--<div id="content">-->
<!--    <div id="flash">-->
<!--    </div>-->
<!--    <div id="contentArea">-->
<!---->
<!--<!--        <h1 class="first">-->--><%////= _("Kontode liitmine") %><!--<!--</h1>-->-->
<!--<!---->-->
<!--<!--        -->--><%////= _("Sama e-mailiga on juba pileteid ostetud, need kontod liidetakse üheks.") %><!--<!--<br/>-->-->
<!--<!---->-->
<!--<!--        <p>-->-->
<!--<!--            -->--><%//// @clients . each do |client | %>
<!--<!--            -->--><%////= client . first_name %><!--<!-- -->--><%////= client . last_name %><!--<!-- -->--><%////= client . phone %><!--<!--<br/>-->-->
<!--<!--            -->--><%//// end %>
<!--<!--        </p>-->-->
<!--<!---->-->
<!--<!--        -->--><%//// form_tag(merge_registrations_path) do %>
<!--<!--        -->--><%////= hidden_field_tag("client_id", @client . id) %>
<!--<!--        -->--><%//// if params[:performance_id] != nil %>
<!--<!--        -->--><%////= hidden_field_tag("performance_id", params[:performance_id]) %>
<!--<!--  -->--><%//// end %>
<!--<!--  -->--><%////= submit_tag(_("Liida kontod"), :class => "btn btn-default") %>
<%//// end %>
<!---->
<!---->
<!--    </div>-->
<!--</div>-->