{% wire id="form_cf_select_group_pickup" type="submit" postback="cf_select_group_pickup" delegate="inno" %}
<form id="form_cf_select_group_pickup" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
            {% wire id="selected_type" type="change" action={ update target="choice_input_div" template="_group_user_device_selector.tpl" } %}
            <select id="selected_type" name="pickup_type" class="form-control margin-bottom-xs" style="text-align:center;">
                    <option value="group" selected>Group</option>
                    <option value="user">User</option>
                    <option value="device">Device</option>
            </select>
        </div>
        <div id="choice_input_div"class="col-sm-6">
          {% include "_group_user_device_selector.tpl" %}
        </div>
      </div>
    </div>
    <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_group_pickup" class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_group_pickup" action={script script="$('#"++element_id++"_details').text(($('#group_user_device_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_group_pickup"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
