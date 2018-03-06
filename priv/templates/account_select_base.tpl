{% extends "dashboard_base.tpl" %}

{% block service_description %}
  <span id="billing_children_area">
    {% include "billing_children.tpl" %}
  </span>
{% endblock %}

