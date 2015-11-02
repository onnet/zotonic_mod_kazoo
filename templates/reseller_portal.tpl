{% extends "dashboard_base.tpl" %}

{% block service_description %}

{# include "cf_app_style.tpl" #}
{# lib "css/kazoo/cf_tables.css" #}
{# lib "css/kazoo/cf_mod_kazoo.css" #}

<span id="reseller_children_area">
  {% include "reseller_children.tpl" account_id=account_id %}
</span>

{% endblock %}

