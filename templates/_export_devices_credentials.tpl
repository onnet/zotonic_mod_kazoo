NickName,Username,Password,CIDNumber
<br />
{% for device in m.kazoo.kz_list_account_devices %}
  {% with m.kazoo[{kz_device_doc device_id=device[1]["id"]}] as device_doc %}
    {# print device_doc #}
    "{{ device_doc[1]["name"] }}",
    "{{ device_doc[1]["sip"][1]["username"] }}",
    "{{ device_doc[1]["sip"][1]["password"] }}",
    "{{ device_doc[1]["caller_id"][1]["internal"][1]["number"] }}"
    <br />
  {% endwith %}
{% endfor %}
