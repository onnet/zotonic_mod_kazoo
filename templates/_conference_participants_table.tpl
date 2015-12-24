{% if m.kazoo[{ui_element_opened element="conference_participants_widget_opened"}] %}
<table id="current_participants_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center1;">{_ Participant _}</th>
            <th style="text-align: center;">{_ Microphone _}</th>
            <th style="text-align: center;">{_ Kick off _}</th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody>
        {% for participant in m.kazoo[{kz_conference_details conference_id=conference_id}] %}
	<tr>
            <td style="text-align: center1;">{{ participant["Custom-Channel-Vars"][1]["Presence-ID"]|split:"@"|first }}</td>
            <td style="text-align: center;">
              {% if not participant["Mute"] %}
                <i id="mic_{{ participant["Participant-ID"] }}" class="fa fa-check zprimary pointer" title="Enabled"></i>
               {% wire id="mic_"++participant["Participant-ID"] action={confirm text="Do you really want to switch mocrophone off?"
                                                                            action={postback postback={do_conference_action conference_id=conference_id 
                                                                                                                            action="mute"
                                                                                                                            participant_id=participant["Participant-ID"]}
                                                                                             delegate="mod_kazoo"
                                                                                   }
                                                                        }
               %} 
              {% else %}
                <i id="mic_{{ participant["Participant-ID"] }}"  class="fa fa-remove zalarm pointer" title="Disabled"></i>
               {% wire id="mic_"++participant["Participant-ID"] action={confirm text="Do you really want to switch mocrophone on?"
                                                                            action={postback postback={do_conference_action conference_id=conference_id 
                                                                                                                            action="unmute"
                                                                                                                            participant_id=participant["Participant-ID"]}
                                                                                             delegate="mod_kazoo"
                                                                                   }
                                                                        }
               %} 
              {% endif %}
            </td>
            <td style="text-align: center;"><i id="kick_{{ participant["Participant-ID"] }}" style="cursor: pointer;" class="fa fa-trash-o" title="Delete"></i></td>
            {% wire id="kick_"++participant["Participant-ID"] action={confirm text="Do you really want to kick this participant off?"
                                                                         action={postback postback={do_conference_action conference_id=conference_id 
                                                                                                                         action="kick"
                                                                                                                         participant_id=participant["Participant-ID"]}
                                                                                          delegate="mod_kazoo"
                                                                                }
                                                                     }
            %} 
            <td style="text-align: center;"><i id="pinfo_{{ participant["Participant-ID"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Participant information _}"></i></td>
            {% wire id="pinfo_"++participant["Participant-ID"] action={ dialog_open title=participant["Custom-Channel-Vars"][1]["Presence-ID"]|split:"@"|first
                                                                                    template="_details_conference.tpl"
                                                                                    conference_id=conference_id width="auto" }
            %}
        </tr>
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#current_participants_table').dataTable({
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

