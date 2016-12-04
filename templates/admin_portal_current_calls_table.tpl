{% wire name="channel_hangup" action={postback postback="channel_hangup_confirm" delegate="mod_kazoo"} %}
{% wire name="channel_transfer" action={postback postback="channel_transfer_dialog" delegate="mod_kazoo"} %}
{% wire name="channel_eavesdrop" action={postback postback="channel_eavesdrop_dialog" delegate="mod_kazoo"} %}
<table id="admin_portal_current_calls_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;">{_ CallId _}</th>
      <th style="text-align: center;">{_ Caller Number _}</th>
      <th style="text-align: center;">{_ Callee Number _}</th>
      <th style="text-align: center;">{_ Status _}</th>
      <th style="text-align: center;">{_  _}</th>
      <th style="text-align: center;">{_ Hang Up _}</th>
    </td>
  </thead>
  <tbody id="currentcallstableid">
    {% for running_call in m.kazoo[{kz_list_account_channels account_id=account_id}] %} 
      {% if running_call["direction"]=="inbound" %}
      <tr>
        <td style="text-align: center;">{{ running_call["uuid"]|cleanout }}</td>
        <td style="text-align: center;">{{ running_call["presence_id"]|split:"@"|first }}
                                        {# if running_call["answered"] #}
                                     <!--     <i id="caller_{{ running_call["uuid"]|cleanout }}" class="dark-1 icon-telicon-failover"></i> -->
                                        {# endif #}
        </td>
        {% wire id="caller_"++running_call["uuid"]|cleanout
                action={postback postback={channel_transfer_dialog channel_id=running_call["uuid"]} delegate="mod_kazoo"}
        %}
        <td style="text-align: center;">{{ running_call["destination"] }}
                                        {# if running_call["answered"] #}
                                     <!--     <i id="callee_{{ running_call["uuid"]|cleanout }}" class="dark-1 icon-telicon-failover"></i> -->
                                        {# endif #}
        </td>
        {% wire id="callee_"++running_call["uuid"]|cleanout
                action={postback postback={channel_transfer_dialog channel_id=running_call["other_leg"]} delegate="mod_kazoo"}
        %}
        <td style="text-align: center;">{% if running_call["answered"] %}{_ answered _}{% else %}{_ ringing _}{% endif %}</td>
        <td style="text-align: center;"><i id="eavesdrop_{{ running_call["uuid"]|cleanout }}" class="fa fa-volume-up pointer"></i></td>
        {% wire id="eavesdrop_"++running_call["uuid"]|cleanout
                action={postback postback={channel_eavesdrop_dialog channel_id=running_call["uuid"]} delegate="mod_kazoo"}
        %}
        <td style="text-align: center;"><i id="hangup_{{ running_call["uuid"]|cleanout }}" class="dark-1 icon-telicon-hangup pointer"></i></td>
        {% wire id="hangup_"++running_call["uuid"]|cleanout
                action={postback postback={channel_hangup_confirm channel_id=running_call["uuid"]} delegate="mod_kazoo"}
        %}
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

  var oTable = $('#admin_portal_current_calls_table').dataTable({
    "pagingType": "simple",
    "bFilter" : true,
    "aaSorting": [[ 0, "desc" ]],
    "aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
    "iDisplayLength" : 5,
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
                { "targets": [ 1 ], className: "td-center" },
                { "targets": [ 2 ], className: "td-center" },
                { "targets": [ 3 ], className: "td-center" },
                { "targets": [ 4 ], className: "td-center" },
                { "targets": [ 5 ], className: "td-center" },
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
        account_id: '{{ account_id }}',
        binding: 'call.*.*'
        }
    });


    send({
        action: 'subscribe',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        data: {
        account_id: '{{ account_id }}',
        binding: 'call.*.*'}
      //  bindings: ['call.CHANNEL_CREATE.*', 'call.CHANNEL_ANSWER.*', 'call.CHANNEL_DESTROY.*']
    });

  }

  socket.onmessage = function(raw_message) {
    var data_obj = JSON.parse(raw_message.data);
    console.log(data_obj);
    var data = data_obj.data;

    switch(data.event_name) {
      case "CHANNEL_CREATE":
      if ( data["call_direction"] == "inbound") {
        $(".dataTables_empty").remove();
        row_id = myreplace(data["call_id"]);
        if ($("#"+row_id).length == 0) {
            oTable.api().row.add([row_id, 
                                  data["caller_id_number"], 
                                  get_calee_id_number(data), 
                                  '{_ ringing _}', 
                                  '', 
                                  '<i class="dark-1 icon-telicon-hangup pointer" \
                                      onclick="z_event('+"'channel_hangup'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>'
                                 ]).draw();
        }
      }
      break;

      case "CHANNEL_ANSWER":
      row_id = myreplace(data["call_id"]);
      oTable.api().row('#'+row_id).data([row_id,
                                         data["caller_id_number"], 
                                         get_calee_id_number(data), 
                                   //    data["caller_id_number"]+' <i class="dark-1 icon-telicon-failover pointer" \
                                   //                                  onclick="z_event('+"'channel_transfer'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>', 
                                   //    data["callee_id_number"]+' <i class="dark-1 icon-telicon-failover pointer" \
                                   //                                  onclick="z_event('+"'channel_transfer'"+", \
                                   //                                                   {channel_id: '"+data["Other-Leg-call_id"]+"'"+' } \
                                   //                                                  );"></i>', 
                                         '{_ answered _}', 
                                         '<i class="fa fa-volume-up pointer" \
                                             onclick="z_event('+"'channel_eavesdrop'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>',
                                         '<i class="dark-1 icon-telicon-hangup pointer" \
                                             onclick="z_event('+"'channel_hangup'"+", { channel_id: '"+data["call_id"]+"'"+' });"></i>'
                                        ]).draw();
      break;

      case "CHANNEL_DESTROY":
      row_id = myreplace(data["call_id"]);
      oTable.api().row('#'+row_id).remove().draw();
      break;
    }

  };

{% endjavascript %}
