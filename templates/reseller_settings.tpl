{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Reseller settings" %}
{% endblock %}

{% block service_description %}
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_reseller_portal_general_settings_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="reseller_portal_general_settings_tpl"
                                         template="reseller_portal_general_settings.tpl"
                                         headline=_"General settings"
                                 }
                 }
  %}
  <span id="reseller_portal_general_settings_tpl">
        {% include "reseller_portal_general_settings.tpl" headline=_"General settings" %}
  </span>

  {% wire action={connect signal={update_admin_portal_users_list_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="admin_portal_users_list_tpl"
                                         template="admin_portal_users_list.tpl"
                                         headline=_"Account's Users"
                                 }
                 }
  %}
  <span id="admin_portal_users_list_tpl">
        {% include "admin_portal_users_list.tpl" headline=_"Account's Users" %}
  </span>

  {% wire action={connect signal={update_reseller_portal_notifications_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="reseller_portal_notifications_tpl"
                                         template="reseller_portal_notifications.tpl"
                                         headline=_"Notifications"
                                 }
                 }
  %}
  <span id="reseller_portal_notifications_tpl">
        {% include "reseller_portal_notifications.tpl" headline=_"Notifications" %}
  </span>
  <span id="reseller_portal_paypal_config_tpl">
        {% include "reseller_portal_paypal_config.tpl" headline=_"PayPal" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_reseller_portal_resources_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="reseller_portal_resources_tpl"
                                         template="reseller_portal_resources.tpl"
                                         headline=_"Outbound routing"
                                 }
                 }
  %}
  <span id="reseller_portal_resources_tpl">
        {% include "reseller_portal_resources.tpl" headline=_"Outbound routing" %}
  </span>

  {% wire action={connect signal={update_rs_allocated_numbers_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="rs_allocated_numbers_tpl"
                                         template="rs_allocated_numbers.tpl"
                                         headline=_"Account's allocated numbers"
                                         account_id=account_id
                                 }
                 }
  %}
  <span id="account_allocated_numbers_tpl">
        {% include "account_allocated_numbers.tpl" headline=_"Allocated numbers" %}
  </span>
  {% include "onbill_service_plans.tpl" headline=_"Service plans" %}
  {% include "onbill_variables.tpl" headline=_"Reseller settings" account_id=m.session.kazoo_account_id %}
  {% for carrier_id in m.onbill[{onbill_get_variables account_id=m.session.kazoo_account_id}][1]["carriers"] %}
    {% include "onbill_carrier.tpl" carrier_id=carrier_id headline=_"Carrier"++" "++carrier_id %}
  {% endfor %}
</div>
{% endblock %}

