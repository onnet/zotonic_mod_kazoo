{% with m.inno[{kz_get_account_menu menu_id=menu_id}] as menu %}
{% wire id="form_kz_menu" type="submit" postback="kz_menu" delegate="inno" %}
<form id="form_kz_menu" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="name" name="name" placeholder="Enter menu name here" value="{{ menu[1]["name"] }}">
        </div>
        <div class="col-sm-6">
            <select id="greeting" name="greeting" class="form-control margin-bottom-xs" style="text-align:center;">
                <option value=" ">-- Select voice prompt --</option>
              {% for option in m.inno.kz_list_account_media %}
                <option value="{{ option["id"] }}" {% if option["id"] == menu[1]["media"][1]["greeting"] %}selected{% endif %}>{{ option["name"] }}</option>
              {% endfor %}
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ # of retries _}
            <select id="retries" name="retries" class="form-control-onnet">
              <option value="1" {% if menu[1]["retries"] == "1" %}selected{% endif %}>1</option>
              <option value="2" {% if menu[1]["retries"] == "2" %}selected{% endif %}>2</option>
              <option value="3" {% if menu[1]["retries"] == "3" %}selected{% endif %}>3</option>
              <option value="4" {% if menu[1]["retries"] == "4" %}selected{% endif %}>4</option>
              <option value="5" {% if menu[1]["retries"] == "5" %}selected{% endif %}>5</option>
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Timeout _}
            <select id="timeout" name="timeout" class="form-control-onnet">
              <option value="1000" {% if menu[1]["timeout"] == "1000" %}selected{% endif %}>1</option>
              <option value="2000" {% if menu[1]["timeout"] == "2000" %}selected{% endif %}>2</option>
              <option value="3000" {% if menu[1]["timeout"] == "3000" %}selected{% endif %}>3</option>
              <option value="4000" {% if menu[1]["timeout"] == "4000" %}selected{% endif %}>4</option>
              <option value="5000" {% if menu[1]["timeout"] == "5000" %}selected{% endif %}>5</option>
              <option value="6000" {% if menu[1]["timeout"] == "6000" %}selected{% endif %}>6</option>
              <option value="7000" {% if menu[1]["timeout"] == "7000" %}selected{% endif %}>7</option>
              <option value="8000" {% if menu[1]["timeout"] == "8000" %}selected{% endif %}>8</option>
              <option value="9000" {% if menu[1]["timeout"] == "9000" %}selected{% endif %}>9</option>
              <option value="10000" {% if menu[1]["timeout"] == "10000" %}selected{% endif %}>10</option>
              <option value="15000" {% if menu[1]["timeout"] == "15000" %}selected{% endif %}>15</option>
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Ext. length _}
            <select id="max_extension_length" name="max_extension_length" class="form-control-onnet">
              <option value="3" {% if menu[1]["max_extension_length"] == "3" %}selected{% endif %}>3</option>
              <option value="4" {% if menu[1]["max_extension_length"] == "4" %}selected{% endif %}>4</option>
              <option value="5" {% if menu[1]["max_extension_length"] == "5" %}selected{% endif %}>5</option>
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Record PIN _}
            <input id="record_pin" name="record_pin" type="text" class="form-control margin-bottom-xs" placeholder="Pin" value="{{ menu[1]["record_pin"] }}">
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="hunt_allow" name="hunt_allow" placeholder="Whitelist regex: ^[0-9]{0,11}$" value="{{ menu[1]["hunt_allow"] }}">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="hunt_deny" name="hunt_deny" placeholder="Blacklist regex: ^[0-9]{0,11}$" value="{{ menu[1]["hunt_deny"] }}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label for="hunt" class="checkbox-inline {% if menu[1]["hunt"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="hunt" name="hunt" {% if menu[1]["hunt"] %}checked{% endif %}>
            {_ Dial extensions _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="allow_record_from_offnet" class="checkbox-inline {% if menu[1]["allow_record_from_offnet"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="allow_record_from_offnet" name="allow_record_from_offnet" {% if menu[1]["allow_record_from_offnet"] %}checked{% endif %}>
            {_ Outside recording _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="suppress_media" class="checkbox-inline {% if menu[1]["suppress_media"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="suppress_media" name="suppress_media" {% if menu[1]["suppress_media"] %}checked{% endif %}>
            {_ Suppress invalid _}
          </label>
        </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save Menu</button>
        </div>
      </div>
    </div>
    {% if menu[1]["id"] %}
      <input type="hidden" name="menu_id" value="{{ menu[1]["id"] }}">
    {% endif %}
</form>
{% endwith %}

<script type="text/javascript">
$(document).ready(function() {
	$('.form-group').on('click','input[type=checkbox]',function() {
		$(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
	});
});
</script>
