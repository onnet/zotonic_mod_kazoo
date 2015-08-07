{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Feature codes" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-4">
  <span id="admin_portal_features_transfer_tpl">
        {% include "admin_portal_features_transfer.tpl" headline=_"Call-Forward" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-4">
  <span id="admin_portal_features_parking_tpl">
        {% include "admin_portal_features_parking.tpl" headline=_"Parking" %}
  </span>
</div>

<div class="pl-10 pr-10 col-md-4">
  <span id="admin_portal_features_other_tpl">
        {% include "admin_portal_features_other.tpl" headline=_"Miscellaneous" %}
  </span>
</div>

{% endblock %}

