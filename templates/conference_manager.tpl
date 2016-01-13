{% extends "dashboard_base.tpl" %}

{% block service_description %}

  {% include "_account_page_title.tpl" title=_"Conference manager" %}

{# include "cf_app_style.tpl" #}
{# lib "css/kazoo/cf_tables.css" #}
{# lib "css/kazoo/cf_mod_kazoo.css" #}

{% wire action={connect signal={update_admin_portal_conferences_list_tpl}
        action={update target="conferences_list_area" template="conferences_list.tpl" }} %}

<span id="conferences_list_area">
  {% include "conferences_list.tpl" conference_id=conference_id %}
</span>

{% endblock %}

