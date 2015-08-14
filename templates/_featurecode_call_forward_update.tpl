{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="call_forward[action=update]"}] as call_forward_update %}
<div class="name"><span>{_ Update Call-Forward _}</span></div>
<div id="featurecode_call_forward_update" class="input">
        <span class="add-on">*56</span>
        {% wire id="toggle_featurecode_call_forward_update" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_call_forward_update" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if call_forward_update %}
            <i id="toggle_featurecode_call_forward_update" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_call_forward_update" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
