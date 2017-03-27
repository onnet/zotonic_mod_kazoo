{% if transaction["currency_code"]=="USD" %}${{ transaction["amount"] }}
{% elseif transaction["currency_code"]=="GBP" %}£{{ transaction["amount"] }}
{% else %}{{ transaction["amount"] }} {{ transaction["currency_code"] }}
{% endif %}
