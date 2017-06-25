{% with m.kazoo[{kz_device_doc device_id=device_id}][1] as device_doc %}
<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active"><a href="#basic" role="tab" data-toggle="tab">{_ Basic _}</a></li>
{% if device_doc["device_type"]!="sip_uri" %}
  <li><a href="#callerid" role="tab" data-toggle="tab">{_ Caller ID _}</a></li>
{% endif %}
{% if device_doc["device_type"]!="cellphone" and device_doc["device_type"]!="sip_uri" %}
<!--  <li><a href="#sipsettings" role="tab" data-toggle="tab">SIP Settings</a></li> -->
  <li><a href="#audiosettings" role="tab" data-toggle="tab">Audio</a></li>
  <li><a href="#restrictions" role="tab" data-toggle="tab">{_ Restrictions _}</a></li>
  <li><a href="#device_sip_access" role="tab" data-toggle="tab">{_ SIP ACL _}</a></li>
{% endif %}
</ul>

<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="basic">
{% if device_doc["device_type"]=="cellphone" %}
    {% include "admin_portal_device_cellphone.tpl" %}
{% elseif device_doc["device_type"]=="sip_uri" %}
    {% include "admin_portal_device_sip_uri.tpl" %}
{% else %}
    {% include "admin_portal_device_basic.tpl" %}
{% endif %}
  </div>
  <!-- Caller ID -->
  <div class="tab-pane fade" id="callerid">
    {% include "admin_portal_device_caller_id.tpl" %}
  </div>
  <!-- SIP Settings -->
  <div class="tab-pane fade" id="sipsettings">
    {% include "admin_portal_device_sip_settings.tpl" %}
  </div>
  <!-- Audio Settings -->
  <div class="tab-pane fade" id="audiosettings">
    {% include "admin_portal_device_audio_settings.tpl" %}
  </div>
  <div class="tab-pane fade" id="restrictions">
    {% include "admin_portal_device_restrictions.tpl" %}
  </div>
  <div class="tab-pane fade" id="device_sip_access">
    {% include "_add_device_sipaccess_list.tpl" %}
  </div>
</div>
</div>
{% endwith %}
