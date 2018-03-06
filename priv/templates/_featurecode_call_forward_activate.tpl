{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="call_forward[action=activate]"}] as call_forward_activate %}
<div class="name"><span>{_ Enable Call-Forward _}</span></div>
<div id="featurecode_call_forward_activate" class="input">
        <span class="add-on">*72</span>
        {% wire id="toggle_featurecode_call_forward_activate" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_call_forward_activate" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if call_forward_activate %}
            <i id="toggle_featurecode_call_forward_activate" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_call_forward_activate" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
