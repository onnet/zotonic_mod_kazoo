{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Reseller settings" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_reseller_portal_general_settings_tpl}
                          action={update target="reseller_portal_general_settings_tpl" template="reseller_portal_general_settings.tpl" headline=_"General settings"}} %}
  <span id="reseller_portal_general_settings_tpl">
        {% include "reseller_portal_general_settings.tpl" headline=_"General settings" %}
  </span>

  {% wire action={connect signal={update_admin_portal_users_list_tpl} action={update target="admin_portal_users_list_tpl" template="admin_portal_users_list.tpl" headline=_"Account's Users"}} %}
  <span id="admin_portal_users_list_tpl">
        {% include "admin_portal_users_list.tpl" headline=_"Account's Users" %}
  </span>

  {% wire action={connect signal={update_reseller_portal_notifications_tpl}
                          action={update target="reseller_portal_notifications_tpl" template="reseller_portal_notifications.tpl" headline=_"Notifications"}} %}
  <span id="reseller_portal_notifications_tpl">
        {% include "reseller_portal_notifications.tpl" headline=_"Notifications" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_reseller_portal_resources_tpl}
                          action={update target="reseller_portal_resources_tpl" template="reseller_portal_resources.tpl" headline=_"Outbound routing"}} %}
  <span id="reseller_portal_resources_tpl">
        {% include "reseller_portal_resources.tpl" headline=_"Outbound routing" %}
  </span>

  {% wire action={connect signal={update_rs_allocated_numbers_tpl} action={update target="rs_allocated_numbers_tpl"
                                                                                  template="rs_allocated_numbers.tpl"
                                                                                  headline=_"Account's allocated numbers"
                                                                                  account_id=account_id}}
  %}
  <span id="account_allocated_numbers_tpl">
        {% include "account_allocated_numbers.tpl" headline=_"Allocated numbers" %}
  </span>
</div>

{% endblock %}

