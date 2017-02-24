{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="reseller_registrations_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="reseller_registrations_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}"
       style="{% if m.kazoo[{ui_element_opened element="reseller_registrations_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}"
       style="{% if not m.kazoo[{ui_element_opened element="reseller_registrations_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}: {{ m.kazoo.get_reseller_registrations_count }}
  {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh" action={emit signal={reseller_registrations_widget_tpl} } %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="reseller_registrations_widget_opened"
     style='{% if not m.kazoo[{ui_element_opened element="reseller_registrations_widget_opened"}] %}display: none;{% endif %}'>
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="reseller_registrations_widget_opened"
                                template="reseller_registrations_table_body.tpl"
                        }
        %}
   </div>
</div>
{% endblock %}
