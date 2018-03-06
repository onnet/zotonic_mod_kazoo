{% wire id="form_add_sipuri_device"
        type="submit"
        postback="add_new_device"
        delegate="mod_kazoo"
%}
<form id="form_add_sipuri_device" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="devicename"
               name="name"
               placeholder="{_ Enter device name here _}">
      </div>
      <div class="col-sm-4">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="route"
               name="route"
               placeholder="sip:support@company.com">
      </div>
      <div class="col-sm-4">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="sip_ip_auth"
               name="sip_ip_auth"
               placeholder="{_ Outbound Auth IP address _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Create SIP URI _}
        </button>
      </div>
    </div>
  </div>
  <input type="hidden" name="device_type" value="sip_uri">
</form>
