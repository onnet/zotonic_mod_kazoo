{% with m.kazoo[{cf_get_element_by_id element_id=element_id}] as element_data %}
{% wire id="form_cf_select_disa" type="submit" postback="cf_select_disa" delegate="mod_kazoo" %}
<form id="form_cf_select_disa" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4">
        <label class="form-control-onnet margin-bottom-xs">
          PIN
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="caller_id_name"
                 name="caller_id_name"
                 placeholder="1234"
                 value="{{ kz_element_name[1] }}">
        </label>
      </div>
      <div class="col-sm-4">
        <label class="form-control-onnet margin-bottom-xs">
          Retries
          <select id="selected_type_target" name="target_type" class="form-control margin-bottom-xs" style="text-align:center;">
            <option value="user" {% if user_id %}selected{% endif %}>User</option>
          <option value="device" {% if device_id %}selected{% endif %}>Device</option>
          </select>
        </label>
      </div>
      <div class="col-sm-4">
        <label class="form-control-onnet margin-bottom-xs">
          {_ Keep the original _}
        <label for="{{ option[1]|truncate:8:"" }}" class="checkbox-inline" style="width: 100%";>
          <input type="checkbox" value="{{ option[1] }}" id="original_caller_id" name="original_caller_id">
          {_ Caller-ID _}
        </label>
        </label>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4">
        <label class="form-control-onnet margin-bottom-xs">
          Max digits
          <select id="selected_type_target" name="target_type" class="form-control margin-bottom-xs" style="text-align:center;">
            <option value="user" {% if user_id %}selected{% endif %}>User</option>
          <option value="device" {% if device_id %}selected{% endif %}>Device</option>
          </select>
        </label>
      </div>
      <div class="col-sm-4">
        <label class="form-control-onnet margin-bottom-xs">
          Interdigit
          <select id="selected_type_target" name="target_type" class="form-control margin-bottom-xs" style="text-align:center;">
            <option value="user" {% if user_id %}selected{% endif %}>User</option>
          <option value="device" {% if device_id %}selected{% endif %}>Device</option>
          </select>
        </label>
      </div> 
      <div class="col-sm-4">
        <label class="form-control-onnet margin-bottom-xs">
          Media
          <select id="selected_type_target" name="target_type" class="form-control margin-bottom-xs" style="text-align:center;">
            <option value="user" {% if user_id %}selected{% endif %}>User</option>
          <option value="device" {% if device_id %}selected{% endif %}>Device</option>
          </select>
        </label>
      </div> 
    </div>
  </div>
  <div class="form-group">
      <label class="form-control-onnet margin-bottom-xs">Approved
      <div class="row">
        <div class="col-sm-6">
            {% wire id="selected_type_approved" type="change" action={ update target="choice_input_div_approved" template="_group_user_device_selector.tpl" selector_name="approved_selected"} %}
            <select id="selected_type_approved" name="approved_type" class="form-control margin-bottom-xs" style="text-align:center;">
                    <option value="group" {% if element_data[1]["data"][1]["approved_group_id"] %}selected{% endif %}>Group</option>
                    <option value="user" {% if element_data[1]["data"][1]["approved_user_id"] %}selected{% endif %}>User</option>
                    <option value="device" {% if element_data[1]["data"][1]["approved_device_id"] %}selected{% endif %}>Device</option>
            </select>
        </div>
      </div>
    </label>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_disa"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_disa"
        action={script script="$('#"++element_id++"_details').text(($('#group_user_device_selector option:selected').text()))"}
        action={submit target="form_cf_select_disa"}
%}
{% endwith %}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
