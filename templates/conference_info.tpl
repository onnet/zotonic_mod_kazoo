
<div class="pl-10 pr-10 col-md-6 col-md-offset-3">

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
<div class="pl-10 pr-10 col-md-6">
</div>


{% javascript %}

  var socket = new WebSocket('{{ m.config.mod_kazoo.kazoo_blackhole_url.value }}');

  function send(data) {
      socket.send(JSON.stringify(data));
  }

  socket.onopen = function() {

    send({ action: 'unsubscribe', auth_token: '{{ m.session.kazoo_auth_token }}' });

    send({
        action: 'subscribe',
        account_id: '{{ account_id }}',
        auth_token: '{{ m.session.kazoo_auth_token }}',
        bindings: ['conference.event.{{ conference_id }}.*', 'conference.command.{{ conference_id }}']
    });

  }

  socket.onmessage = function(raw_message) {
    var data = JSON.parse(raw_message.data);
      console.log(data);

    switch(data.routing_key) {
      case "participant_event":
      z_event("update_conference_participants");
      console.log('called z_event: update_conference_participants');
      break;

      case "mute_participant":
      z_event("update_conference_participants");
      console.log('called z_event: update_conference_participants, case: mute_participant');
      break;

      case "unmute_participant":
      z_event("update_conference_participants");
      console.log('called z_event: update_conference_participants, case: unmute_participant');
      break;
    }

  };



/*

  socket.on('start-talking', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('stop-talking', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('kick-member', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('hup-member', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('del-member', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('add-member', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('unmute_participant', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('mute_participant', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });

  socket.on('participants_event', function (data) {
    console.log(data);
    z_event("update_conference_participants");
  });
*/

{% endjavascript %}

