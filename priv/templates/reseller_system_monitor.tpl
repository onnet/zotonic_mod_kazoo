{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Current state" %}
{% endblock %}

{% block service_description %}
<div class="pl-10 pr-10 col-md-6">
  <span id="notifications_smtplog_widget_tpl">
    {% include "notifications_smtplog_widget.tpl" headline=_"Notifications" account_id=account_id %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={reseller_registrations_widget_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="reseller_registrations_widget_tpl"
                                         template="reseller_registrations_widget.tpl"
                                         headline=_"System-wide registrations"
                                 }
                 }
  %}
  <span id="reseller_registrations_widget_tpl">
    {% include "reseller_registrations_widget.tpl" headline=_"System-wide registrations" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-12">
  {% wire action={connect signal={reseller_current_calls_widget_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="reseller_current_calls_widget_tpl"
                                         template="reseller_current_calls_widget.tpl"
                                         headline=_"System-wide current calls"
                                 }
                 }
  %}
  <span id="reseller_current_calls_widget_tpl" class="display_none1">
    {% include "reseller_current_calls_widget.tpl" headline=_"System-wide current calls" %}
  </span>
</div>
{% endblock %}
