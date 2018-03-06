{% if not result %}
  <table id="make_invoice_table" class="table table-hover table-centered table-condensed">
    <thead>
      <tr>
        <th colspan="3">{_ Issue pro-forma invoice _}</th>
      </tr>
    </thead>
    <tbody id="body_mask">
      <tr>
        <td width="50%">{_ Enter desired amount _}</td>
        <td>
          {{ m.session.currency_sign }}
          <input class="input input-small-onnet" type="text" id="invoiceme" name="invoice_amount" value="" />
        </td>
        <td>
          {% button id="email_invoice" class="btn btn-xs btn-onnet pull-right" text=_"proceed"
                    action={mask target="body_mask" message=_"Issuing an invoice..."} 
                    action={postback postback="issue_proforma_invoice" delegate="mod_kazoo" qarg="invoiceme" }
          %}
        </td>
      </tr>
    </tbody>
  </table>
{% else %}
  <table id="make_invoice_table" class="table table-hover table-centered table-condensed">
    <thead>
      <tr>
        <th>{_ Type _}</th>
        <th class="td-center">{_ # _}</th>
        <th class="td-center">{_ Date _}</th>
        <th class="td-center">{_ Sum _}</th>
        <th class="td-center">{_ VAT _}</th>
        <th class="td-center">{_ Total _}</th>
        <th class="td-center"></th>
      </tr>
    </thead>
      <tr>
        <td>
          {_ Pro-forma invoice _}
        </td>
        <td>
          {{ result[1]["doc_number"] }} 
        </td>
        <td class="td-center">
          {{ result[1]["doc_date_tuple"][1]["day"] }}
          {{ result[1]["doc_date_tuple"][1]["month_short"] }}
          {{ result[1]["doc_date_tuple"][1]["year"] }}
        </td>
        <td class="td-center">
          {{ result[1]["total_netto"]|currency_sign }}
        </td>
        <td class="td-center">
          {{ result[1]["total_vat"]|currency_sign }}
        </td>
        <td class="td-center">
          {{ result[1]["total_brutto"]|currency_sign }}
        </td>
        <td class="td-center">
          <a href="{{ m.onbill[{attachment_download_link account_id=account_id
                                                         doc_id=result[1]["id"]
                                                         doc_type="onbill_modb" }] }}">
            <i id="{{ result[1]["id"]|cleanout }}"
               class="fa fa-download zprimary"
               title="{_ Download _}"></i></a>
        </td>
      </tr>
    </tbody>
  </table>
{% endif %}
