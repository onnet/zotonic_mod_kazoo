{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="call_forward[action=deactivate]"}] as call_forward_deactivate %}
<div class="name"><span>{_ Disable Call-Forward _}</span></div>
<div id="featurecode_call_forward_deactivate" class="input">
        <span class="add-on">*73</span>
        {% wire id="toggle_featurecode_call_forward_deactivate" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_call_forward_deactivate" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if call_forward_deactivate %}
            <i id="toggle_featurecode_call_forward_deactivate" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_call_forward_deactivate" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
