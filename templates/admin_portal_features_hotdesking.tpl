{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_features_hotdesking_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_features_hotdesking_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="ap_features_hotdesking_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="ap_features_hotdesking_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_features_hotdesking_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="ap_features_hotdesking_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">

<div id="featurecode_form">
	<form>
                {% wire action={connect signal={signal_featurecode_hotdesking_enable} action={update target="featurecode_hotdesking_enable_id" template="_featurecode_hotdesking_enable.tpl"}} %}
		<div id="featurecode_hotdesking_enable_id" class="featurecode_line">
                    {% include "_featurecode_hotdesking_enable.tpl" %}
		</div>	
                {% wire action={connect signal={signal_featurecode_hotdesking_disable} action={update target="featurecode_hotdesking_disable_id" template="_featurecode_hotdesking_disable.tpl"}} %}
		<div id="featurecode_hotdesking_disable_id" class="featurecode_line">
                    {% include "_featurecode_hotdesking_disable.tpl" %}
		</div>	
                {% wire action={connect signal={signal_featurecode_hotdesking_toggle} action={update target="featurecode_hotdesking_toggle_id" template="_featurecode_hotdesking_toggle.tpl"}} %}
		<div id="featurecode_hotdesking_toggle_id" class="featurecode_line">
                    {% include "_featurecode_hotdesking_toggle.tpl" %}
		</div>	
	</form>
</div>


    </div>
</div>

{% print m.kazoo[{kz_get_featurecode_by_name featurecode_name="hotdesk[action=login]"}] %}
{% print m.kazoo[{kz_get_featurecode_by_name featurecode_name="hotdesk[action=logout]"}] %}
{% print m.kazoo[{kz_get_featurecode_by_name featurecode_name="hotdesk[action=toggle]"}] %}
{% endblock %}
