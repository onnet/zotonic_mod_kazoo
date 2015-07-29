{% wire id="form_cf_add_number" type="submit" postback="cf_add_number" delegate="inno" %}
<form id="form_cf_add_number" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
            {% wire id="number_type" type="change" action={ update target="number_input_div" template="_cf_add_number_type.tpl" }%}
            <select id="number_type" name="number_type" class="form-control margin-bottom-xs" style="text-align:center;">
                    <option value="number_type_1" selected>Spare Numbers</option>
                    <option value="number_type_2">Extension</option>
                    <option value="number_type_3">Pattern</option>
            </select>
        </div>
        <div id="number_input_div"class="col-sm-6">
          {% include "_cf_add_number_type.tpl" %}
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Add Number</button>
        </div>
      </div>
    </div>
</form>
