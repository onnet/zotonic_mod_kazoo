{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Current state" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  <span id="admin_portal_current_calls_tpl">
    {% include "admin_portal_current_calls.tpl" headline=_"Account's Current Calls" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  <span id="account_registrations_widget_tpl">
    {% include "account_registrations_widget.tpl" headline=_"Account's current registrations" account_id=account_id %}
  </span>
  <span id="notifications_smtplog_widget_tpl">
    {% include "notifications_smtplog_widget.tpl" headline=_"Account's notifications" account_id=account_id %}
  </span>
</div>

{% endblock %}
