{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="e911_addresses_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="e911_addresses_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="e911_addresses_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="e911_addresses_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="e911_addresses_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="e911_addresses_widget_opened"}] %}display: none;{% endif %}">
<table class="table table-condensed table-hover table-centered">
    <thead>
        <tr>
            <th class="text-center">{_ Zip _}</th>
            <th class="text-center">{_ City _}</th>
            <th class="text-center">{_ State _}</th>
            <th class="text-center">{_ Address _}</th>
            <th class="text-center">{_ Proven _}</th>
            <th class="text-center">{_ Doc _}</th>
        </tr>
    </thead>
    <tbody>
      {% for e911_address in m.onbill[{e911_addresses account_id=account_id}] %}
        <tr>
           <td class="text-center">{{ e911_address["zip"] }}</td>
           <td class="text-center">{{ e911_address["city"] }}</td>
           <td class="text-center">{{ e911_address["state"] }}</td>
           <td class="text-center">{{ e911_address["address"] }}</td>
           <td class="text-center">
             {% if e911_address["address_confirmed"] %}
               <i id="set_confirmed_{{ e911_address["id"] }}" class="fa fa-check-square-o pointer"></i>
             {% else %}
               <i id="set_not_confirmed_{{ e911_address["id"] }}" class="fa fa-square-o pointer"></i>
             {% endif %}
           </td>
           <td class="text-center">
             {% if e911_address["uploaded_doc"] %}
               <i id="download_uploaded_doc_{{ e911_address["id"] }}" class="fa fa-download pointer"></i>
             {% else %}
             {% endif %}
           </td>
        </tr>
      {% endfor %}
    </tbody>
</table>
</div>
{% endblock %}
