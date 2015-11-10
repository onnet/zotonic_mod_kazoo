  <div class="pill-content">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="name" name="name" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter resource name here _}" value="{{ resource["name"] }}">
        </div>
        <div class="col-sm-4">
          <input id="server" name="server" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter server address here _}" value="{{ resource["gateways"][1][1]["server"] }}">
        </div>
        <div class="col-sm-2">
          <input id="port" name="port" type="text" class="form-control margin-bottom-xs" placeholder="{_ Port _}" value="{{ resource["gateways"][1][1]["port"] }}">
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
          <input id="flags" name="flags" type="text" class="form-control margin-bottom-xs" placeholder="{_ Flags (comma separated)_}"
                            value="{% for flag in resource["flags"] %}{{ flag }}{% if not forloop.last %}, {% endif %}{% endfor %}">
        </div>
        <div class="col-sm-2">
          <label for="PCMA" class="checkbox-inline {% if "PCMA"|member:resource["gateways"][1][1]["codecs"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="PCMA" name="codecs" value="PCMA" {% if "PCMA"|member:resource["gateways"][1][1]["codecs"] %}checked{% endif %}>
            {_ PCMA _}
          </label>
        </div>
        <div class="col-sm-2">
          <label for="PCMU" class="checkbox-inline {% if "PCMU"|member:resource["gateways"][1][1]["codecs"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="PCMU" name="codecs" value="PCMU" {% if "PCMU"|member:resource["gateways"][1][1]["codecs"] %}checked{% endif %}>
            {_ PCMU _}
          </label>
        </div>
        <div class="col-sm-2">
          <label for="OPUS" class="checkbox-inline {% if "OPUS"|member:resource["gateways"][1][1]["codecs"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="OPUS" name="codecs" value="OPUS" {% if "OPUS"|member:resource["gateways"][1][1]["codecs"] %}checked{% endif %}>
            {_ OPUS _}
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
