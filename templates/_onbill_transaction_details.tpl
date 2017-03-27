{% with m.onbill[{transaction account_id=account_id transaction_id=transaction_id}] as transaction %}

  {% print transaction %}

{% endwith %}
