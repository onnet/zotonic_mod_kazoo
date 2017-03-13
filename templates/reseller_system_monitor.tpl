{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Current state" %}
{% endblock %}

{% block service_description %}
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={reseller_current_calls_widget_tpl session_id=m.session.session_id}
                          action={update target="reseller_current_calls_widget_tpl"
                                         template="reseller_current_calls_widget.tpl"
                                         headline=_"System-wide current calls"
                                 }
                 }
  %}
  <span id="reseller_current_calls_widget_tpl">
    {% include "reseller_current_calls_widget.tpl" headline=_"System-wide current calls" %}
  </span>
  <span id="notifications_smtplog_widget_tpl">
    {% include "notifications_smtplog_widget.tpl" headline=_"Notifications" account_id=account_id %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={reseller_registrations_widget_tpl session_id=m.session.session_id}
                          action={update target="reseller_registrations_widget_tpl"
                                         template="reseller_registrations_widget.tpl"
                                         headline=_"System-wide registrations"
                                 }
                 }
  %}
  <span id="reseller_registrations_widget_tpl">
    {% include "reseller_registrations_widget.tpl" headline=_"System-wide registrations" %}
  </span>
  {% wire action={connect signal={refresh_tasks_widget_signal session_id=m.session.session_id}
                          action={update target="tasks_widget_tpl"
                                         template="tasks_widget.tpl"
                                         headline=_"Background jobs"
                                 }
                 }
  %}
  <span id="tasks_widget_tpl">
    {% include "tasks_widget.tpl" headline=_"Background jobs" %}
  </span>
</div>
{% endblock %}
