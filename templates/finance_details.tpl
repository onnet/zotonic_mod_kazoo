{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Payments" %}
{% endblock %}

{% block service_description %}

<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<div class="pl-10 pr-10 col-md-6">
    {# Account status #}
    {% include "onbill_widget_finance.tpl" headline=_"Account" %}

    {# Make invoce #}
    <span id="onnet_widget_make_invoice_tpl">
        {% include "onnet_widget_make_invoice.tpl" headline=_"Wire transfer" %}
    </span>

    {# Online payments #}
    {% wire action={connect signal={update_onnet_widget_online_payment_tpl}
                            action={update target="onnet_widget_online_payment_tpl"
                                           template="onnet_widget_online_payment_lazy.tpl"
                                   }
                   }
    %}
    <span id="onnet_widget_online_payment_tpl">
      {% include "onnet_widget_online_payment.tpl" headline=_"Online payments" %}
    </span>
</div>

<div id="paytab" class="pl-10 pr-10 col-md-6">

    {% wire action={connect signal={update_rs_widget_related_documents_tpl}
                    action={update target="rs_widget_related_documents_tpl" template="update_rs_widget_related_documents.tpl"}
                   }
    %}
    <span id="rs_widget_related_documents_tpl">
        {% include "rs_widget_related_documents.tpl" headline=_"Related documents" %}
    </span>


    {# Transactions list #}
    {% wire action={connect signal={update_fin_info_signal} 
                            action={update target="rs_widget_transactions_list_tpl"
                                           template="rs_widget_transactions_list.tpl"
                                           headline=_"Transactions list"
                                   }
                   }
    %}
    <span id="rs_widget_transactions_list_tpl">
        {% include "rs_widget_transactions_list.tpl" headline=_"Transactions list" %}
    </span>


</div>

{% endblock %}
