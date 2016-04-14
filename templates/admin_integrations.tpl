{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Integrations" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_webhooks_list_tpl}
                          action={update target="admin_portal_webhooks_list_tpl" template="admin_portal_webhooks_list.tpl" headline=_"Webhooks"}
                 }
  %}
  <span id="admin_portal_webhooks_list_tpl">
        {% include "admin_portal_webhooks_list.tpl" headline=_"Webhooks" %}
  </span>

  {% wire action={connect signal={update_crm_integrations_widget_tpl}
                          action={update target="crm_integrations_widget_tpl" template="crm_integrations_widget.tpl" headline=_"CRM Integrations"}
                 }
  %}
  <span id="crm_integrations_widget_tpl">
        {% include "crm_integrations_widget.tpl" headline=_"CRM Integrations" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_c2call_list_tpl}
          action={update target="admin_portal_c2call_list_tpl" template="admin_portal_c2call_list.tpl" headline=_"Click-to-Call"}} %}
  <span id="admin_portal_c2call_list_tpl">
        {% include "admin_portal_c2call_list.tpl" headline=_"Click-to-Call" %}
  </span>
</div>

{% endblock %}
