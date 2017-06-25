{% with m.kazoo[{kz_user_doc_by_ownerid owner_id=user_id}][1] as user_doc %}
<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active"><a href="#basic" role="tab" data-toggle="tab">{_ Basic _}</a></li>
  <li><a href="#callerid" role="tab" data-toggle="tab">{_ CID _}</a></li>
  <li><a href="#diversion" role="tab" data-toggle="tab">{_ Diversion _}</a></li>
  <li><a href="#mediasettings" role="tab" data-toggle="tab">Media</a></li>
  <li><a href="#password" role="tab" data-toggle="tab">{_ Password _}</a></li>
  <li><a href="#devices" role="tab" data-toggle="tab">{_ Devices _}</a></li>
  <li><a href="#restrictions" role="tab" data-toggle="tab">{_ Restrictions _}</a></li>
</ul>

<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="basic">
    {% include "admin_portal_user_basic.tpl" %}
  </div>
  <!-- Caller ID -->
  <div class="tab-pane fade" id="callerid">
    {% include "admin_portal_user_caller_id.tpl" %}
  </div>
  <!-- Call Forward -->
  <div class="tab-pane fade" id="diversion">
    {% include "admin_portal_user_call_forward.tpl" %}
  </div>
  <!-- Media Settings -->
  <div class="tab-pane fade" id="mediasettings">
    <div class="text-center">
      {% ilazy  class="fa fa-spinner fa-spin fa-3x"
                action={update target="mediasettings"
                               template="admin_portal_user_media_settings.tpl"
                               user_id=user_id
                       }
      %}
    </div>
  </div>
  <div class="tab-pane fade" id="password">
    {% include "_change_user_password.tpl" %}
  </div>
  <div class="tab-pane fade" id="devices">
    {% include "admin_portal_user_devices_lazy.tpl" %}
  </div>
  <div class="tab-pane fade" id="restrictions">
    {% include "admin_portal_user_restrictions.tpl" %}
  </div>
</div>
</div>
{% endwith %}
