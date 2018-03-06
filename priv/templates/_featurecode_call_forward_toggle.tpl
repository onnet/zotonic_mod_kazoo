{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="call_forward[action=toggle]"}] as call_forward_toggle %}
<div class="name"><span>{_ Toggle Call-Forward _}</span></div>
<div id="featurecode_call_forward_toggle" class="input">
        <span class="add-on">*74</span>
        {% wire id="toggle_featurecode_call_forward_toggle" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_call_forward_toggle" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if call_forward_toggle %}
            <i id="toggle_featurecode_call_forward_toggle" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_call_forward_toggle" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
