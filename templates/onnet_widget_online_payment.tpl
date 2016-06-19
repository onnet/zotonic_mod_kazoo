{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_content %}

{% include "bt_widget_online_payment.tpl" %}

{% endblock %}

