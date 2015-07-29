{% wire id="form_cf_select_device" type="submit" postback="cf_select_device" delegate="inno" %}
<form id="form_cf_select_device" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
            <select id="device_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for option in m.inno.kz_list_account_devices_short %}
                {% if option[1] %}
                  <option value="{{ option[1] }}" {% if option[1] == kz_element_id %}selected{% endif %}>{{ option[2] }}</option>
                {% endif %}
              {% endfor %}
            </select>
        </div>
        <div id="number_input_div"class="col-sm-6">
          Ring this device for
          <input type="text" name="timeout" id="parameter_input" maxlength="3" size="3" style="height: 34px; text-align: center;" value="20">
          seconds.
        </div>
      </div>
    </div>
    <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_device" class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_device" action={script script="$('#"++element_id++"_details').text(($('#device_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_device"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
