{% with m.kazoo[{kz_get_acc_doc_by_account_id account_id=account_id}] as account_doc %}
<table class="table table-condensed table-centered">
  <tbody>
    <tr style="height: 10px; color: white!important; background-color: white!important;">
      <td colspan="2"></td>
    </tr>
    <tr>
      <th colspan="2">
        {% wire id="arrows_"++#id type="click"
                action={toggle target="rs_details_widget_opened"}
                action={toggle target="arrow_right_"++#id}
                action={toggle target="arrow_down_"++#id}
                action={postback postback={trigger_innoui_widget arg="rs_details_widget_opened"}
                                 delegate="mod_kazoo"
                       }
        %}
        <span id="arrows_{{ #id }}" style="cursor: pointer; padding-left: 0.7em;">
          <i id="arrow_right_{{ #id }}"
             {% if m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}
               style="display: none;"
             {% endif %}
             class="arrowpad fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #id }}"
             {% if not m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}
               style="display: none;"
             {% endif %}
             class="arrowpad fa fa-arrow-circle-down"></i>
        </span>
        {_ Details _}:
        {% button class="btn btn-xs btn-onnet pull-right" text=_"controls"
                  action={dialog_open title=_"Restrictions setup"
                                      template="_edit_account_access_restrictions.tpl"
                                      account_id=account_id
                                      show_pvt_limits_li="true"
                         }
        %}
      </th>
    </tr>
  </tbody>
  <tbody id="rs_details_widget_opened"
         style="border-top: 0px;
                {% if not m.kazoo[{ui_element_opened element="rs_details_widget_opened"}] %}
                  display: none;
                {% endif %}">
    <tr>
      <td>
        {_ Date of creation _}
      </td>
      <td>
        {{ account_doc[1]["created"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}
      </td>
    </tr>
    <tr>
      <td>
        {_ Realm _}
      </td>
      <td>
        <span id="realm">
          {% include "_show_field.tpl" type="account"
                                       doc_id="_no_need_"
                                       field_name=["realm"]
                                       account_id=account_id
          %}
        </span>
          {% if not m.kazoo[{is_realms_synced account_id=account_id}] %}
            {% button class="btn btn-xs btn-onnet pull-right"
                      text=_"sync trunkstore"
                      action={postback postback={sync_trunkstore_realms account_id=account_id}
                                       delegate="mod_kazoo"
                             }
            %}
          {% endif %}
        </td>
    </tr>
    <tr>
      <td>{_ Account ID _}</td>
      <td>{{ account_id }}</td>
    </tr>
    <tr>
      <td>{_ Database _}</td>
      <td>{{ account_id|account_id_to_encoded }}</td>
    </tr>
    <tr>
      <td>{_ Notify on de-register _}</td>
      <td>
        <span id="notificationsderegistersend_to">
          {% include "_show_field.tpl" type="account"
                                       doc_id="_no_need_"
                                       field_name=["notifications","deregister","send_to"]
                                       account_id=account_id
          %}
        </span>
      </td>
    </tr>
    <tr id="rs_outbound_routing">
     {% include "_rs_outbound_routing.tpl" account_id=account_id %}
    </tr>
  </tbody>
</table>
{% if m.session.display_billing %}
<table class="table table-condensed table-centered">
  <tbody>
    <tr style="height: 10px; color: white!important; background-color: white!important;">
      <td colspan="5"></td>
    </tr>
    <tr>
      <th colspan="5">
        {% wire id="arrows_"++#currservid type="click"
                action={toggle target="rs_account_current_services_widget_opened" }
                action={toggle target="arrow_right_"++#currservid }
                action={toggle target="arrow_down_"++#currservid }
                action={postback postback={trigger_innoui_widget arg="rs_account_current_services_widget_opened"}
                                 delegate="mod_kazoo"
                       }
        %}
        <span id="arrows_{{ #currservid }}" style="cursor: pointer; padding-left: 0.7em;">
          <i id="arrow_right_{{ #currservid }}"
             {% if m.kazoo[{ui_element_opened element="rs_account_current_services_widget_opened"}] %}
               style="display: none;"
             {% endif %}
             class="arrowpad fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #currservid }}"
             {% if not m.kazoo[{ui_element_opened element="rs_account_current_services_widget_opened"}] %}
               style="display: none;"
             {% endif %}
             class="arrowpad fa fa-arrow-circle-down"></i>
        </span>
        {_ Current services _}:
        <span style="float:right; margin-right1: 0.5em">
          {_ Estimated total monthly cost _}:
          <span style="font-weight:bold; margin-left: 0.5em; margin-right: 1em">
            {{ m.onbill[{kz_current_services account_id=account_id}][1]["total_amount"]|currency_sign }}
          </span>
        </span>
      </th>
    </tr>
  </tbody>
  <tbody id="rs_account_current_services_widget_opened"
         style="border-top: 0px;
                {% if not m.kazoo[{ui_element_opened element="rs_account_current_services_widget_opened"}] %}
                  display: none;
                {% endif %}">

      <tr>
        <th>{_ Fee name _}</th>
        <th class="text-center">{_ Rate _}</th>
        <th class="text-center">{_ Quantity _}</th>
        <th class="text-center">{_ Discount _}</th>
        <th class="text-center">{_ Cost _}</th>
      </tr>
      {% for service_item in m.onbill[{kz_current_services account_id=account_id}][1]["services_list"] %}
        <tr>
          <td>{{ service_item[1]["name"] }}</td>
          <td class="text-center">{{ service_item[1]["rate"]|currency_sign }}</td>
          <td class="text-center">{{ service_item[1]["quantity"] }}</td>
          <td class="text-center">{{ service_item[1]["total_discount"]|currency_sign }}</td>
          <td class="text-center">{{ service_item[1]["discounted_item_cost"]|currency_sign }}</td>
        </tr>
      {% endfor %}
  </tbody>
</table>
{% endif %}
{% endwith %}
