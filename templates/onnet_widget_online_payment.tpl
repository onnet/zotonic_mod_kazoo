{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_content %}

{% for online_payment_system_body in m.notifier.map.online_payment_systems %}
  {% if online_payment_system_body %}
    {% include online_payment_system_body %}
  {% endif %}
{% endfor %}

{% endblock %}

