{% extends "modkazoo_base.tpl" %}

{% block font %}

{% endblock %}

{% block main %}
{% if m.kazoo.is_auth or m.session.lb_user_id %}
  <div class="wrapper">
    <div class="container" style="width: 95%">
      <div id="page_title_row" class="row">
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
  {% wire action={connect signal={emit_growl_signal signal_filter=m.kazoo.signal_filter}
                          action={update template="_z_growl_add.tpl"}
                 }
  %}
{% else %}
{% javascript %}
  z_notify("no_auth");
{% endjavascript %}
{% endif %}
{% endblock %}
