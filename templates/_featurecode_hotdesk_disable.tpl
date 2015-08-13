{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="hotdesk[action=logout]"}] as hotdesk_disable %}
<div class="name"><span>{_ Disable Hot-Desking _}</span></div>
<div id="featurecode_hotdesk_disable" class="input">
        <span class="add-on">*12</span>
        {% wire id="toggle_featurecode_hotdesk_disable" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_hotdesk_disable" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if hotdesk_disable %}
            <i id="toggle_featurecode_hotdesk_disable" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_hotdesk_disable" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
