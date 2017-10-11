{% wire id="form_add_sipphone"
        type="submit"
        postback="add_new_device"
        delegate="mod_kazoo"
%}
<form id="form_add_sipphone" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="devicenickname"
               name="name"
               placeholder="{_ Enter device nickname here _}">
      </div>
      <div class="col-sm-6">
        <select id="sipphone_owner_id"
                name="device_owner_id"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          {% for option in m.kazoo.kz_list_account_users_short %}
            <option value="{{ option[1] }}"
                    {% if not option[1] %}
                      selected
                    {% endif %}>
              {{ option[2] }}
            </option>
          {% endfor %}
        </select>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="sipusername"
               name="sipusername"
               value="user_{{ m.kazoo[{rand_hex length=3}] }}"
               placeholder="{_ Enter username here _}">
      </div>
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="sippassword"
               name="sippassword"
               value="{{ m.kazoo[{rand_hex length=6}] }}"
               placeholder="{_ Enter password here _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6" >
        <select id="callerid_external_number"
                name="callerid_external_number"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          {% for option in [""]++m.kazoo.get_acc_numbers %}
            <option value="{{ option }}">
              {% if option == "" %}
               {_ - No  external CID - _}
              {% else %}
                {{ option }}
              {% endif %}
            </option>
          {% endfor %}
        </select>
      </div>
      <div class="col-sm-3">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="callerid_internal_number"
               name="callerid_internal_number"
               value=""
               placeholder="{_ Internal CID number _}">
      </div>
      <div class="col-sm-3">
        <label for="add_callflow"
               class="checkbox-inline"
               style="width: 100%">
          <input type="checkbox"
                 id="add_callflow"
                 name="add_callflow"
                 value="add_callflow">
          {_ Add callflow _}
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Create SIP Phone _}
        </button>
      </div>
    </div>
  </div>
  <input type="hidden" name="device_type" value="softphone">
</form>
<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>

