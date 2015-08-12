{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="privacy[mode=full]"}] as privacy %}
<div class="name"><span>{_ Privacy _}</span></div>
<div id="featurecode_privacy" class="input">
        <span class="add-on">*67</span>
        {% wire id="toggle_featurecode_privacy" type="click" action={confirm text=_"Do you really want to change this setting?" 
                                                                             action={ postback postback="toggle_featurecode_privacy" delegate="mod_kazoo"}
                                                                            }
        %}
        {% if privacy %}
            <i id="toggle_featurecode_privacy" class="fa fa-check-circle pointer" title="Enabled"></i>
        {% else %}
            <i id="toggle_featurecode_privacy" class="fa fa-ban pointer" title="Disabled"></i>
        {% endif %}
</div>
{% endwith %}
