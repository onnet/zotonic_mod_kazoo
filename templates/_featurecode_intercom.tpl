{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="intercom"}] as intercom %}
<div class="name"><span>{_ Intercom _}</span></div>
<div id="featurecode_intercom" class="input">
        <span class="add-on">*0</span>
        {% wire id="toggle_featurecode_intercom" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_intercom" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if intercom %}
            <i id="toggle_featurecode_intercom" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_intercom" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
