{% wire name="update_devices_status"
        action={update target="user_portal_devices_refresh_tpl"
                       template="user_portal_devices_refresh.tpl"
               }
%}
<span id="user_portal_devices_refresh_tpl">
  {% include "user_portal_devices_refresh.tpl" %}
</span>

{% javascript %}
  function refresh() {
    z_event("update_devices_status");
    console.log('Refresh event sent');
  }
  setInterval(refresh, 15000);
{% endjavascript %}
