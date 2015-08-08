{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="park_and_retrieve"}] as park_and_retrieve %}
<div class="name"><span>{_ Park and Retrieve _}</span></div>
<div id="featurecode_park_and_retrieve" class="input">
        <span class="add-on">*3</span>
        {% wire id="toggle_featurecode_park_and_retrieve" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_park_and_retrieve" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if park_and_retrieve %}
            <i id="toggle_featurecode_park_and_retrieve" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_park_and_retrieve" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
