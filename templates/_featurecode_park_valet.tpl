{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="valet"}] as valet %}
<div class="name"><span>{_ Valet _}</span></div>
<div id="featurecode_park_valet" class="input">
        <span class="add-on">*4</span>
        {% wire id="toggle_featurecode_park_valet" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_park_valet" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if valet %}
            <i id="toggle_featurecode_park_valet" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_park_valet" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
