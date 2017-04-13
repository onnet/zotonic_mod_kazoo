{% with m.kazoo[{cf_get_element_by_id element_id=element_id}] as element_data %}
{% wire id="form_cf_select_user"
        type="submit"
        postback="cf_select_user"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_user" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <select id="user_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;"
                data-live-search="true">
          {% for option in m.kazoo.kz_list_account_users_short %}
            {% if option[1] %}
              <option value="{{ option[1] }}"
                      {% if option[1] == kz_element_id %}
                        selected
                      {% endif %}>{{ option[2] }}</option>
            {% endif %}
          {% endfor %}
        </select>
      </div>
      <div id="number_input_div"class="col-sm-6">
        Ring this user's devices for
        <input type="text"
               name="timeout"
               id="parameter_input"
               maxlength="3"
               size="3"
               style="height: 34px; text-align: center;"
               value="{% if element_data[1]["data"][1]["timeout"]
                       %}{{ element_data[1]["data"][1]["timeout"] }}{%
                         else %}20{% endif %}">
        seconds.
      </div>
    </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-6">
      {% wire id="button_cf_select_user_create"
              action={dialog_open title=_"Add user" template="_add_user_dialog.tpl"}
      %}
      <button id="button_cf_select_user_create"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Add user _}
      </button>
    </div>
    {% wire name="refresh_edit_user_btn_cf_user"
            action={update target="edit_user_btn_cf_user" template="_cf_edit_user_button.tpl"}
    %}
    <div id="edit_user_btn_cf_user" class="col-sm-6">
      {% if kz_element_id %}
        {% wire id="button_cf_select_edit_kzuser"
                action={dialog_open title=_"Edit user"++" "++kz_element_name
                                    template="_edit_user_lazy.tpl"
                                    user_id=kz_element_id width="auto"
                       }
        %}
        <button id="button_cf_select_edit_kzuser"
                class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Edit user _}
        </button>
      {% endif %}
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_user"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_user"
        action={script script="$('#"++element_id++"_details').text(($('#user_selector option:selected').text()))"}
        action={submit target="form_cf_select_user"}
%}
{% endwith %}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());

  $('#user_selector').selectpicker({size: 5});

  $(function() {
      $('#user_selector').on('change', function(){
        var selected = $(this).find("option:selected").val();
        var selected_name = $(this).find("option:selected").text();
        z_event("refresh_edit_user_btn_cf_user", { kz_element_id: selected, kz_element_name: selected_name });
      });
  });
{% endjavascript %}
