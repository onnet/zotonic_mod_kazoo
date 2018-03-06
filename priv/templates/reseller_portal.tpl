{% extends "dashboard_base.tpl" %}

{% block service_description %}

{% if m.session.kazoo_superduper_admin or m.session.kazoo_is_reseller %}
  <span id="reseller_children_area">
    {% include "reseller_children.tpl" %}
  </span>
{% else %}
  {% wire action={redirect location="/dashboard"} %}
{% endif %}

{% endblock %}
