{% with m.kazoo[{kz_device_doc device_id=device_id}][1] as device_doc %}
{% if device_doc["device_type"]=="cellphone" %}
    {% include "admin_portal_device_cellphone.tpl" %}
{% else %}
<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active"><a href="#basic" role="tab" data-toggle="tab">Basic</a></li>
  <li><a href="#callerid" role="tab" data-toggle="tab">Caller ID</a></li>
<!--  <li><a href="#sipsettings" role="tab" data-toggle="tab">SIP Settings</a></li> -->
<!--  <li><a href="#audiosettings" role="tab" data-toggle="tab">Audio</a></li> -->
  <li><a href="#restrictions" role="tab" data-toggle="tab">Restrictions</a></li>
</ul>

<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="basic">
    {% include "admin_portal_device_basic.tpl" %}
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
    {# print device_doc #}
  </div>
</div>
</div>
{% endif %}
{% endwith %}
