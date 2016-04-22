        <tr>
            <td style="text-align: center;">{{ call["filtered_call_date"] }}</td>
            <td style="text-align: center;">{{ call["calling_from"] }}</td>
            <td style="text-align: center;">{{ call["dialed_number"] }}</td>
            <td style="text-align: center;">{{ call["duration_seconds"] }}/{{ call["billing_seconds"] }}</td>
            <td style="text-align: center;">
                {% if call["media_name"] and (call["billing_seconds"] > 3) %}

                         <audio id="audio_{{ #this_call }}" preload="none">
                             <source src="{{ call["z_recording_download_link"] }}" type="audio/mp3">
                         </audio>
                         <a id="play_{{ #this_call }}" onclick='$("#audio_{{ #this_call }}").trigger("play");
                                                                 $("#play_{{ #this_call }}").toggle();
                                                                 $("#pause_{{ #this_call }}").toggle();'>
                            <i style="cursor: pointer;" class="fa fa-play" title="{_ Play _}"></i>
                         </a>
                         <a id="pause_{{ #this_call }}" style="display: none;" onclick='$("#audio_{{ #this_call }}").trigger("pause");
                                                                                         $("#play_{{ #this_call }}").toggle();
                                                                                         $("#pause_{{ #this_call }}").toggle();'>
                            <i style="cursor: pointer;" class="fa fa-pause" title="{_ Pause _}"></i>
                         </a>
                         <a  style="cursor: pointer;" id="stop_{{ #this_call }}" onclick='$("#audio_{{ #this_call }}").trigger("pause");
                                                                          $("#audio_{{ #this_call }}").prop("currentTime",0);
                                                                          $("#play_{{ #this_call }}").show();
                                                                          $("#pause_{{ #this_call }}").hide();'>
                            <i class="fa fa-stop" title="{_ Stop _}"></i>
                         </a>
                         <a href="{{ call["z_recording_download_link"] }}" download>
                            <i style="cursor: pointer;" class="fa fa-download" title="{_ Download _}"></i>
                         </a>
                {% else %}-{% endif %}
            </td>
            <td style="text-align: center;">
                <i id="{{ #this_call_info }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>

            <i id="{{ #this_call_info2 }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>
            {% wire id=#this_call_info2 action={ dialog_open title=_"Call details" template="_call_details.tpl" cdr_id=call["id"] width="auto" } %}

            </td>
            {% wire id=#this_call_info action={update target="admin_portal_call_details_tpl"
                                                      title=_"Call details"
                                                      template="admin_portal_call_details.tpl"
                                                      cdr_id=call["id"]
                                                      headline=_"Call details"
                                              }
                                       action={script script="$('i.zalarm').addClass('zprimary'); $('i.zalarm').removeClass('zalarm');"}
                                       action={remove_class target=#this_call_info class="zprimary"}
                                       action={add_class target=#this_call_info class="zalarm"}
            %}
        </tr>
{% print call %}
