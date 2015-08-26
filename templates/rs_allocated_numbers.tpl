{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="rs_numbers_list_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="rs_numbers_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="rs_numbers_list_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="rs_numbers_list_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"add number" id="addnumberbtn"
                         action={confirm text=_"Do you really want to add this number? <br />"
                              action={postback postback={rs_add_number account_id=account_id} qarg="new_number_id" delegate="mod_kazoo"}
                         }
    %}
    <input id="new_number_id" class="input input-number-onnet pull-right" type="text" name="new_number_to_add" placeholder="02071234567" maxlength="12">
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_numbers_list_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_numbers_list_widget_opened"}] %}display: none;{% endif %}">
<table id="rs_numbers_list_table" class="table table-condensed table-hover table-centered">
    {% include "rs_numbers_list_table_body.tpl" %}
</table>
</div>
{% endblock %}
