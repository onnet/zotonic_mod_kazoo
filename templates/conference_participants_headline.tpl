{% with m.kazoo[{kz_get_account_conference conference_id=conference_id}] as conference_details %}
  {% if conference_details[1]["_read_only"][1]["participants"] %}
    {# headline #}
    <span>{_ Conference duration _}: </span><span id="hours">--</span>:<span id="minutes">--</span>:<span id="seconds">--</span>
    <script>
      var conf_duration_sec;
      var conf_timer;
      conf_duration_sec = {{ conference_details[1]["_read_only"][1]["duration"] }};
      function pad(val) {
          return val > 9 ? val : "0" + val;
      }
      clearInterval(conf_timer);
      clearTimeout(conf_timer);
      conf_timer = setInterval(function () {
          document.getElementById("seconds").innerHTML = pad(++conf_duration_sec % 60);
          document.getElementById("minutes").innerHTML = pad(parseInt(conf_duration_sec / 60, 10) - parseInt(conf_duration_sec / 3600, 10)*60);
          document.getElementById("hours").innerHTML = pad(parseInt(conf_duration_sec / 3600, 10));
      }, 1000);
    </script>
    <i id="refresh_conference_icon" class="fa fa-refresh zprimary pointer" style="margin: 0.1em 1em 0 1em" title="Refresh"></i>
    {% wire id="refresh_conference_icon" action={emit signal={update_conference_participants_tpl} } %}
    {% if conference_details[1]["_read_only"][1]["is_locked"] %} 
      <i id="locked_conference_icon" class="fa fa-lock zalarm" style="margin: 0.1em 0 0 8em" title="Locked"></i>
      <i id="unlock_conference_icon" class="fa fa-toggle-on zalarm pointer" style="margin: 0.1em 0 0 0" title="Unlock"></i>
      {% wire id="unlock_conference_icon"
              action={confirm text=_"Do you really want to unlock conference?"
                              action={postback postback={do_conference_action action="unlock" conference_id=conference_id} delegate="mod_kazoo"}
                     }
       %}
    {% else %}
      <i id="unlocked_conference_icon" class="fa fa-unlock zprimary" style="margin: 0.1em 0 0 8em" title="Unlocked"></i>
      <i id="lock_conference_icon" class="fa fa-toggle-off zprimary pointer" style="margin: 0.1em 0 0 0" title="Lock"></i>
      {% wire id="lock_conference_icon"
              action={confirm text=_"Do you really want to lock conference?"
                              action={postback postback={do_conference_action action="lock" conference_id=conference_id} delegate="mod_kazoo"}
                     }
       %}
    {% endif %}
  {% else %}
    {_ Conference is empty now _}
    <script>
      if (typeof conf_timer != 'undefined') {
        clearInterval(conf_timer);
        clearTimeout(conf_timer);
      };
    </script>
  {% endif %}
{% endwith %}
