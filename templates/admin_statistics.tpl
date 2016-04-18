{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Account statistics" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_call_history_tpl} action={update target="admin_portal_call_history_tpl" 
                                                                                       template="admin_portal_call_history.tpl"
                                                                                       headline=_"Account's Call History"}}
  %}
  <span id="admin_portal_call_history_tpl">
        {% include "admin_portal_call_history.tpl" headline=_"Account's Call History" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_call_details_tpl} action={update target="admin_portal_call_details_tpl" 
                                                                                       template="admin_portal_call_details.tpl"
                                                                                       headline=_"Call details"}}
  %}
  <span id="admin_portal_call_details_tpl">
        {% include "admin_portal_call_details.tpl" headline=_"Call details" %}
  </span>
</div>

{% endblock %}
