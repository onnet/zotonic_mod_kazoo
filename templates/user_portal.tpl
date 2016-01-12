{% extends "dashboard_base.tpl" %}


{% block header_title %}
  {% include "_account_page_title.tpl" title=_"User portal" %}
{% endblock %}


{% block service_description %}

  {% lib "js/sip-0.7.2.js" %}
  {% lib "css/user_portal_phone.css" %}

<div class="pl-10 pr-10 col-md-6">

  {% wire action={connect signal={user_portal_voicemails_tpl} action={update target="user_portal_voicemails_tpl" template="user_portal_voicemails.tpl" headline=_"Voicemails"}} %}
  <span id="user_portal_voicemails_tpl">
        {% include "user_portal_voicemails.tpl" headline=_"Voicemails" %}
  </span>
  
  <span id="user_portal_faxes_outgoing_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_faxes_outgoing_tpl"
                                                                    template="user_portal_faxes_outgoing.tpl"
                                                                    headline=_"Send fax"}
        %}
      </div>
  </span>

  {% wire action={connect signal={user_portal_faxes_incoming_tpl} action={update target="user_portal_faxes_incoming_tpl" template="user_portal_faxes_incoming.tpl" headline=_"Incoming faxes"}} %}
  <span id="user_portal_faxes_incoming_tpl">
        {% include "user_portal_faxes_incoming.tpl" headline=_"Incoming faxes" %}
  </span>
</div>

<div class="pl-10 pr-10 col-md-6">
  <span id="user_portal_webphone_lazy_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_webphone_lazy_tpl"
                                                                    template="user_portal_webphone_lazy.tpl"
                                                                    headline=_"Webphone"}
        %}
      </div>
  </span>

     {% wire action={connect signal={user_portal_call_history_tpl} action={update target="user_portal_call_history_tpl" template="user_portal_call_history.tpl" headline=_"Call History"}} %}
  <span id="user_portal_call_history_tpl">
        {% include "user_portal_call_history.tpl" headline=_"Call History" %}
  </span>
  
  <span id="user_portal_settings_tpl">
     
  </span>
  
  {% wire action={connect signal={update_user_portal_settings_tpl} action={update target="user_portal_settings_tpl" template="user_portal_settings.tpl" headline=_"Settings"}} %}
  <span id="user_portal_settings_tpl">
        {% include "user_portal_settings.tpl" headline=_"Settings" %}
  </span>

  {% wire action={connect signal={update_user_portal_devices_tpl} action={update target="user_portal_devices_tpl" template="user_portal_devices.tpl" headline=_"Devices"}} %}
  <span id="user_portal_devices_tpl">
        {% include "user_portal_devices.tpl" headline=_"Devices" %}
  </span>

</div>

{% endblock %}

