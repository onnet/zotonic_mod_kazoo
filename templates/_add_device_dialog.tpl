<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active"><a href="#sipphone" role="tab" data-toggle="tab">{_ SIP Phone _}</a></li>
  <li><a href="#cellphone" role="tab" data-toggle="tab">{_ Cell Phone _}</a></li>
</ul>

<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="sipphone">
    {% include "admin_portal_create_sipphone.tpl" %}
  </div>
  <!-- Caller ID -->
  <div class="tab-pane fade" id="cellphone">
    {% include "admin_portal_create_cellphone.tpl" %}
  </div>
</div>
</div>
