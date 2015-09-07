{% with m.kazoo[{kz_list_user_vmbox_details vmbox_id=vmbox_id}] as vmbox %}
{% wire id="form_kz_vmbox" type="submit" postback="kz_vmbox" delegate="mod_kazoo" %}
<form id="form_kz_vmbox" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Voicemail name _}
            <input type="text" class="form-control margin-bottom-xs" id="name" name="name" placeholder="{_ Enter vmbox name here _}" value="{{ vmbox[1]["name"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Voicemail owner _}
          <select id="owner_id" name="owner_id" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
            {% for option in m.kazoo.kz_list_account_users_short %}
                  <option value="{{ option[1] }}" {% if vmbox[1]["owner_id"] == option[1] or (not option[1] and not vmbox[1]["owner_id"]) %}selected{% endif %}>{{ option[2] }}</option>
            {% endfor %}
          </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Voicemail number _}
            <input type="text" class="form-control margin-bottom-xs" id="mailbox" name="mailbox" placeholder="{_ Number _}" 
                   value="{{ vmbox[1]["mailbox"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ PIN number _}
            <input type="text" class="form-control margin-bottom-xs" id="pin" name="pin" placeholder="{_ PIN _}"
                   value="{{ vmbox[1]["pin"] }}">
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Unavailable message _}
            <select id="unavailable_message_id" name="unavailable_message_id" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
                <option value="">-- {_ No custom prompt _} --</option>
              {% for option in m.kazoo.kz_list_account_media %}
                <option value="{{ option["id"] }}" {% if option["id"] == vmbox[1]["media"][1]["unavailable"] %}selected{% endif %}>{{ option["name"] }}</option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Timezone _}
          <select id="vmbox_timezone" name="vmbox_timezone" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
            {% for zone in m.kazoo.tz_list %}
              <option value="{{ zone }}" {% if zone == vmbox[1]["timezone"] %}selected{% endif %}>{{ zone }}</option>
            {% endfor %}
          </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label for="is_setup" class="checkbox-inline {% if vmbox[1]["is_setup"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="is_setup" name="is_setup" {% if vmbox[1]["is_setup"] %}checked{% endif %}>
            {_ Already Setup _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="require_pin" class="checkbox-inline {% if vmbox[1]["require_pin"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="require_pin" name="require_pin" {% if vmbox[1]["require_pin"] %}checked{% endif %}>
            {_ Require PIN _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="check_if_owner" class="checkbox-inline {% if vmbox[1]["check_if_owner"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="check_if_owner" name="check_if_owner" {% if vmbox[1]["check_if_owner"] %}checked{% endif %}>
            {_ Auto-login enabled _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="skip_greeting" class="checkbox-inline {% if vmbox[1]["skip_greeting"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="skip_greeting" name="skip_greeting" {% if vmbox[1]["skip_greeting"] %}checked{% endif %}>
            {_ Skip Greeting _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="skip_instructions" class="checkbox-inline {% if vmbox[1]["skip_instructions"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="skip_instructions" name="skip_instructions" {% if vmbox[1]["skip_instructions"] %}checked{% endif %}>
            {_ Skip Instructions _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="delete_after_notify" class="checkbox-inline {% if vmbox[1]["delete_after_notify"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="delete_after_notify" name="delete_after_notify" {% if vmbox[1]["delete_after_notify"] %}checked{% endif %}>
            {_ Delete After Notification _}
          </label>
        </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save voicemail box _}</button>
        </div>
      </div>
    </div>
    {% if vmbox[1]["id"] %}
      <input type="hidden" name="vmbox_id" value="{{ vmbox[1]["id"] }}">
    {% endif %}
</form>
{% print vmbox %}
{% endwith %}

<script type="text/javascript">
$(document).ready(function() {
	$('.form-group').on('click','input[type=checkbox]',function() {
		$(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
	});
});
</script>
{% javascript %}
    $('#vmbox_timezone').selectpicker({size: 5});
    $('#unavailable_message_id').selectpicker({size: 5});
    $('#owner_id').selectpicker({size: 5});
{% endjavascript %}

