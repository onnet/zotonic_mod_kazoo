{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table class="table table-condensed table-centered">
  <tbody>
    <tr>
      <th colspan="2">
        {% wire id="arrows_"++#id type="click"
                action={toggle target="contacts_widget_opened"}
                action={toggle target="arrow_right_"++#id}
                action={toggle target="arrow_down_"++#id}
                action={postback postback={trigger_innoui_widget arg="contacts_widget_opened"}
                                 delegate="mod_kazoo"
                       }
        %}
        <span id="arrows_{{ #id }}" style="cursor: pointer;">
          <i id="arrow_right_{{ #id }}"
             style="{% if m.kazoo[{ui_element_opened element="contacts_widget_opened"}] %}
                      display: none;
                    {% endif %}" 
             class="arrowpad fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #id }}"
             style="{% if not m.kazoo[{ui_element_opened element="contacts_widget_opened"}] %}
                      display: none;
                    {% endif %}" 
             class="arrowpad fa fa-arrow-circle-down"></i>
        </span>
          Contacts:
      </th>
    </tr>
  </tbody>
  <tbody id="contacts_widget_opened"
         style="border-top: 0px;
                {% if not m.kazoo[{ui_element_opened element="contacts_widget_opened"}] %}
                  display: none;
                {% endif %}">
    <tr>
      <td width="50%">Name</td>
      <td>
        {{ m.kazoo[{kz_user_doc_field field1="first_name"}] }}
        {{ m.kazoo[{kz_user_doc_field field1="last_name"}] }}
      </td>
    </tr>
    <tr>
      <td>E-mail</td>
      <td>{{ m.kazoo[{kz_user_doc_field field1="email"}] }}</td>
    </tr>
    <tr>
      <td>{_ Phone number _}</td>
      <td>
        {% if m.kazoo[{kz_user_doc_field field1="contact_phonenumber"}] %}
          {{ m.kazoo[{kz_user_doc_field field1="contact_phonenumber"}] }}
        {% else %}
          {{ m.kazoo[{kz_user_doc_field field1="call_forward" field2="number"}] }}
        {% endif %}
      </td>
    </tr>
  </tbody>
</table>
{% endblock %}
