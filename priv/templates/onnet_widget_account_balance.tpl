{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
  {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}

{% include "onnet_widget_finance_table.tpl" %}

<span id="set_notify_level_tpl">
  {% include "_set_notify_level.tpl" %}
</span>

{% endblock %}
