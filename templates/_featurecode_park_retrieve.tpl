{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="retrieve"}] as retrieve %}
<div class="name"><span>{_ Retrieve _}</span></div>
<div id="featurecode_park_retrieve" class="input">
        <span class="add-on">*5</span>
        {% wire id="toggle_featurecode_park_retrieve" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_park_retrieve" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if retrieve %}
            <i id="toggle_featurecode_park_retrieve" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_park_retrieve" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
