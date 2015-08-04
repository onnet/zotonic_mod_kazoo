{% extends "modkazoo_base.tpl" %}

{% block font %}

{% endblock %}

{% block main %}
{% if not m.kazoo.is_auth %}
{% javascript %}
  z_notify("no_auth");
{% endjavascript %}
{% else %}
  <div class="wrapper">
    <div class="container" style="width: 95%">
      <div class="row">
        <div class="col-md-12" style="padding-left: 0px; padding-right: 0px;">
          {% block header_title %}{% endblock %}
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" style="padding-left: 0px; padding-right: 0px;">
          {% block service_description %}{% endblock %}
        </div>
      </div>
      {# include "services_row.tpl" #}
    </div>
  </div>
{% endif %}
{% endblock %}
