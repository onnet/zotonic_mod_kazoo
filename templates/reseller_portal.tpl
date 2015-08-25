{% extends "dashboard_base.tpl" %}

{% block service_description %}


{% include "cf_app_style.tpl" %}
{% lib "css/kazoo/cf_tables.css" %}
{% lib "css/kazoo/cf_mod_kazoo.css" %}

{% wire action={connect signal={update_reseller_children_area} action={update target="reseller_children_area" template="reseller_children.tpl"}} %}
<span id="reseller_children_area">
  {% include "reseller_children.tpl" %}
</span>

{% endblock %}

