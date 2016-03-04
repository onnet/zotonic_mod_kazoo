{% if q.triggervalue=="IP" or ( not q.triggervalue and server[1]["auth"][1]["auth_method"] == "IP" ) %}
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ IP address _}
            <input type="text" class="form-control margin-bottom-xs" id="ipaddress" name="ipaddress" placeholder="{_ Enter your PBX IP address here _}" value="{{ server[1]["auth"][1]["ip"] }}">
          </label>
        </div>
{% else %}
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Username _}
            <input type="text" class="form-control margin-bottom-xs" id="auth_trunk_user" name="auth_trunk_user" placeholder="{_  _}"
                                                                     value="{{ server[1]["auth"][1]["auth_user"] }}" autocomplete="off">
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Password _}
            <input type="text" class="form-control margin-bottom-xs" id="auth_password" name="auth_password" placeholder="{_  _}" value="{{ server[1]["auth"][1]["auth_password"] }}">
          </label>
        </div>
{% endif %}
