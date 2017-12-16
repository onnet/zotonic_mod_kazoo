{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={toggle target="rs_operations_account_lookup_widget_opened"}
        action={toggle target="arrow_right_"++#id}
        action={toggle target="arrow_down_"++#id}
        action={postback postback={trigger_innoui_widget arg="rs_operations_account_lookup_widget_opened"}
                         delegate="mod_kazoo"
               }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}"
       style="{% if m.kazoo[{ui_element_opened element="rs_operations_account_lookup_widget_opened"}] %}
                display: none;
              {% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}"
       style="{% if not m.kazoo[{ui_element_opened element="rs_operations_account_lookup_widget_opened"}] %}
                display: none;
              {% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
  {% button class="btn btn-xs btn-onnet pull-right"
            text=_"find account"
            action={postback postback="rs_operations_find_account"
                             qarg="search_string"
                             delegate="mod_kazoo"
                   }
  %}
  <input id="search_string"
         onkeydown="if (event.keyCode == 13) {z_event('search_string'); return false;}"
         class="input input-number-onnet pull-right"
         type="text"
         name="search_string">
  {% wire name="search_string"
          type="submit"
          action={postback postback="rs_operations_find_account"
                           qarg="search_string"
                           delegate="mod_kazoo"
                 }
  %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_operations_account_lookup_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="rs_operations_account_lookup_widget_opened"}] %}
              display: none;
            {% endif %}">
</div>
{% endblock %}
