{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="voicemail[action=\"direct\"]"}] as voicemail_direct %}
<div class="name"><span>{_ Direct to Voicemail _}</span></div>
<div id="featurecode_voicemail_direct" class="input">
        <span class="add-on">**</span>
        {% if voicemail_direct %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
        <i id="toggle_featurecode_voicemail_direct" class="fa fa-refresh pointer" title="Change"></i>
        {% wire id="toggle_featurecode_voicemail_direct" type="click" action={ postback postback="toggle_featurecode_voicemail_direct" delegate="mod_kazoo"} %}
</div>
{% endwith %}
