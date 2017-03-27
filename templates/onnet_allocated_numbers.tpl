{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="numbers_list_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="numbers_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}"
       style="{% if m.kazoo[{ui_element_opened element="numbers_list_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}"
       style="{% if not m.kazoo[{ui_element_opened element="numbers_list_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
  <i id="fix_allocated_numbers"
     style="padding-left: 0.5em;"
     class="fa fa-refresh pointer"
     title="{_ If you think some of the numbers are not displayed in the right category (Spare/In Service), you can use this feature to re-synchronize your numbers with the database _}."></i>
  {% wire id="fix_allocated_numbers"
          action={postback postback={fix_allocated_numbers account_id=account_id} delegate="mod_kazoo"}
  %}
  {% e911_reminder %}
  {% button class="btn btn-xs btn-onnet pull-right" text=_"purchase numbers" id="orderbtn"
            action={enable target="choose_number"}
            action={disable target="orderbtn"}
            action={enable target="cancelorderbtn"}
  %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="numbers_list_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="numbers_list_widget_opened"}] %}display: none;{% endif %}">
  <table id="numbers_list_table" class="table table-condensed table-hover table-centered">
    {% include "numbers_list_table_body.tpl" %}
  </table>
</div>
{% endblock %}

