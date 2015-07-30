{% wire id="form_add_sipphone" type="submit" postback="add_new_device" delegate="mod_kazoo" %}
<form id="form_add_sipphone" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="devicenickname" name="name" placeholder="Enter device nickname here" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter device nickname here." data-original-title="DeviceName">
        </div>
        <div class="col-sm-6">
            <select id="sipphone_owner_id" name="device_owner_id" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for option in m.kazoo.kz_list_account_users_short %}
                    <option value="{{ option[1] }}" {% if not option[1] %}selected{% endif %}>{{ option[2] }}</option>
              {% endfor %}
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="sipusername" name="sipusername" value="user_{{ m.kazoo[{rand_hex length=3}] }}" placeholder="Enter username here" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter username email here." data-original-title="Email">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="sippassword" name="sippassword" value="{{ m.kazoo[{rand_hex length=6}] }}" placeholder="Enter password here" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter password here." data-original-title="SipPhonePassword">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Create SIP Phone</button>
        </div>
      </div>
    </div>
    <input type="hidden" name="device_type" value="softphone">
</form>
