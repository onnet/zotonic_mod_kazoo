<span id="operations_edit_onbill_variables_dialog_span">
{% wire action={connect signal={operations_edit_onbill_variables_dialog_signal signal_filter=m.kazoo.signal_filter account_id=account_id}
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
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Customer type _}</th>
      <th class="text-left">
       <span id="{{ account_id }}customer_type">
          {% include "_show_field_select.tpl" type="onbill_variables"
                                              doc_id="_no_need_"
                                              field_name=["customer_type"]
                                              options=["corporate", "personal"]
                                              prefix=account_id
          %}
       </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Agreement holder name _}
      </th>
      <th class="text-left">
        <span id="{{ account_id }}account_name">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["account_name"]
                                       account_id=account_id
                                       prefix=account_id
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
      <th class="text-left">{_ OGRN _}</th>
      <th class="text-left">
        <span id="account_ogrn">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["account_ogrn"]
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
<span style="font-size: 1.2em; ">{_ Agreement data _}:</span>
<br />
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Full type _}</th>
      <th class="text-left">
       <span id="{{ account_id }}full_type">
          {% include "_show_field_select.tpl" type="onbill_variables"
                                              doc_id="_no_need_"
                                              field_name=["full_type"]
                                              options=["Общество с ограниченной ответственностью"
                                                      ,"Закрытое акционерное общество"
                                                      ]
                                              prefix=account_id
          %}
       </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Short Name  _}</th>
      <th class="text-left">
        <span id="short_name">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["short_name"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Director (short) _}</th>
      <th class="text-left">
        <span id="gen_dir_u">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["gen_dir_u"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ in person (for a contract)  _}</th>
      <th class="text-left">
        <span id="vlice">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["vlice"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Director title _}</th>
      <th class="text-left">
       <span id="{{ account_id }}dir_type">
          {% include "_show_field_select.tpl" type="onbill_variables"
                                              doc_id="_no_need_"
                                              field_name=["dir_type"]
                                              options=["agreement_data", "director_type"]
                                              prefix=account_id
          %}
       </span>
      </th>
    </tr>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Director title (genitive) _}</th>
      <th class="text-left">
       <span id="{{ account_id }}dir_type_rod">
          {% include "_show_field_select.tpl" type="onbill_variables"
                                              doc_id="_no_need_"
                                              field_name=["dir_type_rod"]
                                              options=["agreement_data", "director_type"]
                                              prefix=account_id
          %}
       </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Legal basis (genitive) _}</th>
      <th class="text-left">
        <span id="act_on_what">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["act_on_what"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Chief Accountant _}</th>
      <th class="text-left">
        <span id="gl_buhg_u">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["gl_buhg_u"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Phone _}</th>
      <th class="text-left">
        <span id="phone">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["phone"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Fax _}</th>
      <th class="text-left">
        <span id="fax">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["fax"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Email _}</th>
      <th class="text-left">
        <span id="email">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["email"]
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
      {% include "operations_edit_onbill_variables_carrier_select_var.tpl"
                 carrier=carrier[1]
                 account_id=account_id
      %}
    {% endfor %}
  </thead>
</table>
<br />
<p style="font-size: 1.2em; ">{_ Account groups _}:</p>
<span style="display: inline-block;">
  {% for group_id in reseller_onbill_variables[1]["accounts_groups"] %}
    <i id="toggle_group_{{ group_id }}"
       style="padding: 0.5em;"
       class="fa
              fa-toggle-{% if account_onbill_variables[1]["accounts_groups"][1][group_id] %}on{% else %}off{% endif %}
              pointer">
      <span style="padding: 0.5em; font-weight: bolder;">
        {{ group_id }}
      </span>
    </i>
    {% wire id="toggle_group_"++group_id
            type="click"
            action={postback postback={toggle_field type doc_id field_name account_id}
                             delegate="mod_kazoo"
                             inject_args type="onbill_variables"
                                         doc_id="_no_need_"
                                         field_name=["accounts_groups", group_id]
                                         account_id=account_id
                   }
    %}
  {% endfor %}
</span>
<br />
<br />
<span style="font-size: 1.2em;">{_ Banking details _}:</span>
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Bank name _}
      </th>
      <th class="text-left">
        <span id="banking_detailsbank_name">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","bank_name"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Bank branch name _}
      </th>
      <th class="text-left">
        <span id="banking_detailsbank_branch_name">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","bank_branch_name"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Bank Identification Code _}
      </th>
      <th class="text-left">
        <span id="banking_detailsbik">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","bik"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Settlement account _}
      </th>
      <th class="text-left">
        <span id="banking_detailssettlement_account">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","settlement_account"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Correspondent account _}
      </th>
      <th class="text-left">
        <span id="banking_detailscorrespondent_account">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","correspondent_account"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
  </thead>
</table>
{% endwith %}
</span>

