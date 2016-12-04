{% with m.session.selected_conference_id as conference_id %}
{% wire name="update_conference_participants_table_line" action={postback postback="update_conference_participants_table_line" delegate="mod_kazoo"} %}
{% wire name="add_conference_participants_table_line" action={postback postback="add_conference_participants_table_line" delegate="mod_kazoo"} %}
{% wire name="maybe_update_conference_participants_headline" action={postback postback="maybe_update_conference_participants_headline" delegate="mod_kazoo"} %}

<div class="pl-10 pr-10 col-md-8 col-md-offset-2">
  {% wire action={connect signal={update_conference_participants_tpl} action={update target="conference_participants_tpl"
                                                                                  template="_conference_participants.tpl"
                                                                                  headline=_"Current participants"
                                                                                  conference_id=conference_id}}
  %}
  {% wire name="update_conference_participants" action={emit signal={update_conference_participants_tpl}} %}
  <span id="conference_participants_tpl">
        {% include "_conference_participants.tpl" headline=_"Current participants" conference_id=conference_id %}
  </span>
</div>

{% javascript %}

  var socket = new WebSocket('{{ m.config.mod_kazoo.kazoo_blackhole_url.value }}');

  function send(data) {
      socket.send(JSON.stringify(data));
  }

  socket.onopen = function() {

    send({
        action: 'unsubscribe',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        data: {
          account_id: '{{ account_id }}',
          binding: 'conference.command.{{ conference_id }}'
        }
    });

    send({
        action: 'subscribe',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        data: {
          account_id: '{{ m.session.kazoo_account_id }}',
          binding: 'conference.event.{{ conference_id }}.*'
          // bindings: ['conference.event.{{ conference_id }}.*', 'conference.command.{{ conference_id }}']
        }
    });

    send({
        action: 'subscribe',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        data: {
          account_id: '{{ m.session.kazoo_account_id }}',
          //  bindings: ['conference.event.{{ conference_id }}.*', 'conference.command.{{ conference_id }}']
          binding: 'conference.command.{{ conference_id }}'
        }
    });

  }

  socket.onmessage = function(raw_message) {
    var data_obj = JSON.parse(raw_message.data);
    console.log(data_obj);
    var data = data_obj.data;

    switch(data_obj.action) {
      case "event":
        handle_participant_event(data);
      break;

    }

  };

  function handle_participant_event(data) {
    switch(data.event) {
      case "start-talking":
        console.log("start-talking-" + data.participant_id);
        document.getElementById("talking_" + data.participant_id).className = "fa fa-volume-control-phone zalarm";
      break;

      case "stop-talking":
        console.log("stop-talking-" + data.participant_id);
        document.getElementById("talking_" + data.participant_id).className = "fa fa-phone zprimary";
      break;

      case "mute-member":
        console.log("mute-member-" + data.participant_id);
        z_event("update_conference_participants_table_line", { conference_id: data.conference_id, participant_id: data.participant_id });
      break;

      case "unmute-member":
        console.log("unmute-member-" + data.participant_id);
        z_event("update_conference_participants_table_line", { conference_id: data.conference_id, participant_id: data.participant_id });
      break;

      case "deaf-member":
        console.log("deaf-member-" + data.participant_id);
        z_event("update_conference_participants_table_line", { conference_id: data.conference_id, participant_id: data.participant_id });
      break;

      case "undeaf-member":
        console.log("undeaf-member-" + data.participant_id);
        z_event("update_conference_participants_table_line", { conference_id: data.conference_id, participant_id: data.participant_id });
      break;

      case "add-member":
        console.log("add-member-" + data.participant_id);
        z_event("add_conference_participants_table_line", { conference_id: data.conference_id, participant_id: data.participant_id });
        z_event("maybe_update_conference_participants_headline", { conference_id: data.conference_id, event_name: data.event});
      break;

      case "del-member":
        console.log("del-member-" + data.participant_id);
        document.getElementById("participants_table_line_id_" + data.participant_id).remove();
        z_event("maybe_update_conference_participants_headline", { conference_id: data.conference_id, event_name: data.event});
      break;

      default:
        console.log("Not handled event: " + data.event + " " + data.participant_id)
    }
  };

{% endjavascript %}

{% endwith %}
