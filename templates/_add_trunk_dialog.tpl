{% with m.kazoo[{kz_get_account_trunk trunk_id=trunk_id}] as trunk %}
{% wire id="form_kz_trunk" type="submit" postback="kz_trunk_server" delegate="mod_kazoo" %}
<form id="form_kz_trunk" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Trunk name _}
            <input type="text" class="form-control margin-bottom-xs" id="server_name" name="server_name" placeholder="{_ Enter trunk name here _}" value="{{ trunk[1]["name"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Invite format _}
            <select id="invite_format" name="invite_format" class="form-control margin-bottom-xs" style="text-align:center;">
              <option value="e164" {% if trunk == option[1] or (not option[1] and  trunk[1]["owner_id"]) %}selected{% endif %}>E.164@Realm</option>
              <option value="username" {% if trunk == option[1] or (not option[1] and trunk[1]["owner_id"]) %}selected{% endif %}>SIP_Username@Realm</option>
            </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Auth method _}
            {% wire id="auth_method" type="change" action={ update target="auth_types" template="_add_trunk_dialog_auth_types.tpl" } %}
            <select name="auth_method" id="auth_method" class="form-control margin-bottom-xs">
              <option id="Password" value="Password" {% if rule[1]["cycle"] == "weekly" or rule[1]["cycle"] %}selected{% endif %}>{_ Password _}</option>
              <option id="IP" value="IP" {% if rule[1]["cycle"] == "monthly" %}selected{% endif %}>{_ IP _}</option>
            </select>
          </label>
        </div>
        <span id="auth_types">
            {% include "_add_trunk_dialog_auth_types.tpl" %}
        </span>
      </div>
    </div>
    {% if trunk_id %}
      <input type="hidden" name="trunk_id" value="{{ trunk_id }}">
    {% endif %}
    {% if server_index %}
      <input type="hidden" name="server_index" value="{{ server_index }}">
    {% endif %}
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_add_trunk_manage_numbers" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Manage trunk numbers _}</button>
    </div>
  </div>
</div>
{% wire id="button_add_trunk_save" action={submit target="form_kz_trunk"} %}
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_add_trunk_save" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save trunk _}</button>
    </div>
  </div>
</div>
{% endwith %}

<script type="text/javascript">
$(document).ready(function() {
	$('.form-group').on('click','input[type=checkbox]',function() {
		$(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
	});
});
</script>
