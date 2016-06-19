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
<table id="make_invoice_table" class="table table-hover table-centered table-condensed">
    <thead>
        <tr>
            <th colspan="3">{_ Issue pro-forma invoice _}</th>
        </tr>
    </thead>
    <tbody id="body_mask">
        <tr>
            <td width="55%">{_ Enter desired amount _}</td>
            <td>{{ m.config.mod_kazoo.local_currency_sign.value }} <input class="input input-small-onnet" type="text" id="invoiceme" name="invoice_amount" value="" />
            </td>
            <td>{% button id="email_invoice" class="btn btn-xs btn-onnet pull-right" text=_"proceed"
                          action={mask target="body_mask" message=_"Issuing an invoice..."} 
                          action={postback postback="invoiceme" delegate="mod_kazoo" qarg="invoiceme" }
                 %}
            </td>
        </tr>
    </tbody>
</table>
<div id="accounts_address_div" style="display: none; border-top: 1px solid#ddd;">
        {% include "_set_accounts_address.tpl" %}
</div>
{% endblock %}

