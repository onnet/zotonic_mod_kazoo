{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_features_parking_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_features_parking_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       style="{% if m.kazoo[{ui_element_opened element="ap_features_parking_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="{% if not m.kazoo[{ui_element_opened element="ap_features_parking_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_features_parking_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="ap_features_parking_widget_opened"}] %}display: none;{% endif %}">
  <div class="text-center p-3">
    <div id="featurecode_form">
      <form>
        {% wire action={connect signal={signal_featurecode_park_and_retrieve signal_filter=m.kazoo.signal_filter}
                                action={update target="featurecode_park_and_retrieve_id"
                                               template="_featurecode_park_and_retrieve.tpl"}
                       }
        %}
        <div id="featurecode_park_and_retrieve_id" class="featurecode_line">
          {% include "_featurecode_park_and_retrieve.tpl" %}
        </div>
        {% wire action={connect signal={signal_featurecode_park_valet signal_filter=m.kazoo.signal_filter}
                                action={update target="featurecode_park_valet_id"
                                               template="_featurecode_park_valet.tpl"}
                       }
        %}
        <div id="featurecode_park_valet_id" class="featurecode_line">
          {% include "_featurecode_park_valet.tpl" %}
        </div>
        {% wire action={connect signal={signal_featurecode_park_retrieve signal_filter=m.kazoo.signal_filter}
                                action={update target="featurecode_park_retrieve_id"
                                               template="_featurecode_park_retrieve.tpl"}
                       }
        %}
        <div id="featurecode_park_retrieve_id" class="featurecode_line">
          {% include "_featurecode_park_retrieve.tpl" %}
        </div>
      </form>
    </div>
  </div>
</div>
{% endblock %}
