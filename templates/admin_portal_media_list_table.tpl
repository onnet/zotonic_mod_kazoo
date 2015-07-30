{% if m.kazoo[{ui_element_opened element="ap_media_widget_opened"}] %}
<table id="admin_portal_media_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center1;">{_ Prompt Name _}</th>
            <th style="text-align: center;">{_ Play _}</th>
            <th style="text-align: center;">{_ Download _}</th>
            <th style="text-align: center;">Edit</th>
            <th style="text-align: center;">Delete</th>
        </tr>
    </thead>
    <tbody>
        {% for prompt in m.kazoo.kz_list_account_media %}
	<tr>
            <td style="text-align: center1;">{{ prompt["name"] }}</td>
            <td style="text-align: center;">
              <audio id="audio_{{ prompt["id"] }}" preload="none">
                  <source src="/getprompt/id/{{ prompt["id"] }}">
              </audio>
              <a id="play_{{ prompt["id"] }}" onclick='$("#audio_{{ prompt["id"] }}").trigger("play");
                                                      $("#play_{{ prompt["id"] }}").toggle();
                                                      $("#pause_{{ prompt["id"] }}").toggle();'>
                 <i style="cursor: pointer;" class="fa fa-play" title="{_ Play _}"></i>
              </a>
              <a id="pause_{{ prompt["id"] }}" style="display: none;" onclick='$("#audio_{{ prompt["id"] }}").trigger("pause");
                                                                              $("#play_{{ prompt["id"] }}").toggle();
                                                                              $("#pause_{{ prompt["id"] }}").toggle();'>
                 <i style="cursor: pointer;" class="fa fa-pause" title="{_ Pause _}"></i>
              </a>
              <a  style="cursor: pointer;" id="stop_{{ prompt["id"] }}" onclick='$("#audio_{{ prompt["id"] }}").trigger("pause");
                                                               $("#audio_{{ prompt["id"] }}").prop("currentTime",0);
                                                               $("#play_{{ prompt["id"] }}").show();
                                                               $("#pause_{{ prompt["id"] }}").hide();'>
                 <i class="fa fa-stop" title="{_ Stop _}"></i>
              </a>
            </td>
            <td style="text-align: center;"><a href="/getprompt/id/{{ prompt["id"] }}"><i class="fa fa-download" title="{_ Download _}"></i></a></td>
            <td style="text-align: center;"><i id="edit_{{ prompt["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++prompt["id"] action={ dialog_open title=_"Edit prompt "++prompt["name"] template="_edit_media_lazy.tpl" prompt_id=prompt["id"] } %}
            <td style="text-align: center;"><i id="delete_{{ prompt["id"] }}" class="fa fa-trash-o pointer" title="{_ Delete _}"></i></td>
            {% wire id="delete_"++prompt["id"]
                    action={confirm text=_"Do you really want to delete prompt "++prompt["name"]++"?"
                                action={postback postback={delete_prompt prompt_id=prompt["id"]} delegate="mod_kazoo"}
                           }
            %}
        </tr>
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_media_table').dataTable({
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
],

});
{% endjavascript %}
{% else %}
{% endif %}

