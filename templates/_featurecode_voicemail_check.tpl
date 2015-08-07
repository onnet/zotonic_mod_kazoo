{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="voicemail[action=check]"}] as voicemail_check %}
<div class="name"><span>{_ Check Voicemail _}</span></div>
<div id="featurecode_voicemail_check" class="input">
        <span class="add-on">* 97</span>
        {% if voicemail_check %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
        <i id="toggle_featurecode_voicemail_check" class="fa fa-refresh pointer" title="Change"></i>
        {% wire id="toggle_featurecode_voicemail_check" type="click" action={ postback postback="toggle_featurecode_voicemail_check" delegate="mod_kazoo"} %}
</div>
{% endwith %}
