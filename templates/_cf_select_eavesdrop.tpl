{% with m.inno[{cf_get_element_by_id element_id=element_id}] as element_data %}
{% with  element_data[1]["data"][1]["approved_group_id"]
        ,element_data[1]["data"][1]["approved_user_id"]
        ,element_data[1]["data"][1]["approved_device_id"]
        ,element_data[1]["data"][1]["group_id"]
        ,element_data[1]["data"][1]["user_id"]
        ,element_data[1]["data"][1]["device_id"]
   as
         approved_group_id
        ,approved_user_id
        ,approved_device_id
        ,group_id
        ,user_id
        ,device_id
%}
{% wire id="form_cf_select_eavesdrop" type="submit" postback="cf_select_eavesdrop" delegate="inno" %}
<form id="form_cf_select_eavesdrop" method="post" action="postback">
    <div class="form-group">
      <label class="form-control-onnet margin-bottom-xs">Target
      <div class="row">
        <div class="col-sm-6">
            {% wire id="selected_type_target" type="change" action={ update target="choice_input_div_target" template="_group_user_device_selector.tpl" selector_name="target_selected"} %}
            <select id="selected_type_target" name="target_type" class="form-control margin-bottom-xs" style="text-align:center;">
                    <option value="user" {% if user_id %}selected{% endif %}>User</option>
                    <option value="device" {% if device_id %}selected{% endif %}>Device</option>
            </select>
        </div>
        <div id="choice_input_div_target"class="col-sm-6">
          {% if device_id %}
            {% include "_group_user_device_selector.tpl" selector_name="target_selected" quasitriggervalue="device" selected_element=device_id %}
          {% else %}
            {% include "_group_user_device_selector.tpl" selector_name="target_selected" quasitriggervalue="user" selected_element=user_id %}
          {% endif %}
        </div>
      </div>
      </label>
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
        <div id="choice_input_div_approved"class="col-sm-6">
          {% if approved_user_id %}
            {% include "_group_user_device_selector.tpl" selector_name="approved_selected" quasitriggervalue="user" selected_element=approved_user_id %}
          {% elseif approved_device_id %}
            {% include "_group_user_device_selector.tpl" selector_name="approved_selected" quasitriggervalue="device" selected_element=approved_device_id %}
          {% else %}
            {% include "_group_user_device_selector.tpl" selector_name="approved_selected" quasitriggervalue="group" selected_element=approved_group_id %}
          {% endif %}
        </div>
      </div>
      </label>
    </div>
    <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_eavesdrop" class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_eavesdrop" action={script script="$('#"++element_id++"_details').text(($('#group_user_device_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_eavesdrop"}
%}
{% endwith %}
{% endwith %}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
