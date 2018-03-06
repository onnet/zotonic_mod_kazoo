{% wire id="form_cf_select_option"
        type="submit"
        postback="cf_select_option"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_option" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6 text-center">
        {_ Choose menu option _}
      </div>
      <div class="col-sm-6">
        <select id="menu_key_selector"
                name="switch"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          {% for key in available_keys %}
            <option value="{{ key }}">
              {% if key=="_" %}
                {_ Default action _}
              {% else %}
                {{ key }}
              {% endif %}
            </option>
          {% endfor %}
        </select>
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
      <button id="button_cf_select_option"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_option" action={submit target="form_cf_select_option"} %}
