{% extends "services.tpl" %}

{% block service_name %}{_ Password change _}{% endblock %}

{% block service_description %}

<span id="password_change_span_id">
<div class="row pb-1">
  <div class="col-xs-3">
    {% button text=_"Change password"
              class="col-xs-12 btn btn-zalarm"
              action={postback postback={password_reset_submit reset_id=q.recovery} delegate="mod_kazoo"}
    %}
  </div>
</div>
<div class="row pb-1">
  <div class="col-xs-3">
    {% button text=_"No, thanks!"
              class="col-xs-12 btn btn-zprimary"
              action={redirect dispatch="home"}
    %}
  </div>
</div>
</span>

{% endblock %}
