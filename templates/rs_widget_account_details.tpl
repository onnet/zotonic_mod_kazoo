{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh" id="child_area_refresh"
              action={update target="reseller_children_area" template="reseller_children.tpl" account_id=account_id headline=_"Account details"}
    %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"send message" id="child_area_send_message"
              action={dialog_open title=_"Send message to customer" template="rs_customer_udate.tpl" account_id=account_id}
    %}
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
        {% with m.notifier.first[{account_balance numbers=m.kazoo[{get_acc_numbers account_id=account_id}] }] as account_balance %}
        {% if account_balance and not account_doc[1]["is_reseller"] %}
        <tr>
            <th>{_ Current balance _}</th>
            <th>{% if not account_balance|match:"-" %}<span class="zprimary">{{ m.config.mod_kazoo.local_currency_sign.value }} {{ account_balance }}</span>
                            {% else %}<span class="zalarm">{{ m.config.mod_kazoo.local_currency_sign.value }} {{ account_balance }}</span>{% endif %}
            </th>
        </tr>
        {% endif %}
        {% endwith %}
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
          <tr><td>{_ Current balance _}</td><td>£{{ m.kazoo[{current_account_credit account_id=account_id}]|format_price }}</td></tr>
        {% endif %}
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
        <tr><th colspan="2">
            {% wire id="arrows_"++#id type="click"
                    action={ toggle target="rs_details_widget_opened" }
                    action={ toggle target="arrow_right_"++#id }
                    action={ toggle target="arrow_down_"++#id }
                    action={ postback postback={trigger_innoui_widget arg="rs_details_widget_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #id }}" style="cursor: pointer; padding-left: 0.7em;">
                <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
               {_ Details _}:
               {% button class="btn btn-xs btn-onnet pull-right" text=_"call restrictions" id="callrestrictionsbtn"
                         action={ dialog_open title=_"Account level call restrictions" template="admin_portal_account_restrictions.tpl" class="iamclass" account_id=account_id }
               %}
            </th>
        </tr>
    </tbody>
    <tbody id="rs_details_widget_opened" style="border-top: 0px;{% if not m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}display: none;{% endif %}">
        <tr><td>{_ Account name _}</td>
            <td><span id="name">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["name"] account_id=account_id %}
                </span>
            </td>
        </tr>
        <tr><td>{_ Date of creation _}</td><td>{{ account_doc[1]["created"]|inno_timestamp_to_date }}</td></tr>
        <tr><td>{_ Realm _}</td>
            <td><span id="realm">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["realm"] account_id=account_id %}
                </span>
               {% if not m.kazoo[{is_realms_synced account_id=account_id}] %}
                 {% button class="btn btn-xs btn-onnet pull-right" text=_"sync trunkstore"
                           action={postback postback={sync_trunkstore_realms account_id=account_id} delegate="mod_kazoo"}
                 %}
               {% endif %}
            </td>
        </tr>
        <tr><td>{_ Account ID _}</td><td>{{ account_id }}</td></tr>
        <tr><td>{_ Database _}</td><td>{{ account_id|account_id_to_encoded }}</td></tr>
        <tr><td>{_ Notify on de-register _}</td>
            <td><span id="notificationsderegistersend_to">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["notifications","deregister","send_to"] account_id=account_id %}
                </span>
            </td>
        </tr>
        <tr id="rs_outbound_routing">
         {% include "_rs_outbound_routing.tpl" account_id=account_id %}
        </tr>
    </tbody>
</table>
{% endwith %}
{% endblock %}
