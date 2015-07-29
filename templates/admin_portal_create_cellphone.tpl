{% wire id="form_add_cellphone" type="submit" postback="add_new_device" delegate="inno" %}
<form id="form_add_cellphone" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="devicename" name="name" placeholder="Enter device name here" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter device name here." data-original-title="DeviceName">
        </div>
        <div class="col-sm-6">
            <select id="cellphone_owner_id" name="device_owner_id" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for option in m.inno.kz_list_account_users_short %}
                    <option value="{{ option[1] }}" {% if not option[1] %}selected{% endif %}>{{ option[2] }}</option>
              {% endfor %}
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="cellphonenumber" name="cellphonenumber" placeholder="Enter phonenumber here" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter phonenumber email here." data-original-title="phonenumber">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Create Cell Phone</button>
        </div>
      </div>
    </div>
    <input type="hidden" name="device_type" value="cellphone">
</form>
