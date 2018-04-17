<audio id="audio_{{ #this_recording }}" preload="none">
  <source src="/kzattachment?account_id={{ m.session.kazoo_account_id }}&doc_type=call_recording&recording_id={{ recording["id"] }}&auth_token={{ m.session.kazoo_auth_token }}" type="audio/mp3">
</audio>
<a id="play_{{ #this_recording }}"
   onclick='$("#audio_{{ #this_recording }}").trigger("play");
            $("#play_{{ #this_recording }}").toggle();
            $("#pause_{{ #this_recording }}").toggle();'>
  <i style="cursor: pointer;" class="fa fa-play" title="{_ Play _}"></i>
</a>
<a id="pause_{{ #this_recording }}"
   style="display: none;"
   onclick='$("#audio_{{ #this_recording }}").trigger("pause");
            $("#play_{{ #this_recording }}").toggle();
            $("#pause_{{ #this_recording }}").toggle();'>
  <i style="cursor: pointer;" class="fa fa-pause" title="{_ Pause _}"></i>
</a>
<a style="cursor: pointer;"
   id="stop_{{ #this_recording }}"
   onclick='$("#audio_{{ #this_recording }}").trigger("pause");
            $("#audio_{{ #this_recording }}").prop("currentTime",0);
            $("#play_{{ #this_recording }}").show();
            $("#pause_{{ #this_recording }}").hide();'>
  <i class="fa fa-stop" title="{_ Stop _}"></i>
</a>
<a href="/kzattachment?account_id={{ m.session.kazoo_account_id }}&doc_type=call_recording&recording_id={{ recording["id"] }}&auth_token={{ m.session.kazoo_auth_token }}" download>
   <i style="cursor: pointer;" class="fa fa-download" title="{_ Download _}"></i>
</a>
