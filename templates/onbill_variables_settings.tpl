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
    <tr>
      <th class="text-left">{_ apply_discount_to_prorated _}</th>
      <th class="text-left">
          <span id="apply_discount_to_prorated">
            <i id="toggle_apply_discount_to_prorated"
               class="fa
                      fa-toggle-{% if onbill_variables[1]["apply_discount_to_prorated"] %}on{% else %}off{% endif %}
                      pointer"></i>
            {% wire id="toggle_apply_discount_to_prorated"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name account_id}
                                     delegate="mod_kazoo"
                                     inject_args type="onbill_variables"
                                                 doc_id="_no_need_"
                                                 field_name="apply_discount_to_prorated"
                                                 account_id=account_id
                           }
            %}
          </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ postpay_aggregate_invoice _}</th>
      <th class="text-left">
          <span id="postpay_aggregate_invoice">
            <i id="toggle_postpay_aggregate_invoice"
               class="fa
                      fa-toggle-{% if onbill_variables[1]["postpay_aggregate_invoice"] %}on{% else %}off{% endif %}
                      pointer"></i>
            {% wire id="toggle_postpay_aggregate_invoice"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name account_id}
                                     delegate="mod_kazoo"
                                     inject_args type="onbill_variables"
                                                 doc_id="_no_need_"
                                                 field_name="postpay_aggregate_invoice"
                                                 account_id=account_id
                           }
            %}
          </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ vat_disposition _}</th>
      <th class="text-left">
        <span id="vat_disposition">
          {% wire id="edit_vat_disposition"
                  type="click"
                  action={update target="vat_disposition"
                                 template="_edit_field_select.tpl"
                                 type="onbill_variables"
                                 field_name="vat_disposition"
                                 options=["netto","brutto"]
                         }
          %}
          <span>
            {{ onbill_variables[1]["vat_disposition"] }}
            <i id="edit_vat_disposition" class="fa fa-edit pointer" title="Edit field"></i>
          </span>
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ vat_rate _}</th>
      <th class="text-left">
        <span id="vat_rate">
          {% wire id="edit_vat_rate"
                  type="click"
                  action={update target="vat_rate"
                                 template="_edit_field_select.tpl"
                                 type="onbill_variables"
                                 field_name="vat_rate"
                                 options=["18","20"]
                         }
          %}
          <span>
            {% if onbill_variables[1]["vat_rate"] %}
              {{ onbill_variables[1]["vat_rate"] }}%
            {% endif %}
            <i id="edit_vat_rate" class="fa fa-edit pointer" title="Edit field"></i>
          </span>
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ currency_sign _}</th>
      <th class="text-left">
        <span id="currency_sign">
          {% wire id="edit_currency_sign"
                  type="click"
                  action={update target="currency_sign"
                                 template="_edit_field_select.tpl"
                                 type="onbill_variables"
                                 field_name="currency_sign"
                                 options=["₽ ","$","£"]
                         }
          %}
          <span>
            {{ onbill_variables[1]["currency_sign"] }}
            <i id="edit_currency_sign" class="fa fa-edit pointer" title="Edit field"></i>
          </span>
        </span>
      </th>
    </tr>
  </thead>
</table>
{# print onbill_variables #}
{% endwith %}
