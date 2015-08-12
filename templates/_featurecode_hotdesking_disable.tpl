{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="voicemail[action=check]"}] as voicemail_check %}
<div class="name"><span>{_ Check Voicemail _}</span></div>
<div id="featurecode_voicemail_check" class="input">
        <span class="add-on">*97</span>
        {% wire id="toggle_featurecode_voicemail_check" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_voicemail_check" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if voicemail_check %}
            <i id="toggle_featurecode_voicemail_check" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_voicemail_check" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
