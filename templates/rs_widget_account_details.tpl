{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh" id="child_area_refresh"
              action={update target="reseller_children_area" template="reseller_children.tpl" account_id=account_id headline=_"Account details"}
    %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"send message" id="child_area_send_message"
              action={dialog_open title=_"Send message to customer" template="rs_kz_customer_udate.tpl" account_id=account_id}
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
        {% with m.notifier.first[{account_balance numbers=m.kazoo[{get_acc_numbers account_id=account_id}] }] as account_data %}
        
        {% if account_data[1] and not account_doc[1]["is_reseller"] %}
        <tr>
            <th>{_ Current balance _}</th>
            <th>{% if not account_data[1]|match:"-" %}<span class="zprimary">{{ m.config.mod_kazoo.local_currency_sign.value }} {{ account_data[1] }}</span>
                            {% else %}<span class="zalarm">{{ m.config.mod_kazoo.local_currency_sign.value }} {{ account_data[1] }}</span>{% endif %}
            </th>
        </tr>
        {% endif %}
        {% endwith %}
        <tr>
            <th>{_ Reseller status _}</th>
            <th>{% if account_doc[1]["is_reseller"] %}
                  <span class="zprimary">{_ Activated _}</span>
                  {% if m.kazoo.kz_current_context_superadmin %}
                    <i id="reseller_status_toggler" class="fa fa-toggle-on pointer" style="float: right;" title="{_ Click to demote _}"></i>
                  {% endif %}
                {% else %}
                  <span class="zalarm">{_ Not provided _}</span>
                  {% if m.kazoo.kz_current_context_superadmin %}
                    <i id="reseller_status_toggler" class="fa fa-toggle-off pointer" style="float: right;" title="{_ Click to promote _}"></i>
                  {% endif %}
                {% endif %}
            </th>
            {% if m.kazoo.kz_current_context_superadmin %}
              {% wire id="reseller_status_toggler" type="click" action={postback postback={toggle_reseller_status account_id=account_id} delegate="mod_kazoo"} %}
            {% endif %}
        </tr>
        <tr>
            <th>{_ Numbers management _}</th>
            <th>{% if account_doc[1]["wnm_allow_additions"] %}<span class="zprimary">{_ Activated _}</span>
                            {% else %}<span class="zalarm">{_ Not activated _}{% endif %}</span>
            </th>
        </tr>
    </thead>
    {% if m.modules.info.mod_lb.enabled %}
     <tbody>
      {% with m.notifier.first[{account_balance numbers=m.kazoo[{get_acc_numbers account_id=account_id}] }] as account_data %}
        {% if account_data[2] and not account_doc[1]["is_reseller"] %}
          <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
          <tr>
            <td colspan=2>
              <span id="rs_set_lb_notify_level_tpl">
                {% include "rs_set_lb_notify_level.tpl" uid=account_data[2] %}
              </span>
            </td>
          </tr>
        {% endif %}
      {% endwith %}
     </tbody>
    {% endif %}
    <tbody>
        {% if m.modules.info.mod_bt.enabled %}
          <tr>
            <td>{_ Current balance _}</td>
            <td>
              £{{ m.kazoo[{current_account_credit account_id=account_id}]|format_price }}
                {% if m.modules.info.mod_bt.enabled %}
                  {% button class="btn btn-xs btn-onnet pull-right" text=_"add credit" id="child_area_add_credit"
                            action={dialog_open title=_"Add credit to "++account_doc[1]["name"] template="_rs_add_credit.tpl" account_id=account_id}
                  %}
                  {% button class="btn btn-xs btn-onnet pull-right" text=_"add debit" id="child_area_add_debit"
                            action={dialog_open title=_"Add debit to "++account_doc[1]["name"] template="_rs_add_debit.tpl" account_id=account_id}
                  %}
                {% endif %}
            </td>
          </tr>
        {% endif %}
    </tbody>
    <tbody>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
        <tr><th colspan="2">
            {% wire id="arrows_"++#spid type="click"
                    action={ toggle target="rs_service_plans_widget_opened" }
                    action={ toggle target="arrow_right_"++#spid }
                    action={ toggle target="arrow_down_"++#spid }
                    action={ postback postback={trigger_innoui_widget arg="rs_service_plans_widget_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #spid }}" style="cursor: pointer; padding-left: 0.7em;">
                <i id="arrow_right_{{ #spid }}" style="{% if m.kazoo[{ui_element_opened element="rs_service_plans_widget_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #spid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_service_plans_widget_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
               {_ Service plans _}:
               {% button class="btn btn-xs btn-onnet pull-right"
                         text=_"add service plan"
                         id="add_serviceplan_btn"
                         action={enable target="add_service_plan_tr_id"}
                         action={disable target="add_serviceplan_btn"}
               %}
            </th>
        </tr>
    </tbody>
    <tbody id="rs_service_plans_widget_opened" style="border-top: 0px;{% if not m.kazoo[{ui_element_opened element="rs_service_plans_widget_opened"}] %}display: none;{% endif %}">
        <tr id="add_service_plan_tr_id" class="disabled">
          <td colspan="2">
           {_ Choose service plan to add _}:
            <select id="selected_service_plan" name="selected_service_plan">
            {% for service_plan_available in m.kazoo.kz_service_plans_available %}
              <option name="service_plan_available" value="{{ service_plan_available["id"] }}">
                {{ service_plan_available["name"] }}
              </option>
            {% endfor %}
            </select>
           {% wire id="close_add_service_plan" action={enable target="add_serviceplan_btn"}
                                               action={disable target="add_service_plan_tr_id"}
           %}
           <span class="pull-right pl-15"><i id="close_add_service_plan" class="fa fa-times pointer"></i></span>
           {% button class="btn btn-xs btn-onnet pull-right" text=_"add chosen service plan"
                     action={confirm text=_"Do you really want to add service plan?"
                                     action={postback postback={add_chosen_service_plan account_id}
                                                      inject_args account_id=account_id
                                                      qarg="selected_service_plan"
                                                      delegate="mod_kazoo"
                                            }
                            }
           %}
          </td>
        </tr>
      {% for service_plan in m.kazoo[{kz_current_services account_id=account_id}][1]["plans"][1] %}
        {% with service_plan[1] as service_plan_id %}
        <tr>
          <td colspan="2">
            {{ service_plan_id }}
            {% wire id="delete_"++service_plan_id
                 action={confirm text=_"Do you really want to remove "++service_plan_id++" service plan?"
                    action={postback postback={remove_service_plan_from_account account_id service_plan_id}
                                      inject_args account_id=account_id service_plan_id=service_plan_id
                                      delegate="mod_kazoo"
                           }
                         }
            %}
            <i id="delete_{{ service_plan_id }}" class="fa fa-trash-o pointer pull-right" title="{_ Delete _}"></i>
          </td>
        </tr>
        {% endwith %}
      {% endfor %}
    </tbody>
    <tbody>
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
