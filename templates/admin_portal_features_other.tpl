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
                {% wire action={connect signal={signal_featurecode_voicemail_check} action={update target="featurecode_voicemail_check_id" template="_featurecode_voicemail_check.tpl"}} %}
		<div id="featurecode_voicemail_check_id" class="featurecode_line">
                    {% include "_featurecode_voicemail_check.tpl" %}
		</div>	
                {% wire action={connect signal={signal_featurecode_voicemail_direct} action={update target="featurecode_voicemail_direct_id" template="_featurecode_voicemail_direct.tpl"}} %}
		<div id="featurecode_voicemail_direct_id" class="featurecode_line">
                    {% include "_featurecode_voicemail_direct.tpl" %}
		</div>	
                {% wire action={connect signal={signal_featurecode_intercom} action={update target="featurecode_intercom_id" template="_featurecode_intercom.tpl"}} %}
		<div id="featurecode_intercom_id" class="featurecode_line">
                    {% include "_featurecode_intercom.tpl" %}
		</div>	
                {% wire action={connect signal={signal_featurecode_privacy} action={update target="featurecode_privacy_id" template="_featurecode_privacy.tpl"}} %}
		<div id="featurecode_privacy_id" class="featurecode_line">
                    {% include "_featurecode_privacy.tpl" %}
		</div>	
                {% wire action={connect signal={signal_featurecode_dynamic_cid} action={update target="featurecode_dynamic_cid_id" template="_featurecode_dynamic_cid.tpl"}} %}
		<div id="featurecode_dynamic_cid_id" class="featurecode_line">
                    {% include "_featurecode_dynamic_cid.tpl" %}
		</div>	
	</form>
</div>


    </div>
</div>

{% endblock %}
