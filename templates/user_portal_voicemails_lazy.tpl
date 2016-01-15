{% if m.kazoo[{ui_element_opened element="vmboxes_list_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}



{% javascript %}
// Redefine function in order stop key interception in dataTables filter field
// modules/mod_base/lib/js/modules/jquery.hotkeys.js
(function(jQuery){

        jQuery.each([ "keydown", "keyup", "keypress" ], function() {
                jQuery.event.special[ this ] = { add: 0 };
        });
})( jQuery );
{% endjavascript %}

<div id="vmboxes_list_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="vmboxes_list_widget_opened"}] %}display: none;{% endif %}">

{% for vmbox in m.kazoo.kz_list_user_vmboxes %}
{% wire id="label_"++vmbox["id"] type="click"
        action={ toggle target=vmbox["id"] }
        action={ toggle target="arrow_right_"++vmbox["id"] }
        action={ toggle target="arrow_down_"++vmbox["id"] }
%}
<div style="background-color: white; border-top: 1px solid rgb(153, 153, 153);">
  <span id="label_{{ vmbox["id"] }}" style="cursor: pointer;">
    <i id="arrow_right_{{ vmbox["id"] }}" style="padding-left: 2em; display: none;" class="fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ vmbox["id"] }}" style="padding-left: 2em;" class="fa fa-arrow-circle-down"></i>
  </span>
    <label style="padding: 0.5em;">Box: {{ vmbox["name"] }} ({{ vmbox["mailbox"] }})</label>
</div>
<div id={{ vmbox["id"] }}>
<table id={{ vmbox["mailbox"] }} class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center;">{_ Date _}</th>
            <th style="text-align: center;">{_ From _}</th>
            <th style="text-align: center;">{_ Status _}</th>
            <th style="text-align: center;">{_ Play _}</th>
            <th style="text-align: center;">{_ D/L _}</th>
            <th style="text-align: center;">{_ Delete _}</th>
        </tr>
    </thead>
    <tbody>
            {%  with m.kazoo[{kz_list_user_vmbox_details vmbox_id=vmbox["id"]}] as results %}
            {% for result in results %}
              {% for message in result["messages"] %}
                {% if not (message["folder"]=="deleted") %}
                    <tr>
                       <td style="text-align: center;">{{ message["timestamp"]|inno_timestamp_to_date }}</td>
                       <td style="text-align: center;">{{ message["caller_id_number"] }}</td>
                       <td style="text-align: center;">{{ message["folder"] }}</td>
                       <td style="text-align: center;">
                         <audio id="audio_{{ message["media_id"] }}">
                             <source src="{{ m.kazoo[{kz_vmessage_download_link vmbox_id=vmbox["id"] media_id=message["media_id"]}] }}" type="audio/mp3">
                         </audio>
                         <a id="play_{{ message["media_id"] }}" onclick='$("#audio_{{ message["media_id"] }}").trigger("play");
                                                                 $("#play_{{ message["media_id"] }}").toggle();
                                                                 $("#pause_{{ message["media_id"] }}").toggle();
                                                                  z_event("event_{{ message["media_id"] }}");'>
                            <i style="cursor: pointer;" class="fa fa-play" title="{_ Play _}"></i>
                         </a>
                         {% wire name="event_"++message["media_id"] 
                            action={postback postback={set_vm_message_folder folder="saved" vmbox_id=vmbox["id"] media_id=message["media_id"]} delegate="mod_kazoo"} %}
                         <a id="pause_{{ message["media_id"] }}" style="display: none;" onclick='$("#audio_{{ message["media_id"] }}").trigger("pause");
                                                                                         $("#play_{{ message["media_id"] }}").toggle();
                                                                                         $("#pause_{{ message["media_id"] }}").toggle();'>
                            <i style="cursor: pointer;" class="fa fa-pause" title="{_ Pause _}"></i>
                         </a>
                         <a  style="cursor: pointer;" id="stop_{{ message["media_id"] }}" onclick='$("#audio_{{ message["media_id"] }}").trigger("pause");
                                                                          $("#audio_{{ message["media_id"] }}").prop("currentTime",0);
                                                                          $("#play_{{ message["media_id"] }}").show();
                                                                          $("#pause_{{ message["media_id"] }}").hide();'>
                            <i class="fa fa-stop" title="{_ Stop _}"></i>
                         </a>
                       </td>
                       <td style="text-align: center;">
                           <a href="{{ m.kazoo[{kz_vmessage_download_link vmbox_id=vmbox["id"] media_id=message["media_id"]}] }}">
                             <i class="fa fa-download" title="{_ Download _}"></i>
                           </a>
                       </td>
                       <td style="text-align: center;">
                           <a><i id="delete_{{ message["media_id"] }}" style="cursor: pointer;" class="fa fa-trash-o" title="Delete"></i></a>
                       </td>
                       {% wire id="delete_"++message["media_id"] 
                               action={confirm text=_"Do you really want to delete message from "++message["caller_id_number"]++"?"
                                           action={postback postback={delete_vm_message vmbox_id=vmbox["id"] media_id=message["media_id"]} delegate="mod_kazoo"}
                                      }
                       %}
                    </tr>
                {% endif %}
              {% endfor %}
            {% endfor %}
            {% endwith %}
    </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#{{ vmbox["mailbox"] }}').dataTable({
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

});
{% endjavascript %}

</div>

{% endfor %}

</div>

{% endwith %}
{% else %}
{% endif %}
