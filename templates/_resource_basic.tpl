  <div class="pill-content">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="name" name="name" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter resource name here _}" value="{{ resource["name"] }}">
        </div>
        <div class="col-sm-6">
          <input id="server" name="server" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter server address here _}" value="{{ resource["gateways"][1][1]["server"] }}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="rules" name="rules" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter rules here _}:  ^\+?(\d*)$" value="{{ resource["rules"] }}">
        </div>
        <div class="col-sm-6">
          <input id="cid_rules" name="cid_rules" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter cid_rules here _}:  ^(\+?7812\d{7})$" value="{{ resource["cid_rules"] }}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="realm" name="realm" type="text" class="form-control margin-bottom-xs" placeholder="{_ Flags (comma separated)_}" value="{{ resource["flags"] }}">
        </div>
        <div class="col-sm-2">
          <label for="hunt" class="checkbox-inline {% if menu[1]["hunt"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="hunt" name="hunt" {% if menu[1]["hunt"] %}checked{% endif %}>
            {_ G711a _}
          </label>
        </div>
        <div class="col-sm-2">
          <label for="allow_record_from_offnet" class="checkbox-inline {% if menu[1]["allow_record_from_offnet"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="allow_record_from_offnet" name="allow_record_from_offnet" {% if menu[1]["allow_record_from_offnet"] %}checked{% endif %}>
            {_ G711u _}
          </label>
        </div>
        <div class="col-sm-2">
          <label for="suppress_media" class="checkbox-inline {% if menu[1]["suppress_media"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="suppress_media" name="suppress_media" {% if menu[1]["suppress_media"] %}checked{% endif %}>
            {_ G722 _}
          </label>
        </div>
      </div>
    </div>
    <div class="form-group" style="padding: 1em 2em 3em 2em;">
      <div class="row">
        <div class="col-sm-12">
          <div class="input time_wrapper">
            <input id="weight_cost" name="weight_cost" type="slider" style="display: none;" value="{% if resource["weight_cost"] %}{{ resource["weight_cost"] }}{% else %}50{% endif %}">
          </div>
        </div>
      </div>
    </div>
  </div>

  {% javascript %}
    $("#weight_cost").slider({
                  from: 1,
                  to: 100,
                  step: 1,
                  dimension: "",
                  scale: ["{_ Highest _}","{_ High _}", "{_ Normal _}", "{_ Low _}", "{_ Lowest _}"],
                  limits: false
    });
  {% endjavascript %}
