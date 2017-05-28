{% extends "dashboard_base.tpl" %}

{% block service_description %}
  {% include "_account_page_title.tpl" title=_"Conference manager" %}
  {% wire action={connect signal={update_admin_portal_conferences_list_tpl
                                  signal_filter=m.kazoo.signal_filter
                                 }
                          action={update target="conferences_list_area"
                                         template="conferences_list.tpl"
                                 }
                 }
  %}
  <span id="conferences_list_area">
    {% include "conferences_list.tpl" %}
  </span>
{% endblock %}
