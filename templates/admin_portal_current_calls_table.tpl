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
        {% wire id="caller_"++running_call["uuid"]|cleanout action={postback postback={channel_transfer_dialog channel_id=running_call["uuid"]} delegate="mod_kazoo"} %}
        <td style="text-align: center;">{{ running_call["destination"] }}
                                        {# if running_call["answered"] #}
                                     <!--     <i id="callee_{{ running_call["uuid"]|cleanout }}" class="dark-1 icon-telicon-failover"></i> -->
                                        {# endif #}
        </td>
        {% wire id="callee_"++running_call["uuid"]|cleanout action={postback postback={channel_transfer_dialog channel_id=running_call["other_leg"]} delegate="mod_kazoo"} %}
        <td style="text-align: center;">{% if running_call["answered"] %}{_ answered _}{% else %}{_ ringing _}{% endif %}</td>
        <td style="text-align: center;"><i id="eavesdrop_{{ running_call["uuid"]|cleanout }}" class="fa fa-volume-up pointer"></i></td>
        {% wire id="eavesdrop_"++running_call["uuid"]|cleanout action={postback postback={channel_eavesdrop_dialog channel_id=running_call["uuid"]} delegate="mod_kazoo"} %}
        <td style="text-align: center;"><i id="hangup_{{ running_call["uuid"]|cleanout }}" class="dark-1 icon-telicon-hangup pointer"></i></td>
        {% wire id="hangup_"++running_call["uuid"]|cleanout action={postback postback={channel_hangup_confirm channel_id=running_call["uuid"]} delegate="mod_kazoo"} %}
     </tr>
  {# print running_call #}
  {% endif %}
  {% endfor %}
</tbody>
</table>

  {# for running_call in m.kazoo[{kz_list_account_channels account_id=account_id}] #} 
    {# print forloop.counter #}
    {# print running_call #}
    {# print m.kazoo[{kz_channel_info uuid=running_call["other_leg"] account_id=account_id}] #}
  {# endfor #}

{# m.kazoo[{kz_channel_info uuid=running_call["other_leg"] account_id=account_id}][1]["destination"] #}

{% javascript %}
  function myreplace(stringtowork){
      stringtowork.replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
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

  var socket = io.connect('{{ m.config.mod_kazoo.kazoo_blackhole_url.value }}');
  socket.emit("unsubscribe", { auth_token: "{{ m.session.kazoo_auth_token }}" });
  socket.emit("subscribe", { account_id: "{{ account_id }}", auth_token: "{{ m.session.kazoo_auth_token }}", binding: "call.CHANNEL_CREATE.*"});
  socket.emit("subscribe", { account_id: "{{ account_id }}", auth_token: "{{ m.session.kazoo_auth_token }}", binding: "call.CHANNEL_ANSWER.*"});
  socket.emit("subscribe", { account_id: "{{ account_id }}", auth_token: "{{ m.session.kazoo_auth_token }}", binding: "call.CHANNEL_DESTROY.*"});
  socket.on("CHANNEL_CREATE", function (data) {
    if ( data["Other-Leg-Call-ID"] && data["Call-ID"] && data["Other-Leg-Caller-ID-Number"] && data["Caller-ID-Number"] && data["Caller-ID-Number"] != "context_2" && data["Callee-ID-Number"] != "context_2" ) {
        $(".dataTables_empty").remove();
        console.log(data["Call-ID"].toString());
        row_id = data["Call-ID"].replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
        console.log("Attempt to add row_id: "+row_id);
        if ($("#"+row_id).length == 0) {
            oTable.api().row.add([row_id, 
                              data["Caller-ID-Number"], 
                              data["Callee-ID-Number"], 
                              '{_ ringing _}', 
                              '', 
                              '<i class="dark-1 icon-telicon-hangup pointer" onclick="z_event('+"'channel_hangup'"+", { channel_id: '"+data["Call-ID"]+"'"+' });"></i>' ]).draw();
        }
    }
    console.log(data); // data = EventJObj
  });
  socket.on("CHANNEL_ANSWER", function (data) {
        row_id = data["Call-ID"].replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
        oTable.api().row('#'+row_id).data([row_id,
                          data["Caller-ID-Number"], 
                          data["Callee-ID-Number"], 
                    //    data["Caller-ID-Number"]+' <i class="dark-1 icon-telicon-failover pointer" onclick="z_event('+"'channel_transfer'"+", { channel_id: '"+data["Call-ID"]+"'"+' });"></i>', 
                    //    data["Callee-ID-Number"]+' <i class="dark-1 icon-telicon-failover pointer" onclick="z_event('+"'channel_transfer'"+", { channel_id: '"+data["Other-Leg-Call-ID"]+"'"+' });"></i>', 
                          '{_ answered _}', 
                          '<i class="fa fa-volume-up pointer" onclick="z_event('+"'channel_eavesdrop'"+", { channel_id: '"+data["Call-ID"]+"'"+' });"></i>',
                          '<i class="dark-1 icon-telicon-hangup pointer" onclick="z_event('+"'channel_hangup'"+", { channel_id: '"+data["Call-ID"]+"'"+' });"></i>' ]).draw();
    console.log(data);
  });
  socket.on("CHANNEL_DESTROY", function (data) {
        row_id = data["Call-ID"].replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
        oTable.api().row('#'+row_id).remove().draw();
        console.log(data);
  });
{% endjavascript %}
