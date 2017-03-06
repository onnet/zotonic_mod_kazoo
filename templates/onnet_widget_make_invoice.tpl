{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}

    {% button id="add_company_address" class="btn btn-xs btn-onnet pull-right" text=_"set invoice address" 
              action={ show target="accounts_address_div" }
              action={ hide target="make_invoice_table" }
              action={ show target="cancel_set_addr_btn" }
              action={ show target="submit_set_addr_btn" }
              action={ hide target="add_company_address" }
    %}
    {% button id="submit_set_addr_btn" class="btn btn-xs btn-onnet pull-right display_none" text=_"submit"
              action={submit target="set_accounts_address"}
              action={ fade_out target="accounts_address_div" }
              action={ show target="make_invoice_table" }
              action={ hide target="cancel_set_addr_btn" }
              action={ hide target="submit_set_addr_btn" }
              action={ show target="add_company_address" }
     %}
    {% button id="cancel_set_addr_btn" class="btn btn-xs btn-onnet pull-right display_none" text=_"cancel"
              action={ hide target="accounts_address_div" }
              action={ show target="make_invoice_table" }
              action={ hide target="cancel_set_addr_btn" }
              action={ hide target="submit_set_addr_btn" }
              action={ show target="add_company_address" }
     %}
{% endblock %}

{% block widget_content %}
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
            <td>{{ m.session.currency_sign }}
                <input class="input input-small-onnet" type="text" id="invoiceme" name="invoice_amount" value="" />
            </td>
            <td>{% button id="email_invoice" class="btn btn-xs btn-onnet pull-right" text=_"proceed"
                          action={mask target="body_mask" message=_"Issuing an invoice..."} 
                          action={postback postback="invoiceme_new" delegate="mod_kazoo" qarg="invoiceme" }
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
                                                             doc_id=doc["id"]
                                                             doc_type="proforma_invoice" }] }}">
                <i id="{{ result[1]["id"]|cleanout }}"
                   class="fa fa-download zprimary"
                   title="{_ Download _}"></i></a>
            </td>
        </tr>
    </tbody>
</table>
{% endif %}
<div id="accounts_address_div" style="display: none; border-top: 1px solid#ddd;">
        {% include "_set_accounts_address.tpl" %}
</div>
{# print result[1]["doc_date_tuple"][1]["day"] #}
{% endblock %}

