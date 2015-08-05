{% wire id="form_cf_select_user" type="submit" postback="cf_select_user" delegate="mod_kazoo" %}
<form id="form_cf_select_user" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
            <select id="user_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for option in m.kazoo.kz_list_account_users_short %}
                {% if option[1] %}
                  <option value="{{ option[1] }}" {% if option[1] == kz_element_id %}selected{% endif %}>{{ option[2] }}</option>
                {% endif %}
              {% endfor %}
            </select>
        </div>
        <div id="number_input_div"class="col-sm-6">
          Ring this user's devices for
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
      <button id="button_cf_select_user" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_user" action={script script="$('#"++element_id++"_details').text(($('#user_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_user"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
