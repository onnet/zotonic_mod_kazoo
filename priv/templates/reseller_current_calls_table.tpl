{% wire name="channel_hangup" action={postback postback="channel_hangup_confirm" delegate="mod_kazoo"} %}
{% wire action={script script="$('#allcallscounter').text(document.getElementById('reseller_portal_current_calls_table').rows.length - 1);"} %}
<table id="reseller_portal_current_calls_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="display: none;">{_ CallId _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;">{_ Account _}</th>
      <th style="text-align: center;">{_ Caller Number _}</th>
      <th style="text-align: center;">{_ Callee Number _}</th>
      <th style="text-align: center;">{_ Realm _}</th>
      <th style="text-align: center;">{_ Status _}</th>
      <th style="text-align: center;">{_ Hang Up _}</th>
      <th style="text-align: center;"></th>
    </td>
  </thead>
  <tbody id="reseller_portal_current_calls_table_body">
    {% for running_call in m.kazoo.get_reseller_channels %} 
      {% if running_call[1]["direction"]=="inbound" %}
        {% include "reseller_current_calls_table_line.tpl" running_call=running_call %}
      {% endif %}
    {% endfor %}
  </tbody>
</table>

{% javascript %}

  var socket = new WebSocket('{{ m.config.mod_kazoo.kazoo_blackhole_url.value }}');
  socket.onopen = function() {
    send({
        action: 'unsubscribe',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        data: {
          account_id: '*',
          binding: 'call.*.*'
        }
    });
    send({
        action: 'subscribe',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        data: {
          account_id: '*',
          binding: 'call.*.*'
        }
    });
  };
 
  function send(data) {
      socket.send(JSON.stringify(data));
  };

  socket.onmessage = function(raw_message) {
    var data_obj = JSON.parse(raw_message.data);
    console.log(data_obj);
    var data = data_obj.data;
    switch(data.event_name) {
      case "CHANNEL_CREATE":
      if ( data.call_direction == "inbound") {
        row_id = myreplace(data.call_id);
        if ($("#"+row_id).length == 0) {
            $("#reseller_portal_current_calls_table_body").prepend("<tr id='"+row_id+"' style='display: none;'></tr>");
            z_event("update_reseller_current_calls_table_line", { "data": data });
            $('#allcallscounter').text(document.getElementById('reseller_portal_current_calls_table').rows.length - 1);
        }
      }
      break;

      case "CHANNEL_ANSWER":
      if ( data.call_direction == "inbound") {
        z_event("update_reseller_current_calls_table_line", { "data": data });
        $('#allcallscounter').text(document.getElementById('reseller_portal_current_calls_table').rows.length - 1);
      }
      break;

      case "CHANNEL_DESTROY":
      row_id = myreplace(data.call_id);
      var row = document.getElementById(row_id);
      if (row) {
        row.parentNode.removeChild(row);
      }
      $('#allcallscounter').text(document.getElementById('reseller_portal_current_calls_table').rows.length - 1);
      break;
    }
  };

  function myreplace(stringtowork){
    return stringtowork.replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
  };
{% endjavascript %}
