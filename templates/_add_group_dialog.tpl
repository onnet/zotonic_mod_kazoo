{% wire id="form_add_group" type="submit" postback="add_new_group" delegate="inno" %}
<form id="form_add_group" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="groupname" name="name" placeholder="Enter group name here" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter group name here." data-original-title="GroupName">
        </div>
      </div>
    </div>
    <div class="form-group" id="grp_users_list">
      <h4>Users:</h4>
      <div class="col-sm-12 columns"> 
        {% for option in m.inno.kz_list_account_users_short %}
        {% if option[1] %}
        <label for="{{ option[1]|truncate:8:"" }}" class="checkbox-inline">
          <input type="checkbox" value="{{ option[1] }}" id="{{ option[1]|truncate:8:"" }}" name="user">
          {{ option[2] }}
        </label>
        {% endif %}
        {% endfor %}
      </div>
    </div>
    <div class="form-group" id="grp_users_list">
      <h4>Devices:</h4>
      <div class="col-sm-12 columns"> 
        {% for option in m.inno.kz_list_account_devices_short %}
        {% if option[1] %}
        <label for="{{ option[1]|truncate:8:"" }}" class="checkbox-inline">
          <input type="checkbox" value="{{ option[1] }}" id="{{ option[1]|truncate:8:"" }}" name="device">
          {{ option[2] }}
        </label>
        {% endif %}
        {% endfor %}
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Create Group</button>
        </div>
      </div>
    </div>
</form>

<script type="text/javascript">
$(document).ready(function() {
	$('.form-group').on('click','input[type=checkbox]',function() {
		$(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
	});
});
</script>
