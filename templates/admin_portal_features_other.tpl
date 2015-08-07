{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_features_other_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_features_other_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="ap_features_other_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="ap_features_other_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_features_other_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="ap_features_other_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">

<div id="featurecode_form">
	<form>
		<div class="featurecode_line">
			<div class="name"><span>{_ Check Voicemail _}</span></div>
			<div id="feature_check_voicemail" class="input">
				<span class="add-on">*</span>
				<input type="text" value="97" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>	
		<div class="featurecode_line">
			<div class="name"><span>{_ Direct to Voicemail _}</span></div>
			<div id="feature_direct_voicemail_call" class="input">
				<span class="add-on">*</span>
				<input type="text" value="*" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>	
		<div class="featurecode_line">
			<div class="name"><span>{_ Intercom _}</span></div>
			<div id="feature_intercom" class="input">
				<span class="add-on">*</span>
				<input type="text" value="0" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>	
		<div class="featurecode_line">
			<div class="name"><span>{_ Privacy _}</span></div>
			<div id="feature_privacy_protect" class="input">
				<span class="add-on">*</span>
				<input type="text" value="67" disabled="disabled" class="feature_code">
				<input type="checkbox" class="featurecode_enabled">
			</div>
		</div>
	</form>
</div>


    </div>
</div>
{% endblock %}
