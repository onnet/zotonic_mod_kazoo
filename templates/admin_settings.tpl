{% extends "dashboard_base.tpl" %}

{% block service_description %}

  {% include "_account_page_title.tpl" title=_"Account settings" %}

<div class="pl-10 pr-10 col-md-6">
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
</div>

{% endblock %}

