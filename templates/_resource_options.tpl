  <div class="pill-content">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="realm" name="realm" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter realm here _}" value="{{ resource["gateways"][1][1]["realm"] }}">
        </div>
        <div class="col-sm-3">
          <input id="format_from_uri" name="format_from_uri" type="text" class="form-control margin-bottom-xs" placeholder="{_ Pass realm _}" value="{{ resource["gateways"][1][1]["format_from_uri"] }}">
        </div>
        <div class="col-sm-3">
          <input id="progress_timeout" name="progress_timeout" type="text" class="form-control margin-bottom-xs" placeholder="{_ Progress timeout _}"
                                                                                                                 value="{{ resource["gateways"][1][1]["progress_timeout"] }}">
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
          <input id="prefix" name="prefix" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter prefix here _}" value="{{ resource["gateways"][1][1]["prefix"] }}">
        </div>
        <div class="col-sm-6">
          <input id="suffix" name="suffix" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter suffix here _}" value="{{ resource["gateways"][1][1]["suffix"] }}">
        </div>
      </div>
    </div>
  </div>
