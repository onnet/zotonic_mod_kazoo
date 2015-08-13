{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="hotdesk[action=login]"}] as hotdesk_enable %}
<div class="name"><span>{_ Enable Hot-Desking _}</span></div>
<div id="featurecode_hotdesk_enable" class="input">
        <span class="add-on">*11</span>
        {% wire id="toggle_featurecode_hotdesk_enable" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_hotdesk_enable" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if hotdesk_enable %}
            <i id="toggle_featurecode_hotdesk_enable" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_hotdesk_enable" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
