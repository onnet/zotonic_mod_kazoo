        <tr>
            <td style="text-align: center;">{{ call["filtered_call_date"] }}</td>
            <td style="text-align: center;">{{ call["calling_from"] }}</td>
            <td style="text-align: center;">{{ call["dialed_number"] }}</td>
            <td style="text-align: center;">{{ call["duration_seconds"] }}/{{ call["billing_seconds"] }}</td>
            <td style="text-align: center;">
                {% if call["recording_url"] and (call["billing_seconds"] > 3) %}

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
            <td style="text-align: center;"><i id="{{ #this_call_info }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i></td>
            {% wire id=#this_call_info action={ dialog_open title=_"Call details" template="_call_details.tpl" cdr_id=call["id"] width="auto" } %}
        </tr>
