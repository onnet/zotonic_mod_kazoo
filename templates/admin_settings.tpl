{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Account settings" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_general_settings_tpl} action={update target="admin_portal_general_settings_tpl" template="admin_portal_general_settings.tpl" headline=_"General settings"}} %}
  <span id="admin_portal_general_settings_tpl">
        {% include "admin_portal_general_settings.tpl" headline=_"General settings" %}
  </span>

  {% wire action={connect signal={update_reseller_portal_resources_tpl} action={update target="reseller_portal_resources_tpl" template="admin_portal_resources.tpl"}} %}
  <span id="reseller_portal_resources_tpl">
            {% include "admin_portal_resources.tpl" %}
  </span>

  {% wire action={connect signal={update_admin_portal_users_list_tpl} action={update target="admin_portal_users_list_tpl" template="admin_portal_users_list.tpl" headline=_"Account's Users"}} %}
  <span id="admin_portal_users_list_tpl">
        {% include "admin_portal_users_list.tpl" headline=_"Account's Users" %}
  </span>

  {% wire action={connect signal={update_admin_portal_groups_list_tpl} action={update target="admin_portal_groups_list_tpl" template="admin_portal_groups_list.tpl" headline=_"Groups"}} %}
  <span id="admin_portal_groups_list_tpl">
        {% include "admin_portal_groups_list.tpl" headline=_"Groups" %}
  </span>

  {% wire action={connect signal={update_admin_portal_media_list_tpl} action={update target="admin_portal_media_list_tpl" template="admin_portal_media_list.tpl" headline=_"Media"}} %}
  <span id="admin_portal_media_list_tpl">
        {% include "admin_portal_media_list.tpl" headline=_"Media" %}
  </span>

  {% wire action={connect signal={update_admin_portal_conferences_list_tpl}
          action={update target="admin_portal_conferences_list_tpl" template="admin_portal_conferences_list.tpl" headline=_"Conferences"}} %}
  <span id="admin_portal_conferences_list_tpl">
        {% include "admin_portal_conferences_list.tpl" headline=_"Conferences" %}
  </span>

  {% wire action={connect signal={update_admin_portal_trunk_list_tpl}
          action={update target="admin_portal_trunk_list_tpl" template="admin_portal_trunk_list.tpl" headline=_"Trunkstore"}} %}
  <span id="admin_portal_trunk_list_tpl">
        {% include "admin_portal_trunk_list.tpl" headline=_"Trunkstore" %}
  </span>

  {% wire action={connect signal={update_admin_portal_c2call_list_tpl}
          action={update target="admin_portal_c2call_list_tpl" template="admin_portal_c2call_list.tpl" headline=_"Click-to-Call"}} %}
  <span id="admin_portal_c2call_list_tpl">
        {% include "admin_portal_c2call_list.tpl" headline=_"Click-to-Call" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_admin_portal_devices_list_tpl} action={update target="admin_portal_devices_list_tpl" template="admin_portal_devices_list.tpl" headline=_"Account's Devices"}} %}
  <span id="admin_portal_devices_list_tpl">
        {% include "admin_portal_devices_list.tpl" headline=_"Account's Devices" %}
  </span>

  {% wire action={connect signal={update_admin_portal_time_of_the_day_list_tpl}
          action={update target="admin_portal_time_of_the_day_list_tpl" template="admin_portal_time_of_the_day_list.tpl" headline=_"Time of the day rules"}} %}
  <span id="admin_portal_time_of_the_day_list_tpl">
        {% include "admin_portal_time_of_the_day_list.tpl" headline=_"Time of the day rules" %}
  </span>

  {% wire action={connect signal={update_admin_portal_menus_list_tpl} action={update target="admin_portal_menus_list_tpl" template="admin_portal_menus_list.tpl" headline=_"Menus"}} %}
  <span id="admin_portal_menus_list_tpl">
        {% include "admin_portal_menus_list.tpl" headline=_"Menus" %}
  </span>

  {% wire action={connect signal={update_admin_portal_blacklists_tpl} action={update target="admin_portal_blacklists_tpl" template="admin_portal_blacklists.tpl" headline=_"Blacklists"}} %}
  <span id="admin_portal_blacklists_tpl">
        {% include "admin_portal_blacklists.tpl" headline=_"Blacklists" %}
  </span>

  {% wire action={connect signal={update_admin_portal_vms_list_tpl} action={update target="admin_portal_vms_list_tpl" template="admin_portal_vms_list.tpl" headline=_"Voicemails"}} %}
  <span id="admin_portal_vms_list_tpl">
        {% include "admin_portal_vms_list.tpl" headline=_"Voicemails" %}
  </span>

  {% wire action={connect signal={update_admin_portal_webhooks_list_tpl} action={update target="admin_portal_webhooks_list_tpl" template="admin_portal_webhooks_list.tpl" headline=_"Webhooks"}} %}
  <span id="admin_portal_webhooks_list_tpl">
        {% include "admin_portal_webhooks_list.tpl" headline=_"Webhooks" %}
  </span>

  {% wire action={connect signal={update_admin_portal_lists_tpl} action={update target="admin_portal_lists_tpl" template="admin_portal_lists.tpl" headline=_"Lists"}} %}
  <span id="admin_portal_lists_tpl">
        {% include "admin_portal_lists.tpl" headline=_"Lists" %}
  </span>
</div>

{% endblock %}

