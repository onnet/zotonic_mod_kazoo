{% with m.kazoo[{kz_user_doc_by_ownerid owner_id=user_id}][1] as user_doc %}
<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active"><a href="#basic" role="tab" data-toggle="tab">Basic</a></li>
  <li><a href="#callerid" role="tab" data-toggle="tab">CID</a></li>
  <li><a href="#diversion" role="tab" data-toggle="tab">Diversion</a></li>
  <li><a href="#password" role="tab" data-toggle="tab">Password</a></li>
  <li><a href="#restrictions" role="tab" data-toggle="tab">Restrictions</a></li>
  <li><a href="#allocatednumbers" role="tab" data-toggle="tab" class="hidden">Numbers</a></li>
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
  <div class="tab-pane fade" id="password">
    {% include "admin_portal_user_password.tpl" %}
  </div>
  <div class="tab-pane fade" id="restrictions">
    {% include "admin_portal_user_restrictions.tpl" %}
  </div>
  <div class="tab-pane fade" id="allocatednumbers">
    {% include "admin_portal_user_allocated_numbers.tpl" %}
    {# print user_doc #}
  </div>
</div>
</div>
{% endwith %}
