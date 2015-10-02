{% wire id="form_cf_select_option_temporal_route" type="submit" postback="cf_select_option_temporal_route" delegate="mod_kazoo" %}
<form id="form_cf_select_option_temporal_route" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 text-center">
            {_ Choose menu option _}
        </div>
        <div class="col-sm-6">
            <select id="menu_key_selector" name="switch" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
              {% for key in available_keys %}
                  <option value="{{ key }}" {% if key == kz_element_id %}selected{% endif %}>
                    {% if key=="_" %}{_ Default action _}{% else %}{{ m.kazoo[{kz_get_temporal_rule rule_id=key}][1]["name"] }}{% endif %}
                  </option>
              {% endfor %}
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% wire id="button_cf_select_time_of_the_day_create" action={dialog_open title=_"Add Time of Day rule" template="_add_time_of_the_day_dialog.tpl"} %}
          <button id="button_cf_select_time_of_the_day_create" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Add Time of Day rule _}</button>
        </div>
        {% wire name="refresh_edit_time_of_the_day_btn_cf_time_of_the_day" action={ update target="edit_time_of_the_day_btn_cf_time_of_the_day" template="_cf_edit_time_of_the_day_button.tpl" } %}
        <div id="edit_time_of_the_day_btn_cf_time_of_the_day" class="col-sm-6">
          {% if kz_element_id %}
            {% wire id="button_cf_select_edit_kztime_of_the_day" action={ dialog_open title=_"Edit rule"++" "++m.kazoo[{kz_get_temporal_rule rule_id=kz_element_id}][1]["name"] 
                                                                                      template="_edit_time_of_the_day_lazy.tpl" rule_id=kz_element_id width="auto" } %}
            <button id="button_cf_select_edit_kztime_of_the_day" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Edit Time of Day rule _}</button>
          {% endif %}
        </div>
      </div>
    </div>
    <input type="hidden" name="tool_name" value="{{ tool_name }}">
    <input type="hidden" name="drop_id" value="{{ drop_id }}">
    <input type="hidden" name="drop_parent" value="{{ drop_parent }}">
    <input type="hidden" name="branch_id" value="{{ branch_id }}">
    <input type="hidden" name="existing_element_id" value="{{ existing_element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_option_temporal_route" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_option_temporal_route" action={submit target="form_cf_select_option_temporal_route"} %}

{% javascript %}
    $('#menu_key_selector').selectpicker({size: 5});
    $(function() {
        $('#menu_key_selector').on('change', function(){
          var selected = $(this).find("option:selected").val();
          var selected_name = $(this).find("option:selected").text();
          z_event("refresh_edit_time_of_the_day_btn_cf_time_of_the_day", { kz_element_id: selected, kz_element_name: selected_name });
        });
    });
{% endjavascript %}
