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
        <span id="{{ account_id }}name">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["name"]
                                       account_id=account_id
                                       prefix=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Registered Number _}</th>
      <th class="text-left">
        <span id="inn">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["reg_number"]
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
<span style="font-size: 1.2em; ">{_ Addresses _}:</span>
<br />
<br />
<div style="margin-left: 1em;">
<span>{_ Registered _}:</span>
<br />
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-left">{_ Line1  _}</th>
      <th class="text-left">
        <span id="addressregisteredline1">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","registered","line1"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Line2  _}</th>
      <th class="text-left">
        <span id="addressregisteredline2">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","registered","line2"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Line3  _}</th>
      <th class="text-left">
        <span id="addressregisteredline3">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","registered","line3"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
  </thead>
</table>
</div>
<br />
<div style="margin-left: 1em;">
<span>{_ Office _}:</span>
<br />
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-left">{_ Line1  _}</th>
      <th class="text-left">
        <span id="addressofficeline1">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","office","line1"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Line2  _}</th>
      <th class="text-left">
        <span id="addressofficeline2">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","office","line2"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Line3  _}</th>
      <th class="text-left">
        <span id="addressofficeline3">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","office","line3"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
  </thead>
</table>
</div>
<br />
<div style="margin-left: 1em;">
<span>{_ Postbox _}:</span>
<br />
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th class="text-left">{_ Line1  _}</th>
      <th class="text-left">
        <span id="addresspostboxline1">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","postbox","line1"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Line2  _}</th>
      <th class="text-left">
        <span id="addresspostboxline2">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","postbox","line2"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left">{_ Line3  _}</th>
      <th class="text-left">
        <span id="addresspostboxline3">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["address","postbox","line3"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
  </thead>
</table>
</div>
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
        <span id="banking_detailsname">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","name"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Account number _}
      </th>
      <th class="text-left">
        <span id="banking_detailsaccount_number">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","account_number"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ Sort Code _}
      </th>
      <th class="text-left">
        <span id="banking_detailssort_code">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","sort_code"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
    <tr>
      <th class="text-left"
          style="width: 35%;">
        {_ IBAN _}
      </th>
      <th class="text-left">
        <span id="banking_detailsiban">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","iban"]
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
        <span id="banking_detailsbic">
          {% include "_show_field.tpl" type="onbill_variables"
                                       doc_id="_no_need_"
                                       field_name=["banking_details","bic"]
                                       account_id=account_id
          %}
        </span>
      </th>
    </tr>
  </thead>
</table>
{% endwith %}
</span>

