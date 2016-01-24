{% with m.kazoo[{kz_notification_info notification_id=notification_id}] as notification %}
{% wire id="form_kz_notifications" type="submit" postback="kz_notifications" delegate="mod_kazoo" %}
<form id="form_kz_notifications" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ From (email address): _}
            <input type="text" class="form-control margin-bottom-xs" id="from" name="from" placeholder="{_ Enter sender's email adress here _}" value="{{ notification[1]["from"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Subject: _}
            <input type="text" class="form-control margin-bottom-xs" id="subject" name="subject" placeholder="{_ Enter message subject here _}" value="{{ notification[1]["subject"] }}">
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ To _}:
            {% wire id="to" type="change" action={ update target="maybe_to_input" template="_notice_field_choice.tpl" field_type="to" } %}
            <select name="to" id="to" class="form-control margin-bottom-xs">
              <option id="original" value="original" {% if notification[1]["to"][1]["type"] == "original" %}selected{% endif %}>{_ Original user _}</option>
              <option id="admins" value="admins" {% if notification[1]["to"][1]["type"] == "admins" %}selected{% endif %}>{_ All account administrators _}</option>
              <option id="specified" value="specified" {% if notification[1]["to"][1]["type"] == "specified" %}selected{% endif %}>{_ Specified email address _}</option>
            </select>
          </label>
        </div>
        <span id="maybe_to_input">
            {% include "_notice_field_choice.tpl" field_type="to" recipient_type=notification[1]["to"][1]["type"] input_value=notification[1]["to"][1]["email_addresses"] %}
        </span>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ CC _}:
            {% wire id="cc" type="change" action={ update target="maybe_cc_input" template="_notice_field_choice.tpl" field_type="cc" } %}
            <select name="cc" id="cc" class="form-control margin-bottom-xs">
              <option id="original" value="original" {% if notification[1]["cc"][1]["type"] == "original" %}selected{% endif %}>{_ Original user _}</option>
              <option id="admins" value="admins" {% if notification[1]["cc"][1]["type"] == "admins" %}selected{% endif %}>{_ All account administrators _}</option>
              <option id="specified" value="specified" {% if notification[1]["cc"][1]["type"] == "specified" %}selected{% endif %}>{_ Specified email address _}</option>
            </select>
          </label>
        </div>
        <span id="maybe_cc_input">
            {% include "_notice_field_choice.tpl" field_type="cc" recipient_type=notification[1]["cc"][1]["type"] input_value=notification[1]["cc"][1]["email_addresses"] %}
        </span>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ BCC _}:
            {% wire id="bcc" type="change" action={ update target="maybe_bcc_input" template="_notice_field_choice.tpl" field_type="bcc" } %}
            <select name="bcc" id="bcc" class="form-control margin-bottom-xs">
              <option id="original" value="original" {% if notification[1]["bcc"][1]["type"] == "original" %}selected{% endif %}>{_ Original user _}</option>
              <option id="admins" value="admins" {% if notification[1]["bcc"][1]["type"] == "admins" %}selected{% endif %}>{_ All account administrators _}</option>
              <option id="specified" value="specified" {% if notification[1]["bcc"][1]["type"] == "specified" %}selected{% endif %}>{_ Specified email address _}</option>
            </select>
          </label>
        </div>
        <span id="maybe_bcc_input">
            {% include "_notice_field_choice.tpl" field_type="bcc" recipient_type=notification[1]["bcc"][1]["type"] input_value=notification[1]["bcc"][1]["email_addresses"] %}
        </span>
      </div>
    </div>
    <input type="hidden" name="notification_id" value="{{ notification_id }}">
</form>
{% wire id="button_add_notification_save" action={submit target="form_kz_notifications"} %}
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_add_notification_save" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save settings _}</button>
    </div>
  </div>
</div>
{% print notification_id %}
{% print notification[1]["to"][1]["type"] %}
{% print notification %}
{% endwith %}
