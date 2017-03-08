{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
  {{ headline }}
  {% button id="show_issued_proforma_invoices_btn" class="btn btn-xs btn-onnet pull-right" text=_"show issued" 
            action={hide target="show_issued_proforma_invoices_btn"}
            action={show target="cancel_proforma_invoice_list_btn"}
            action={update target="proforma_invoice_span"
                           template="_proforma_invoices_list.tpl"
                   }
  %}
  {% button id="cancel_proforma_invoice_list_btn" class="btn btn-xs btn-onnet pull-right display_none" text=_"cancel"
            action={update target="onnet_widget_make_invoice_tpl"
                           template="onnet_widget_make_invoice.tpl"
                           headline=_"Wire transfer"
                   }
  %}
{% endblock %}

{% block widget_content %}
  <span id="proforma_invoice_span">
    {% include "_issue_proforma_invoice.tpl" result=result %}
  </span>
{% endblock %}
