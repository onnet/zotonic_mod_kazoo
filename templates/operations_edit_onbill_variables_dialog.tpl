<span id="operations_edit_onbill_variables_dialog_span">
{% wire action={connect signal={operations_edit_onbill_variables_dialog_signal signal_filter=m.kazoo.signal_filter}
                        action={replace target="operations_edit_onbill_variables_dialog_span"
                                       template="operations_edit_onbill_variables_dialog.tpl"
                                       account_id=account_id
                               }
               }
%}
{% with
     m.onbill[{onbill_get_variables account_id=account_id }],
     m.onbill[{onbill_get_variables account_id=m.session.kazoo_account_id}]
   as
     account_onbill_variables,
     reseller_onbill_variables
%}
{# print onbill_variables #}
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Agreement holder name _}
      </th>
      <th class="text-left">
        <span id="account_name">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["account_name"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ INN _}</th>
      <th class="text-left">
        <span id="account_inn">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["account_inn"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ KPP _}</th>
      <th class="text-left">
        <span id="account_kpp">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["account_kpp"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Billing address line 1 _}</th>
      <th class="text-left">
        <span id="billing_addressline1">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["billing_address","line1"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Billing address line 2 _}</th>
      <th class="text-left">
        <span id="billing_addressline2">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["billing_address","line2"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Billing address line 3 _}</th>
      <th class="text-left">
        <span id="billing_addressline3">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["billing_address","line3"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
  </thead>
</table>
<br />
<span style="font-size: 1.2em; ">{_ Agreements _}:</span>
  <select id="selected_carrier_to_add"
          name="selected_carrier_to_add"
          data-width="fit"
          data-live-search="true"
          class="btn-xs btn-onnet pull-left1 pr-1">
    <option selected disabled>{_ add _}</option>
    {% for carrier_id in reseller_onbill_variables[1]["carriers"] %}
      {% if account_onbill_variables[1]["agrm"][1][carrier_id]|is_undefined %}
        <option value="{{ carrier_id }}">{{ carrier_id }}</option>
      {% endif %}
    {% endfor %}
  </select>
  {% wire id="selected_carrier_to_add"
          type="change"
          action={insert_bottom target="carrier_agrm_table_th"
                                template="operations_edit_onbill_variables_carrier_select_var.tpl"
                                account_id=account_id
                 }
  %}

<table class="table table-condensed table-hover table-centered"
       style="margin1: 0.5em!important; width=100%;">
  <thead id="carrier_agrm_table_th">
    {% for carrier in account_onbill_variables[1]["agrm"][1] %}
      {% include "operations_edit_onbill_variables_carrier_select_var.tpl" carrier=carrier[1] account_id=account_id %}
    {% endfor %}
  </thead>
</table>
<br />
<p style="font-size: 1.2em; ">{_ Groups _}:</p>
<span style="display: inline-block;">
    {% for group_id in reseller_onbill_variables[1]["accounts_groups"] %}
      <i id="toggle_group_{{ group_id }}"
         style="padding: 0.5em;"
         class="fa fa-toggle-off">
        <span style="padding: 0.5em; font-weight: bolder;">
          {{ group_id }}
       </span>
      </i>
    {% endfor %}
</span>

<table class="table table-condensed table-hover table-centered"
       style="margin1: 0.5em!important; width=100%;">
  <thead id="accounts_groups_table_th">
    {% for group in account_onbill_variables[1]["accounts_groups"][1] %}
      {% include "operations_edit_onbill_variables_carrier_select_var.tpl" carrier=carrier[1] account_id=account_id %}
    {% endfor %}
  </thead>
</table>
{% endwith %}
</span>
