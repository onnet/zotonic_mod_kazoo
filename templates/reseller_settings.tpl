{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Reseller settings" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_reseller_portal_general_settings_tpl} action={update target="reseller_portal_general_settings_tpl" template="reseller_portal_general_settings.tpl" headline=_"General settings"}} %}
  <span id="reseller_portal_general_settings_tpl">
        {% include "reseller_portal_general_settings.tpl" headline=_"General settings" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_reseller_portal_resources_tpl} action={update target="reseller_portal_resources_tpl" template="reseller_portal_resources.tpl" headline=_"Outbound routing"}} %}
  <span id="reseller_portal_resources_tpl">
        {% include "reseller_portal_resources.tpl" headline=_"Outbound routing" %}
  </span>
</div>

{% endblock %}

