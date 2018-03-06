{% if running_call[1]["account_id"] %}
  {% print  m.kazoo[{kz_channel_info uuid=running_call[1]["call_id"] account_id=running_call[1]["account_id"]}] %}
{% else %}
  {% print  running_call %}
{% endif %}
