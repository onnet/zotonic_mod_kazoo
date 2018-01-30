{% wire name="channel_hangup" action={postback postback="channel_hangup_confirm" delegate="mod_kazoo"} %}
{% wire name="channel_transfer" action={postback postback="channel_transfer_dialog" delegate="mod_kazoo"} %}
{% wire name="channel_eavesdrop" action={postback postback="channel_eavesdrop_dialog" delegate="mod_kazoo"} %}
<table id="admin_portal_current_calls_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;">{_ CallId _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;">{_ Account _}</th>
      <th style="text-align: center;">{_ Caller Number _}</th>
      <th style="text-align: center;">{_ Callee Number _}</th>
      <th style="text-align: center;">{_ Realm _}</th>
      <th style="text-align: center;">{_ Status _}</th>
      <th style="text-align: center;">{_ Elapsed _}</th>
      <th style="text-align: center;">{_ Hang Up _}</th>
      <th style="text-align: center;"></th>
    </td>
  </thead>
  <tbody id="currentcallstableid">
    {% for running_call in m.kazoo.get_reseller_channels %} 
      {% if running_call[1]["direction"]=="inbound" %}
      <tr>
        <td style="text-align: center;">
          {{ running_call[1]["uuid"]|cleanout }}
        </td>
        <td style="text-align: center;">
          {{ running_call[1]["timestamp"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}
        </td>
        <td style="text-align: center;">
        </td>
        <td style="text-align: center;">
          {{ running_call[1]["presence_id"]|split:"@"|first }}
        </td>
        <td style="text-align: center;">
          {{ running_call[1]["destination"] }}
        </td>
        <td style="text-align: center;">
          <a id="realm_{{ running_call[1]["uuid"]|cleanout }}"
             href="#">{{ running_call[1]["presence_id"]|split:"@"|last }}</a>
          {% wire id="realm_"++running_call[1]["uuid"]|cleanout
                  action={postback postback={redirect_to_reseller_portal
                                             realm=running_call[1]["presence_id"]|split:"@"|last
                                            }
                                   delegate="mod_kazoo"}
          %}
        </td>
        <td style="text-align: center;">
          {% if running_call[1]["answered"] %}
            {_ answered _}
          {% else %}
            {_ ringing _}
          {% endif %}
        </td>
        <td style="text-align: center;">
          {{ running_call[1]["elapsed_s"]|inno_seconds_to_time:"hms" }}
        </td>
        <td style="text-align: center;">
          <i id="hangup_{{ running_call[1]["uuid"]|cleanout }}"
             class="dark-1 icon-telicon-hangup pointer"></i>
          {% wire id="hangup_"++running_call[1]["uuid"]|cleanout
                  action={postback postback={channel_hangup_confirm channel_id=running_call[1]["uuid"]}
                                   delegate="mod_kazoo"
                         }
          %}
        </td>
        <td style="text-align: center;">
          <i id="info_{{ running_call[1]["uuid"]|cleanout }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++running_call[1]["uuid"]|cleanout
                  action={dialog_open title=_"Call details"
                                      template="_details.tpl"
                                      arg=running_call
                         }
          %}
        </td>
      </tr>
      {% endif %}
    {% endfor %}
  </tbody>
</table>

{% javascript %}

  function myreplace(stringtowork){
    return stringtowork.replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
  };

  function get_calee_id_number(data_obj){
    var callee_id_number;
    if (data_obj["callee_id_number"]) {
        callee_id_number = data_obj["callee_id_number"]
    } else if (data_obj["to"]) {
        callee_id_number = data_obj["to"].split("@",1)
    } else {
      callee_id_number = "not_found";
    }
    return callee_id_number;
  };

  function seconds_to_time(seconds){
    console.log("log seconds");
    console.log(seconds);
    if (seconds) {
        var timestr;
        timestr = new Date(seconds * 1000).toISOString().substr(11, 8);
    } else {
        timestr = "not_found";
    }
    return timestr;
  };

  function maybe_account_name(data_obj){
    if (data_obj.custom_channel_vars) {
        namestr = data_obj.custom_channel_vars.account_name;
    } else {
        namestr = " ";
    }
    return namestr;
  };

  function maybe_presence(data_obj){
    if (data_obj.presence_id) {
        realm_str = data_obj.presence_id.split("@")[1];
    } else {
        realm_str = " ";
    }
    return namestr;
  };

  var oTable = $('#admin_portal_current_calls_table').dataTable({
    "pagingType": "simple",
    "bFilter" : true,
    "aaSorting": [[ 0, "desc" ]],
    "aLengthMenu" : [[5, 15, -1], [5, 15, "{_ All _}"]],
    "iDisplayLength" : -1,
    "oLanguage" : {
            "sInfoThousands" : " ",
            "sLengthMenu" : "_MENU_ {_ lines per page _}",
            "sSearch" : "{_ Filter _}:",
            "sZeroRecords" : "{_ Nothing found, sorry _}",
            "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
            "sInfoEmpty" : "{_ Showing 0 entries _}",
            "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
            "oPaginate" : {
                    "sPrevious" : "{_ Back _}",
                    "sNext" : "{_ Forward _}"
            }
    },
    "columnDefs": [
                { "targets": [ 0 ], "visible": false },
                { "targets": [ 1 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 2 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 3 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 4 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 5 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 6 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 7 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 8 ], className: "td-center", "defaultContent": " " },
                { "targets": [ 9 ], className: "td-center", "defaultContent": " " },
    ],
    "fnCreatedRow": function( nRow, aData, iDataIndex ) {
         $(nRow).attr('id', aData[0]);
    }
  });

  var socket = new WebSocket('{{ m.config.mod_kazoo.kazoo_blackhole_url.value }}');
 
  function send(data) {
      socket.send(JSON.stringify(data));
  }

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

  }

  socket.onmessage = function(raw_message) {
    var data_obj = JSON.parse(raw_message.data);
    console.log(data_obj);
    if (data_obj.data.custom_channel_vars) {
        console.log(data_obj.data.custom_channel_vars.account_name);
    };
    var data = data_obj.data;

    switch(data.event_name) {
      case "CHANNEL_CREATE":
      if ( data["call_direction"] == "inbound") {
        $(".dataTables_empty").remove();
        row_id = myreplace(data["call_id"]);
        if ($("#"+row_id).length == 0) {
            oTable.api().row.add([row_id, 
                                  '',
                                  maybe_account_name(data), 
                                  data.caller_id_number, 
                                  get_calee_id_number(data), 
                                  maybe_presence(data), 
                                  '{_ ringing _}', 
                                  seconds_to_time(data["elapsed_s"]), 
                                  '<i class="dark-1 icon-telicon-hangup pointer" \
                                      onclick="z_event('+"'channel_hangup'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>',
                                  '' 
                                 ]).draw();
        }
      }
      break;

      case "CHANNEL_ANSWER":
      row_id = myreplace(data["call_id"]);
      oTable.api().row('#'+row_id).data([row_id,
                                         '',
                                         maybe_account_name(data), 
                                         data.caller_id_number, 
                                         get_calee_id_number(data), 
                                   //    data["caller_id_number"]+' <i class="dark-1 icon-telicon-failover pointer" \
                                   //                                  onclick="z_event('+"'channel_transfer'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>', 
                                   //    data["callee_id_number"]+' <i class="dark-1 icon-telicon-failover pointer" \
                                   //                                  onclick="z_event('+"'channel_transfer'"+", \
                                   //                                                   {channel_id: '"+data["Other-Leg-call_id"]+"'"+' } \
                                   //                                                  );"></i>', 
                                         maybe_presence(data), 
                                         '{_ answered _}', 
                                         seconds_to_time(data["elapsed_s"]), 
                                         '<i class="dark-1 icon-telicon-hangup pointer" \
                                             onclick="z_event('+"'channel_hangup'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>',
                                         '' 
                                        ]).draw();
      break;

      case "CHANNEL_DESTROY":
      row_id = myreplace(data["call_id"]);
      oTable.api().row('#'+row_id).remove().draw();
      break;
    }

  };

{% endjavascript %}
