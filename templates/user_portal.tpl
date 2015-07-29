{% extends "dashboard_base.tpl" %}

{% block service_description %}

  {% include "_onnet_account_page_title.tpl" title=_"User portal" %}

  {% lib "js/sip-0.7.0.js" %}
  {% lib "css/user_portal_phone.css" %}

<div class="pl-10 pr-10 col-md-6">

  <span id="user_portal_voicemails_lazy_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_voicemails_lazy_tpl"
                                                                    template="user_portal_voicemails_lazy.tpl"}
        %}
      </div>
  </span>

  <span id="user_portal_faxes_outgoing_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_faxes_outgoing_tpl"
                                                                    template="user_portal_faxes_outgoing.tpl"
                                                                    headline=_"Send fax"}
        %}
      </div>
  </span>
     {# include "user_portal_faxes_outgoing.tpl" headline=_"Send fax" #}
  <span id="user_portal_faxes_incoming_lazy_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_faxes_incoming_lazy_tpl"
                                                                    template="user_portal_faxes_incoming_lazy.tpl"}
        %}
      </div>
  </span>
     {# include "user_portal_faxes_incoming.tpl" headline=_"Incoming faxes" #}
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

  <span id="user_portal_call_history_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_call_history_tpl"
                                                                    template="user_portal_call_history.tpl"
                                                                    headline=_"Call History"}
        %}
      </div>
  </span>
     {# include "user_portal_call_history.tpl" headline=_"Call History" #}
  <span id="user_portal_settings_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_settings_tpl"
                                                                    template="user_portal_settings.tpl"
                                                                    headline=_"Settings"}
        %}
      </div>
  </span>
  <span id="user_portal_devices_lazy_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_portal_devices_lazy_tpl"
                                                                    template="user_portal_devices_lazy.tpl"
                                                                    headline=_"Devices"}
        %}
      </div>
  </span>

</div>

{% endblock %}

