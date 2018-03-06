                {% if call["media_recordings"] and (call["billing_seconds"] > 3) %}

                         <audio id="audio_{{ #this_call }}" preload="none">
                             <source src="{{ call["z_recording_download_link"][1] }}" type="audio/mp3">
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
                         <a href="{{ call["z_recording_download_link"][1] }}" download>
                            <i style="cursor: pointer;" class="fa fa-download" title="{_ Download _}"></i>
                         </a>
                {% else %}-{% endif %}
