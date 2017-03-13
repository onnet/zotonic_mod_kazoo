{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_features_transfer_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_features_transfer_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       style="{% if m.kazoo[{ui_element_opened element="ap_features_transfer_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="{% if not m.kazoo[{ui_element_opened element="ap_features_transfer_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_features_transfer_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="ap_features_transfer_widget_opened"}] %}display: none;{% endif %}">
  <div class="text-center p-3">
    <div id="featurecode_form">
      <form>
        {% wire action={connect signal={signal_featurecode_call_forward_activate session_id=m.session.session_id}
                                action={update target="featurecode_call_forward_activate_id"
                                               template="_featurecode_call_forward_activate.tpl"}
                       }
        %}
        <div id="featurecode_call_forward_activate_id" class="featurecode_line">
          {% include "_featurecode_call_forward_activate.tpl" %}
        </div>
        {% wire action={connect signal={signal_featurecode_call_forward_deactivate session_id=m.session.session_id}
                                action={update target="featurecode_call_forward_deactivate_id"
                                               template="_featurecode_call_forward_deactivate.tpl"}
                       }
        %}
        <div id="featurecode_call_forward_deactivate_id" class="featurecode_line">
          {% include "_featurecode_call_forward_deactivate.tpl" %}
        </div>
        {% wire action={connect signal={signal_featurecode_call_forward_toggle session_id=m.session.session_id}
                                action={update target="featurecode_call_forward_toggle_id"
                                               template="_featurecode_call_forward_toggle.tpl"}
                       }
        %}
        <div id="featurecode_call_forward_toggle_id" class="featurecode_line">
          {% include "_featurecode_call_forward_toggle.tpl" %}
        </div>
        {% wire action={connect signal={signal_featurecode_call_forward_update session_id=m.session.session_id}
                                action={update target="featurecode_call_forward_update_id"
                                               template="_featurecode_call_forward_update.tpl"}
                       }
        %}
        <div id="featurecode_call_forward_update_id" class="featurecode_line">
          {% include "_featurecode_call_forward_update.tpl" %}
        </div>
      </form>
    </div>
  </div>
</div>
{% endblock %}
