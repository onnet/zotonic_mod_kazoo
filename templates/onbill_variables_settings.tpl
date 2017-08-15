{% with m.onbill[{onbill_get_variables account_id=account_id }]
   as onbill_variables
%}
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-center">
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
      <th class="text-left">{_ force_postpay_billing_day _}</th>
      <th class="text-center">
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
      <th class="text-left">{_ force_prepay_billing_day _}</th>
    </tr>
  </thead>
</table>
{# print onbill_variables #}
{% endwith %}
