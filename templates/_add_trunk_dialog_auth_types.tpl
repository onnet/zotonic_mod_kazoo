{% if q.triggervalue=="IP" or rule[1]["cycle"] == "IP" %}
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ IP address _}
            <input type="text" class="form-control margin-bottom-xs" id="ipaddress" name="ipaddress" placeholder="{_ Enter your PBX IP address here _}" value="{{ trunk[1]["name"] }}">
          </label>
        </div>
{% else %}
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Username _}
            <input type="text" class="form-control margin-bottom-xs" id="username" name="username" placeholder="{_  _}" value="{{ trunk[1]["name"] }}">
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Password _}
            <input type="text" class="form-control margin-bottom-xs" id="password" name="password" placeholder="{_  _}" value="{{ trunk[1]["name"] }}">
          </label>
        </div>
{% endif %}
