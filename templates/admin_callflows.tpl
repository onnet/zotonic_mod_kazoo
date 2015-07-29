{% extends "dashboard_base.tpl" %}

{% block service_description %}


{% lib "css/kazoo/cf_app.css" %}
{% lib "css/kazoo/cf_tables.css" %}
{% lib "css/kazoo/cf_onnet.css" %}

{% wire action={connect signal={update_cf_builder_area} action={update target="cf_builder_area" template="kzui_cf.tpl"}} %}
<span id="cf_builder_area">
  {% include "kzui_cf.tpl" %}
</span>

{% endblock %}

