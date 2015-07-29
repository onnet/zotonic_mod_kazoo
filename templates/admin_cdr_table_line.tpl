        <tr>
            <td style="text-align: center;">{{ call["datetime"] }} </td>
            <td style="text-align: center;">{{ call["calling_from"] }}</td>
            <td style="text-align: center;">{{ call["dialed_number"] }}</td>
            <td style="text-align: center;">{{ call["duration_seconds"] }}/{{ call["billing_seconds"] }}</td>
            <td style="text-align: center;">{% if call["recording_url"] and (call["billing_seconds"] > 3) %}

                         <audio id="audio_{{ call["timestamp"] }}">
                             <source src="{{ m.inno[{kz_recording_download_link cdr_id=call["id"]}] }}" type="audio/mp3">
                         </audio>
                         <a id="play_{{ call["timestamp"] }}" onclick='$("#audio_{{ call["timestamp"] }}").trigger("play");
                                                                 $("#play_{{ call["timestamp"] }}").toggle();
                                                                 $("#pause_{{ call["timestamp"] }}").toggle();
                                                                  z_event("event_{{ call["timestamp"] }}");'>
                            <i style="cursor: pointer;" class="fa fa-play" title="{_ Play _}"></i>
                         </a>
                         <a id="pause_{{ call["timestamp"] }}" style="display: none;" onclick='$("#audio_{{ call["timestamp"] }}").trigger("pause");
                                                                                         $("#play_{{ call["timestamp"] }}").toggle();
                                                                                         $("#pause_{{ call["timestamp"] }}").toggle();'>
                            <i style="cursor: pointer;" class="fa fa-pause" title="{_ Pause _}"></i>
                         </a>
                         <a  style="cursor: pointer;" id="stop_{{ call["timestamp"] }}" onclick='$("#audio_{{ call["timestamp"] }}").trigger("pause");
                                                                          $("#audio_{{ call["timestamp"] }}").prop("currentTime",0);
                                                                          $("#play_{{ call["timestamp"] }}").show();
                                                                          $("#pause_{{ call["timestamp"] }}").hide();'>
                            <i class="fa fa-stop" title="{_ Stop _}"></i>
                         </a>


            {% else %}-{% endif %}</td>
            <td style="text-align: center;"><i id="info_{{ call["timestamp"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i></td>
            {% wire id="info_"++call["timestamp"] action={ dialog_open title=_"Call details" template="_details.tpl" arg=call } %}
        </tr>
