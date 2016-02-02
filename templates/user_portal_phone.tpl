{% if not m.session.webrtc_dev_sip_username %}
    {_ Choose a device to register then make calls from right here in your web browser _}.
{% else %}

    <audio id="ringtone" src="/lib/images/incoming.mp3" loop></audio>
    <audio id="ringbacktone" src="/lib/images/outgoing.mp3" loop></audio>
    <audio id="dtmfTone" src="/lib/images/dtmf.mp3"></audio>
    <audio id="remote-media"></audio>

    <div id="phone">
        <div class="dialpad">
          <div class="line">
            <div class="button">1</div>
            <div class="button">2</div>
            <div class="button">3</div>
          </div>
          <div class="line">
            <div class="button">4</div>
            <div class="button">5</div>
            <div class="button">6</div>
          </div>
          <div class="line">
            <div class="button">7</div>
            <div class="button">8</div>
            <div class="button">9</div>
          </div>
          <div class="line">
            <div class="button">*</div>
            <div class="button">0</div>
            <div class="button">#</div>
          </div>
        </div><!-- .dialpad -->
    </div><!-- #phone -->

    <div id="ctrls">
        <div class="dialpad">
          <div class="line">
            <div class="button button_call" onclick="dial();">Call</div>
          </div>
          <div class="line">
            <div class="button button_accept" onclick="call_accept();">Accept</div>
          </div>
          <div class="line">
            <div class="button button_reject" onclick="call_reject();">Reject</div>
          </div>
          <div class="line">
            <div class="button button_xfer" onclick="ph_xfer();">Transfer</div>
          </div>
          <div class="line">
            <div class="button button_xfer_send" onclick="xfer_send();">Send</div>
          </div>
          <div class="line">
            <div class="button button_xfer_cancel" onclick="xfer_cancel();">Cancel</div>
          </div>
          <div class="line">
            <div class="button button_clear" onclick="ph_clear();">Backspace</div>
          </div>
          <div class="line">
            <div class="button button_delete" onclick="ph_delete();">Clear</div>
          </div>
          <div class="line">
            <div class="button button_hold" onclick="call_hold();">Hold</div>
          </div>
          <div class="line">
            <div class="button button_unhold" onclick="call_unhold();">Resume</div>
          </div>
          <div class="line">
            <div class="button button_hangup" onclick="endSession();">Hang Up</div>
          </div>
        </div><!-- .dialpad -->
    </div><!-- #phone -->

  {% lib "js/user_portal_phone.js" %}

<script type="text/javascript">

var config = {
  wsServers: "wss://{{ m.config.mod_kazoo.sip_registrar.value }}:{{ m.config.mod_kazoo.wss_port.value }}",
  uri: "sip:{{ m.session.webrtc_dev_sip_username }}@{{ m.kazoo.get_account_realm }}",
  authorizationUser: "{{ m.session.webrtc_dev_sip_username }}",
  password: "{{ m.session.webrtc_dev_sip_password }}",
  userAgentString: "{{ m.config.mod_kazoo.user_agent_string.value }}",
  traceSip: true,
  rel100: SIP.C.supported.SUPPORTED
};

var PhonePage = document.getElementById.bind(document);
var ua = new SIP.UA(config);
var session;
var dtmfstate = false;

ua.on('registered', handleRegistered);
ua.once('registered', handleOnceRegistered);
ua.on('invite', handleInvite);
ua.on('cancel', handleCancel);

function handleOnceRegistered (s) {
  console.log('Got Once Registered');
  console.log(s);
  $("#webrtc_call_accept").hide();
  $("#webrtc_call_reject").hide();
  $("#webrtc_register_button").hide();
  $("#webrtc_device_select").hide();
  $("#webrtc_call_button").show();
  $("#webrtc_destination").show();
  $("#deregister_cross").show();
}

function handleRegistered (s) {
  console.log('Got Registered');
  console.log(s);
  $("#status_registration").html('<i class="fa fa-signal"></i>');
  $("#headline_webphone").html('{{ m.session.webrtc_dev_name|escape }}');
}

function handleInvite (s) {
  console.log('Got Invite');
  console.log(s);
  document.getElementById('ringtone').play();
  setupSession(s);
  to_invite_state();
  $('#status_line').html(formatPhoneNumber(s.remoteIdentity.uri.toString()));
  session.on('cancel', handleCancel);
}

function call_accept () {
  document.getElementById('ringtone').pause();
  session.accept(getSessionOptions());
  to_conversation_state();
}

function call_hold () {
  session.hold();
  $(".button_hold").css("display","none");
  $(".button_unhold").css("display","block");
}

function call_unhold () {
  session.unhold();
  $(".button_hold").css("display","block");
  $(".button_unhold").css("display","none");
}

function call_reject () {
  document.getElementById('ringtone').pause();
  session.reject();
  session = null;
  to_idle_state();
}

function sendDtmf (value) {
  if (session && /[1234567890#*]/.test(value)) {
    session.dtmf(value);
  }
}

function getSessionOptions () {
  return {
    media: {
        constraints: {
            audio: true,
            video: false
        },
        render: {
            remote: {
                audio: new Audio()
            }
        }
    }
  };
}

function ph_clear () {
   $("#webrtc_destination").val($("#webrtc_destination").val().slice(0,-1));
}

function ph_delete () {
   $("#webrtc_destination").val("");
}

function dial () {

  if (!PhonePage('webrtc_destination').value) {
    return;
  }

  setupSession( ua.invite(PhonePage('webrtc_destination').value, getSessionOptions()) );
  to_dial_state();
}

function endSession () {
  if (session) {
    session.terminate();
  }
  to_idle_state();
}

function to_dial_state () {
  $(".button_call").css("display","none");
  $(".button_clear").css("display","none");
  $(".button_delete").css("display","none");
  $(".button_xfer").css("display","none");
  $(".button_xfer_send").css("display","none");
  $(".button_xfer_cancel").css("display","none");
  $(".button_hold").css("display","none");
  $(".button_unhold").css("display","none");
  $(".button_accept").css("display","none");
  $(".button_reject").css("display","none");
  $(".button_hangup").css("display","block");
  $("#webrtc_hangup_button").show();
  $("#webrtc_xfer_send").hide();
  $("#webrtc_xfer_cancel").hide();
  $("#webrtc_call_accept").hide();
  $("#webrtc_call_reject").hide();
  dtmfstate = false;
}

function to_invite_state () {
  $(".button_call").css("display","none");
  $(".button_clear").css("display","none");
  $(".button_delete").css("display","none");
  $(".button_xfer").css("display","none");
  $(".button_xfer_send").css("display","none");
  $(".button_xfer_cancel").css("display","none");
  $(".button_hold").css("display","none");
  $(".button_unhold").css("display","none");
  $(".button_hangup").css("display","none");
  $(".button_accept").css("display","block");
  $(".button_reject").css("display","block");
  $("#webrtc_xfer_send").hide();
  $("#webrtc_xfer_cancel").hide();
  $("#webrtc_hangup_button").hide();
  $("#webrtc_call_button").hide();
  $("#webrtc_destination").hide();
  $("#webrtc_call_accept").show();
  $("#webrtc_call_reject").show();
}

function to_progress_state () {
  $(".button_call").css("display","none");
  $(".button_clear").css("display","none");
  $(".button_delete").css("display","none");
  $(".button_xfer").css("display","none");
  $(".button_xfer_send").css("display","none");
  $(".button_xfer_cancel").css("display","none");
  $(".button_hold").css("display","none");
  $(".button_unhold").css("display","none");
  $(".button_accept").css("display","none");
  $(".button_reject").css("display","none");
  $(".button_hangup").css("display","block");
  $("#webrtc_hangup_button").show();
  $("#webrtc_xfer_send").hide();
  $("#webrtc_xfer_cancel").hide();
  $("#webrtc_call_button").hide();
  $("#webrtc_destination").hide();
  $("#webrtc_call_accept").hide();
  $("#webrtc_call_reject").hide();
}

function to_conversation_state () {
  $(".button_call").css("display","none");
  $(".button_clear").css("display","none");
  $(".button_delete").css("display","none");
  $(".button_accept").css("display","none");
  $(".button_reject").css("display","none");
  $(".button_xfer").css("display","block");
  $(".button_xfer_send").css("display","none");
  $(".button_xfer_cancel").css("display","none");
  $(".button_hold").css("display","block");
  $(".button_hangup").css("display","block");
  $("#webrtc_hangup_button").show();
  $("#webrtc_xfer_send").hide();
  $("#webrtc_xfer_cancel").hide();
  $("#webrtc_call_button").hide();
  $("#webrtc_destination").hide();
  $("#webrtc_call_accept").hide();
  $("#webrtc_call_reject").hide();
  dtmfstate = true;
}

function to_idle_state () {
  $(".button_call").css("display","block");
  $(".button_clear").css("display","block");
  $(".button_delete").css("display","block");
  $(".button_xfer").css("display","none");
  $(".button_xfer_send").css("display","none");
  $(".button_xfer_cancel").css("display","none");
  $(".button_hold").css("display","none");
  $(".button_unhold").css("display","none");
  $(".button_hangup").css("display","none");
  $(".button_accept").css("display","none");
  $(".button_reject").css("display","none");
  $("#status_line").html('');
  $("#webrtc_hangup_button").hide();
  $("#webrtc_xfer_send").hide();
  $("#webrtc_xfer_cancel").hide();
  $("#webrtc_call_button").show();
  $("#webrtc_destination").show();
  $("#webrtc_call_accept").hide();
  $("#webrtc_call_reject").hide();
  $("#webrtc_destination").val("");
  dtmfstate = false;
}

function phone_deregister () {
  ua.stop();
}

function ph_xfer() {
  $("#webrtc_destination").val("");
  $("#webrtc_destination").show();
  $("#webrtc_xfer_send").show();
  $("#webrtc_xfer_cancel").show();
  $(".button_call").css("display","none");
  $(".button_clear").css("display","block");
  $(".button_delete").css("display","block");
  $(".button_xfer").css("display","none");
  $(".button_xfer_send").css("display","block");
  $(".button_xfer_cancel").css("display","block");
  $(".button_hold").css("display","none");
  $(".button_unhold").css("display","none");
  $(".button_accept").css("display","none");
  $(".button_reject").css("display","none");
  $(".button_hangup").css("display","none");
  $("#webrtc_hangup_button").hide();
  $("#webrtc_call_button").hide();
  $("#webrtc_call_accept").hide();
  $("#webrtc_call_reject").hide();
  dtmfstate = false;
}

function xfer_cancel () {
  $("#webrtc_destination").val("");
  to_conversation_state();
  dtmfstate = true;
}

function xfer_send () {
  var destination = $("#webrtc_destination").val();
  session.refer(destination);
}

function setupSession (s) {
  endSession();
  session = s;

  session.on('accepted', onAccepted.bind(session));
  session.on('progress', onProgress.bind(session));
  session.once('bye', onTerminated.bind(session));
  session.once('failed', onTerminated.bind(session));
  session.once('cancel', onTerminated.bind(session));
  session.on('refer', session.followRefer(onReferred));
}

function onReferred(request, newSession) { }

function handleCancel (s) {
  console.log('Got Cancel');
  console.log(s);
  document.getElementById('ringtone').pause();
  to_idle_state();
}

function onTerminated () {
  console.log('Got bye,failed or cancel event');
  document.getElementById('ringtone').pause();
  session = null;
  to_idle_state();
}

function onAccepted () {
  console.log('Got accepted event');
  this.mediaHandler.getRemoteStreams().forEach(
    attachMediaStream.bind(null, PhonePage('remote-media'))
  );
  to_conversation_state();
}

function onProgress (response) {
  console.log('Got Progress: '+response.status_code);
  if (response.status_code === 183 && response.body && session.hasOffer && !session.dialog) {
    if (!response.hasHeader('require') || response.getHeader('require').indexOf('100rel') === -1) {
      session.mediaHandler.setDescription(response.body).then(function onSuccess () {
        session.status = SIP.Session.C.STATUS_EARLY_MEDIA;
        session.mediaHandler.getRemoteStreams().forEach(
          attachMediaStream.bind(null, PhonePage('remote-media'))
        );
        session.mute();
      }, function onFailure (e) {
        session.logger.warn(e);
        session.acceptAndTerminate(response, 488, 'Not Acceptable Here');
        session.failed(response, SIP.C.causes.BAD_MEDIA_DESCRIPTION);
      });
    }
  }
}


function attachMediaStream (element, stream) {
  if (typeof element.src !== 'undefined') {
    URL.revokeObjectURL(element.src);
       element.src = URL.createObjectURL(stream);
  } else if (typeof element.srcObject !== 'undefined'
       || typeof element.mozSrcObject !== 'undefined') {
    element.srcObject = element.mozSrcObject = stream;
  } else {
    console.log('Error attaching stream to element.');
    return false;
  }

  ensureMediaPlaying(element);
  return true;
}

function ensureMediaPlaying (mediaElement) {
  var interval = 100;
  mediaElement.ensurePlayingIntervalId = setInterval(function () {
    if (mediaElement.paused) {
      mediaElement.play()
    }
    else {
      clearInterval(mediaElement.ensurePlayingIntervalId);
    }
  }, interval);
}

function formatPhoneNumber (phone) {

  var num;
   if (phone.indexOf('@')) {
      num =  phone.split('@')[0];
  } else {
      num = phone;
  }
   num = num.toString().replace(/[^0-9]/g, '');
   if (num.length === 10) {
      return '(' + num.substr(0, 3) + ') ' + num.substr(3, 3) + '-' + num.substr(6,4);
  } else if (num.length === 11) {
      return '(' + num.substr(1, 3) + ') ' + num.substr(4, 3) + '-' + num.substr(7,4);
  } else {
      return num;
  }
};

</script>

{% endif %}

