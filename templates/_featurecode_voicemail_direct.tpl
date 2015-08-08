{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="voicemail[action=\"direct\"]"}] as voicemail_direct %}
<div class="name"><span>{_ Direct to Voicemail _}</span></div>
<div id="featurecode_voicemail_direct" class="input">
        <span class="add-on">*97</span>
        {% wire id="toggle_featurecode_voicemail_direct" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_voicemail_direct" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if voicemail_direct %}
            <i id="toggle_featurecode_voicemail_direct" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_voicemail_direct" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
