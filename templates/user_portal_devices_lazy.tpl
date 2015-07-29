  {% wire name="update_devices_status" action={update target="user_portal_devices_tpl" template="user_portal_devices.tpl" headline=_"Devices"} %}
  <span id="user_portal_devices_tpl">
     {% include "user_portal_devices.tpl" headline=_"Devices" %}
  </span>

  {% javascript %}
    function devices_refresh() {
      z_event("update_devices_status");
      console.log('Refresh event sent');
    }
    setInterval(devices_refresh, 10000);
  {% endjavascript %}

