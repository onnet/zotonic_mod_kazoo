{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_features_transfer_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_features_transfer_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="ap_features_transfer_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="ap_features_transfer_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_features_transfer_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="ap_features_transfer_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">

<div id="featurecode_form">
	<form>
		<div class="featurecode_line">
			<div class="name"><span>{_ Enable Call-Forward _}</span></div>
			<div id="feature_transfer_on" class="input">
				<span class="add-on">*</span>
				<input type="text" value="72" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>	
		<div class="featurecode_line">
			<div class="name"><span>{_ Disable Call-Forward _}</span></div>
			<div id="feature_transfer_off" class="input">
				<span class="add-on">*</span>
				<input type="text" value="73" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>	
		<div class="featurecode_line">
			<div class="name"><span>{_ Toggle Call-Forward _}</span></div>
			<div id="feature_transfer_switch" class="input">
				<span class="add-on">*</span>
				<input type="text" value="74" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>	
		<div class="featurecode_line">
			<div class="name"><span>{_ Update Call-Forward _}</span></div>
			<div id="feature_transfer_refresh" class="input">
				<span class="add-on">*</span>
				<input type="text" value="56" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>
	</form>
</div>

    </div>
</div>
{% endblock %}
