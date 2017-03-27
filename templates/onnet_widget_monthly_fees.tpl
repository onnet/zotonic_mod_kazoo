{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="current_services_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="current_services_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}"
       style="{% if m.kazoo[{ui_element_opened element="current_services_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}"
       style="{% if not m.kazoo[{ui_element_opened element="current_services_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    <span style="float:right; margin-right1: 0.5em">
      {_ Estimated total monthly cost _}:
      <span style="font-weight:bold; margin-left: 0.5em; margin-right: 1.2em">
        {{ m.onbill.kz_current_services[1]["total_amount"]|currency_sign }}
      </span>
    </span>
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="current_services_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="current_services_widget_opened"}] %}display: none;{% endif %}">
  <table class="table table-condensed table-hover table-centered">
    <thead>
      <tr>
        <th>{_ Fee name _}</th>
        <th class="text-center">{_ Rate _}</th>
        <th class="text-center">{_ Quantity _}</th>
        <th class="text-center">{_ Discount _}</th>
        <th class="text-center">{_ Cost _}</th>
      </tr>
    </thead>
    <tbody>
      {% for service_item in m.onbill.kz_current_services[1]["services_list"] %}
        <tr>
          <td>{{ service_item["name"] }}</td>
          <td class="text-center">{{ service_item["rate"]|currency_sign }}</td>
          <td class="text-center">{{ service_item["quantity"] }}</td>
          <td class="text-center">{{ service_item["total_discount"]|currency_sign }}</td>
          <td class="text-center">{{ service_item["discounted_item_cost"]|currency_sign }}</td>
        </tr>
      {% endfor %}
    </tbody>
  </table>
</div>
{% endblock %}
