<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active">
    <a href="#sipphone" role="tab" data-toggle="tab">{_ SIP Phone _}</a>
  </li>
  <li>
    <a href="#cellphone" role="tab" data-toggle="tab">{_ Cell Phone _}</a>
  </li>
  <li>
    <a href="#sip_uri" role="tab" data-toggle="tab">{_ SIP URI _}</a>
  </li>
</ul>
<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="sipphone">
    {% include "admin_portal_create_sipphone.tpl" %}
  </div>
  <!-- Cell Phone -->
  <div class="tab-pane fade" id="cellphone">
    {% include "admin_portal_create_cellphone.tpl" %}
  </div>
  <!-- SIP URI -->
  <div class="tab-pane fade" id="sip_uri">
    {% include "admin_portal_create_sipuri_device.tpl" %}
  </div>
</div>
</div>
