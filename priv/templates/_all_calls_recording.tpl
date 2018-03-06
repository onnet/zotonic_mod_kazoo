{% with m.kazoo.kz_get_acc_doc as account_doc %}
  {% if account_doc[1]["preflow"][1]["always"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
  <i id="toggle_all_calls_recording_enabled" class="fa fa-refresh pointer" title="Change"></i>
  {% wire id="toggle_all_calls_recording_enabled" type="click" action={ postback postback="toggle_all_calls_recording" delegate="mod_kazoo"} %}
{% endwith %}
