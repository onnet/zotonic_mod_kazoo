{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Feature codes" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  <span id="admin_portal_call_history_tpl">
        {% include "admin_portal_current_calls.tpl" headline=_"Account's Current Calls" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  <span id="admin_portal_call_history_tpl">
        {% include "admin_portal_call_history.tpl" headline=_"Account's Call History" %}
  </span>
</div>

{% endblock %}

