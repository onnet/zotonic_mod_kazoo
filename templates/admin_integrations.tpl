{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Integrations" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_webhooks_list_tpl session_id=m.session.session_id}
                          action={update target="admin_portal_webhooks_list_tpl"
                                         template="admin_portal_webhooks_list.tpl"
                                         headline=_"Webhooks"}
                 }
  %}
  <span id="admin_portal_webhooks_list_tpl">
        {% include "admin_portal_webhooks_list.tpl" headline=_"Webhooks" %}
  </span>

  {% wire action={connect signal={update_admin_portal_crmintegra_list_tpl session_id=m.session.session_id}
                          action={update target="admin_portal_crmintegra_list_tpl"
                                         template="admin_portal_crmintegra_list.tpl"
                                         headline=_"CRM Integrations"}
                 }
  %}
  <span id="admin_portal_crmintegra_tpl">
        {% include "admin_portal_crmintegra_list.tpl" headline=_"CRM Integrations" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_c2call_list_tpl session_id=m.session.session_id}
                          action={update target="admin_portal_c2call_list_tpl"
                                         template="admin_portal_c2call_list.tpl"
                                         headline=_"Click-to-Call"}
                 }
  %}
  <span id="admin_portal_c2call_list_tpl">
        {% include "admin_portal_c2call_list.tpl" headline=_"Click-to-Call" %}
  </span>
  {% wire action={connect signal={update_admin_portal_c2call_history_tpl session_id=m.session.session_id}
                         action={update target="admin_portal_c2call_history_tpl"
                                        template="admin_portal_c2call_history.tpl"
                                        headline=_"Click-to-Call History"}
                 }
  %}
  <span id="admin_portal_c2call_history_tpl">
        {% include "admin_portal_c2call_history.tpl" headline=_"Click-to-Call History" %}
  </span>
</div>

{% endblock %}
