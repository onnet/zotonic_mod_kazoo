{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
{% with m.kazoo[{kz_get_acc_doc_by_account_id account_id=account_id}] as account_doc %}
<table class="table table-condensed table-centered">
    <thead>
        <tr>
            <th>{_ Account status _}</th>
            <th>{% if m.kazoo[{kz_account_doc_field field1="enabled"}] %}<span class="zprimary">{_ Active _}</span>
                            {% else %}<span class="zalarm">{_ Blocked _}{% endif %}</span>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr><td>{_ Current balance _}</td><td>£{{ m.kazoo.current_account_credit|format_price }}</td></tr>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
        <tr><th colspan="2">
            {% wire id="arrows_"++#id type="click"
                    action={ toggle target="rs_details_widget_opened" }
                    action={ toggle target="arrow_right_"++#id }
                    action={ toggle target="arrow_down_"++#id }
                    action={ postback postback={trigger_innoui_widget arg="rs_details_widget_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #id }}" style="cursor: pointer;">
                <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
                Details:
            </th>
        </tr>
    </tbody>
    <tbody id="rs_details_widget_opened" style="border-top: 0px;{% if not m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}display: none;{% endif %}">
        <tr><td>{_ Account Name _}</td><td>{{ account_doc[1]["name"] }}</td></tr>
        <tr><td>{_ Realm _}</td><td>{{ account_doc[1]["realm"] }}</td></tr>
        <tr><td>{_ Account ID _}</td><td>{{ account_id }}</td></tr>
    </tbody>
    <tbody>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
        <tr><th colspan="2">
            {% wire id="arrows2_"++#id type="click"
                    action={ toggle target="rs_contacts_widget_opened" }
                    action={ toggle target="arrow2_right_"++#id }
                    action={ toggle target="arrow2_down_"++#id }
                    action={ postback postback={trigger_innoui_widget arg="rs_contacts_widget_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows2_{{ #id }}" style="cursor: pointer;">
                <i id="arrow2_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="rs_contacts_widget_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow2_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="rs_contacts_widget_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
                Contacts:
            </th>
        </tr>
    </tbody>
    <tbody id="rs_contacts_widget_opened" style="border-top: 0px;{% if not m.kazoo[{ui_element_opened element="rs_contacts_widget_opened"}] %}display: none;{% endif %}">
        <tr><td>Name</td><td>{{ m.kazoo[{kz_user_doc_field field1="first_name"}] }} {{ m.kazoo[{kz_user_doc_field field1="last_name"}] }}</td></tr>
        <tr><td>E-mail</td><td>{{ m.kazoo[{kz_user_doc_field field1="email"}] }}</td></tr>
        <tr><td>{_ Phone number _}</td>
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
{% endwith %}
{% endblock %}
