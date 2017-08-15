{% with m.onbill[{onbill_get_variables account_id=account_id }]
   as onbill_variables
%}
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-left">{_ country_of_residence _}</th>
      <th class="text-left">
        <span id="country_of_residence">
          {% wire id="edit_country_of_residence"
                  type="click"
                  action={update target="country_of_residence"
                                 template="_edit_field_select.tpl"
                                 type="onbill_variables"
                                 field_name="country_of_residence"
                                 options=["ru","us","uk","ua"]
                         }
          %}
          <span>
            {{ onbill_variables[1]["country_of_residence"] }}
            <i id="edit_country_of_residence" class="fa fa-edit pointer" title="Edit field"></i>
          </span>
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ default_service_plan _}</th>
      <th class="text-left">
        <span id="default_service_plan">
          {% wire id="edit_default_service_plan"
                  type="click"
                  action={update target="default_service_plan"
                                 template="_edit_field_select.tpl"
                                 type="onbill_variables"
                                 field_name="default_service_plan"
                                 options=m.kazoo.kz_service_plans
                         }
          %}
          <span>
            {{ onbill_variables[1]["default_service_plan"] }}
            <i id="edit_default_service_plan" class="fa fa-edit pointer" title="Edit field"></i>
          </span>
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left" width=50%>{_ force_postpay_billing_day _}</th>
      <th class="text-left">
          <span id="force_postpay_billing_day">
            <i id="toggle_force_postpay_billing_day"
               class="fa
                      fa-toggle-{% if onbill_variables[1]["force_postpay_billing_day"] %}on{% else %}off{% endif %}
                      pointer"></i>
            {% wire id="toggle_force_postpay_billing_day"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name account_id}
                                     delegate="mod_kazoo"
                                     inject_args type="onbill_variables"
                                                 doc_id="_no_need_"
                                                 field_name="force_postpay_billing_day"
                                                 account_id=account_id
                           }
            %}
          </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ force_prepay_billing_day _}</th>
      <th class="text-left">
          <span id="force_prepay_billing_day">
            <i id="toggle_force_prepay_billing_day"
               class="fa
                      fa-toggle-{% if onbill_variables[1]["force_prepay_billing_day"] %}on{% else %}off{% endif %}
                      pointer"></i>
            {% wire id="toggle_force_prepay_billing_day"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name account_id}
                                     delegate="mod_kazoo"
                                     inject_args type="onbill_variables"
                                                 doc_id="_no_need_"
                                                 field_name="force_prepay_billing_day"
                                                 account_id=account_id
                           }
            %}
          </span>
      </th>
    </tr>
  </thead>
</table>
{# print onbill_variables #}
{% endwith %}
