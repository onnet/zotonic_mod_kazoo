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
          <input id="username" name="username" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter username here _}" value="{{ resource["gateways"][1][1]["username"] }}">
        </div>
        <div class="col-sm-6">
          <input id="password" name="password" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter password here _}" value="{{ resource["gateways"][1][1]["password"] }}">
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
