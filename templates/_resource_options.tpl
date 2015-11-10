  <div class="pill-content">
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
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <input id="realm" name="realm" type="text" class="form-control margin-bottom-xs" placeholder="{_ Enter realm here _}" value="{{ resource["gateways"][1][1]["realm"] }}">
        </div>
        <div class="col-sm-3">
          <label for="hunt" class="checkbox-inline {% if resource["gateways"][1][1]["format_from_uri"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="format_from_uri" name="format_from_uri" {% if resource["gateways"][1][1]["format_from_uri"] %}checked{% endif %}>
            {_ Pass realm _}
          </label>
        </div>
        <div class="col-sm-3">
          <input id="progress_timeout" name="progress_timeout" type="text" class="form-control margin-bottom-xs" placeholder="{_ Progress timeout _}"
                                                                                                                 value="{{ resource["gateways"][1][1]["progress_timeout"] }}">
        </div>
        <div class="col-sm-3">
          <select name="caller_id_options_type" id="caller_id_options_type" class="col-xs-12 form-control margin-bottom-xs">   
            <option value="external">external</option>
            <option value="internal">internal</option>
            <option value="emergency">emergency</option>
          </select>
        </div>
      </div>
    </div>
  </div>

<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>

