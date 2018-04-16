{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Account statistics" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-12">
  {% wire action={connect signal={update_admin_portal_call_details_tpl
                                  signal_filter=m.kazoo.signal_filter}
                          action={update target="admin_portal_call_details_tpl" 
                                         template="admin_portal_call_details.tpl"
                                         headline=_"Call details"}
                 }
  %}
  <span id="admin_portal_call_details_tpl"
        {% if m.session.show_cdr_legs %}
          class="display_none"
        {% endif %}>
    {% include "admin_portal_call_details.tpl" headline=_"Call details" %}
  </span>

  {% wire action={connect signal={update_admin_portal_call_history_tpl
                                  signal_filter=m.kazoo.signal_filter}
                          action={update target="admin_portal_call_history_tpl" 
                                         template="admin_portal_call_history.tpl"
                                         headline=_"Account's Call History"}
                 }
  %}
  <span id="admin_portal_call_history_tpl">
    {% include "admin_portal_call_history.tpl" headline=_"Account's Call History" %}
  </span>
</div>

    {% include "admin_portal_call_recordings_table.tpl" headline=_"Account's Call Recordings" %}

{% endblock %}
