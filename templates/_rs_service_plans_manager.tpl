{% with m.session.rs_selected_account_id as account_id %}
<table class="table table-condensed table-centered">
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
                         text=_"reconcile"
                         id="reconcile_services_btn"
                         action={confirm text=_"Do you really want to reconcile services?"
                                         action={postback postback={reconcile_account_services account_id=account_id} delegate="mod_kazoo"}
                                }
               %}
               {% button class="btn btn-xs btn-onnet pull-right"
                         text=_"sync"
                         id="sync_services_btn"
                         action={confirm text=_"Do you really want to sync services?"
                                         action={postback postback={sync_account_services account_id=account_id} delegate="mod_kazoo"}
                                }
               %}
               {% button class="btn btn-xs btn-onnet pull-right"
                         text=_"add plan"
                         id="add_serviceplan_btn"
                         action={enable target="add_service_plan_tr_id"}
                         action={disable target="add_serviceplan_btn"}
               %}
               {% button class="btn btn-xs btn-onnet pull-right"
                         text=_"current services"
                         action={dialog_open title=_"Current services details"
                                     template="_details.tpl"
                                     arg=m.kazoo[{kz_current_service_plans account_id=account_id}]
                                     width="auto"
                         }

               %}
            </th>
        </tr>
    </tbody>
    <tbody id="rs_service_plans_widget_opened"
           style="border-top: 0px;{% if not m.kazoo[{ui_element_opened element="rs_service_plans_widget_opened"}] %}display: none;{% endif %}"
    >
        <tr id="add_service_plan_tr_id" class="disabled">
          <td colspan="2">
           {_ Choose service plan to add _}:
            <select id="selected_service_plan" name="selected_service_plan">
            {% for service_plan_available in m.kazoo[{kz_service_plans_available account_id=account_id}] %}
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
                                     action={postback postback={add_chosen_service_plan account_id=account_id}
                                                      qarg="selected_service_plan"
                                                      delegate="mod_kazoo"
                                            }
                            }
           %}
          </td>
        </tr>
      {% for service_plan in m.kazoo[{kz_current_service_plans account_id=account_id}][1]["plans"][1] %}
        {% with service_plan[1], m.kazoo[{service_plan plan_id=service_plan[1]}] as service_plan_id, service_plan_doc %}
        <tr>
          <td colspan="2">
            <span style="margin-left: 0.7em">{{ forloop.counter }}.</span>
            {{ service_plan_doc[1]["name"] }}
            {% if service_plan_doc[1]["description"] %}
              - {{ service_plan_doc[1]["description"] }}
            {% endif %}
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
</table>
{% endwith %}
