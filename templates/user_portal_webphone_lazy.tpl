     {% wire id="start-webphone-form" type="submit" postback={start_webphone_form} delegate="mod_kazoo" %}
     <form id="start-webphone-form" method="post" action="postback" class="form">
       {% include "user_portal_webphone.tpl" headline=_"Webphone" %}
     </form>
