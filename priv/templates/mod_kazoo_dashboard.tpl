{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Dashboard" %}
{% endblock %}

{% block service_description %}

  {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) and m.kazoo.is_kazoo_account_admin %}
    {% include "reseller_dashboard.tpl" %}
  {% else %}
    {% include "customer_dashboard.tpl" %}
  {% endif %}

{% endblock %}
