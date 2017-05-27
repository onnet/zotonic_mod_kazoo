{% with m.kazoo[{kz_get_account_menu menu_id=menu_id}] as menu %}
{% wire id="form_kz_menu" type="submit" postback="kz_menu" delegate="mod_kazoo" %}
<form id="form_kz_menu" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="name"
               name="name"
               placeholder="{_ Enter menu name here _}"
               value="{{ menu[1]["name"] }}">
      </div>
      <div class="col-sm-6">
          <select id="greeting"
                  name="greeting"
                  class="form-control margin-bottom-xs"
                  style="text-align:center;">
              <option value=" ">-- {_ Select voice prompt _} --</option>
            {% for option in m.kazoo.kz_list_account_media %}
              <option value="{{ option[1]["id"] }}"
                      {% if option[1]["id"] == menu[1]["media"][1]["greeting"] %}
                        selected
                      {% endif %}>
                {{ option[1]["name"] }}
              </option>
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
            {% for retries in 1|range:5 %}
              <option value="{{ retries }}"
                      {% if menu[1]["retries"] == retries %}
                        selected
                      {% endif %}>
                {{ retries }}
              </option>
            {% endfor %}
          </select>
        </label>
      </div>
      <div class="col-sm-3">
        <label class="form-control-onnet margin-bottom-xs">{_ Timeout _}
          <select id="timeout" name="timeout" class="form-control-onnet">
            {% for timeout in 1|range:13 %}
              <option value="{{ timeout * 1000 }}"
                      {% if menu[1]["timeout"] == (timeout * 1000)
                          or
                           ((timeout == 3) and (not menu[1]["timeout"]))
                      %}
                        selected
                      {% endif %}>
                {{ timeout }}
              </option>
            {% endfor %}
          </select>
        </label>
      </div>
      <div class="col-sm-3">
        <label class="form-control-onnet margin-bottom-xs">
          {_ Ext. length _}
          <select id="max_extension_length"
                  name="max_extension_length"
                  class="form-control-onnet">
            {% for ext_length in 3|range:5 %}
              <option value="{{ ext_length }}"
                      {% if menu[1]["max_extension_length"] == ext_length %}
                        selected
                      {% endif %}>
                {{ ext_length }}
              </option>
            {% endfor %}
          </select>
        </label>
      </div>
      <div class="col-sm-3">
        <label class="form-control-onnet margin-bottom-xs">
          {_ Record PIN _}
          <input id="record_pin"
                 name="record_pin"
                 type="text"
                 class="form-control margin-bottom-xs"
                 placeholder="Pin"
                 value="{{ menu[1]["record_pin"] }}">
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="hunt_allow"
               name="hunt_allow"
               placeholder="Whitelist regex: ^[0-9]{0,11}$"
               value="{{ menu[1]["hunt_allow"] }}">
      </div>
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="hunt_deny"
               name="hunt_deny"
               placeholder="Blacklist regex: ^[0-9]{0,11}$"
               value="{{ menu[1]["hunt_deny"] }}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4">
        <label for="hunt"
               class="checkbox-inline {% if menu[1]["hunt"] %}checked{% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="hunt"
                 name="hunt"
                 {% if menu[1]["hunt"] %}checked{% endif %}>
          {_ Dial extensions _}
        </label>
      </div>
      <div class="col-sm-4">
        <label for="allow_record_from_offnet"
               class="checkbox-inline
                      {% if menu[1]["allow_record_from_offnet"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="allow_record_from_offnet"
                 name="allow_record_from_offnet"
                 {% if menu[1]["allow_record_from_offnet"] %}
                   checked
                 {% endif %}>
          {_ Outside recording _}
        </label>
      </div>
      <div class="col-sm-4">
        <label for="suppress_media"
               class="checkbox-inline
                      {% if menu[1]["suppress_media"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="suppress_media"
                 name="suppress_media"
                 {% if menu[1]["suppress_media"] %}
                   checked
                 {% endif %}>
          {_ Suppress invalid _}
        </label>
      </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Save Menu _}
        </button>
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
