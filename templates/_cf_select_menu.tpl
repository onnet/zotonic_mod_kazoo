{% wire id="form_cf_select_menu" type="submit" postback="cf_select_menu" delegate="inno" %}
<form id="form_cf_select_menu" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
            <select id="menu_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for option in m.inno.kz_list_account_menus %}
                  <option value="{{ option["id"] }}" {% if option["id"] == kz_element_id %}selected{% endif %}>{{ option["name"] }}</option>
              {% endfor %}
            </select>
        </div>
      </div>
    </div>
    <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_menu" class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_menu" action={script script="$('#"++element_id++"_details').text(($('#menu_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_menu"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
