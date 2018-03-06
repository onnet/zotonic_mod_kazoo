{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table class="table table-condensed table-hover table-centered">
   <thead>
        <tr>
            <th>{_ Counterparty _}</th>
            <th>{_ Date _}</th>
            <th>{_ Sum _}</th>
            <th>{_ VAT _}</th>
            <th>{_ Total _}</th>
        </tr>
    </thead>
    <tbody>
      {% for doc in m.onbill[{docs_listing account_id=account_id selected_billing_period=selected_billing_period}] %}
        <tr>
            <td><a href="{{ m.onbill[{attachment_download_link account_id=account_id doc_id=doc["id"] doc_type="onbill_modb"}] }}">{{ doc["name"] }}</a></td>
            <td><a href="{{ m.onbill[{attachment_download_link account_id=account_id doc_id=doc["id"] doc_type="onbill_modb"}] }}">{{ doc["id"] }}</a></td>
            <td><a href="{{ m.onbill[{attachment_download_link account_id=account_id doc_id=doc["id"] doc_type="onbill_modb"}] }}">{{ year }}</a></td>
            <td><a href="{{ m.onbill[{attachment_download_link account_id=account_id doc_id=doc["id"] doc_type="onbill_modb"}] }}">{{ month }}</a></td>
            <td><a href="{{ m.onbill[{attachment_download_link account_id=account_id doc_id=doc["id"] doc_type="onbill_modb"}] }}">{{ doc["name"] }}</a></td>
        </tr>
      {% endfor %}
    </tbody>
</table>
{% endblock %}

