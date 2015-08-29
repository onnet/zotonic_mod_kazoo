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
            <th>{% if account_doc[1]["enabled"] %}<span class="zprimary">{_ Active _}</span>
                            {% else %}<span class="zalarm">{_ Blocked _}{% endif %}</span>
            </th>
        </tr>
        <tr>
            <th>{_ Reseller status _}</th>
            <th>{% if account_doc[1]["is_reseller"] %}<span class="zprimary">{_ Activated _}</span>
                            {% else %}<span class="zalarm">{_ Not provided _}{% endif %}</span>
            </th>
        </tr>
        <tr>
            <th>{_ Numbers management _}</th>
            <th>{% if account_doc[1]["wnm_allow_additions"] %}<span class="zprimary">{_ Activated _}</span>
                            {% else %}<span class="zalarm">{_ Not activated _}{% endif %}</span>
            </th>
        </tr>
    </thead>
    <tbody>
        {% if m.modules.info.mod_bt.enabled %}
          <tr><td>{_ Current balance _}</td><td>£{{ m.kazoo.current_account_credit|format_price }}</td></tr>
        {% endif %}
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
</table>
{% endwith %}
{% endblock %}
