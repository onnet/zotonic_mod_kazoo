{% wire id="form_cf_select_menu"
        type="submit"
        postback="cf_select_menu"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_menu" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <select id="menu_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;"
                data-live-search="true">
          {% for option in m.kazoo.kz_list_account_menus %}
             <option value="{{ option[1]["id"] }}"
                     {% if option[1]["id"] == kz_element_id %}
                       selected
                     {% endif %}>
              {{ option[1]["name"] }}
            </option>
          {% endfor %}
        </select>
      </div>
    </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-6">
      {% wire id="button_cf_select_menu_create"
              action={dialog_open title=_"Add menu"
                                  template="_add_menu_dialog.tpl"
                                  width="auto"
                     }
      %}
      <button id="button_cf_select_menu_create"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Add menu _}
      </button>
    </div>
    {% wire name="refresh_edit_menu_btn_cf_menu"
            action={update target="edit_menu_btn_cf_menu"
                           template="_cf_edit_menu_button.tpl"
                   }
    %}
    <div id="edit_menu_btn_cf_menu" class="col-sm-6">
      {% if kz_element_id %}
        {% wire id="button_cf_select_edit_kzmenu"
                action={dialog_open title=_"Edit menu"++" "++kz_element_name
                                    template="_edit_menu_lazy.tpl"
                                    menu_id=kz_element_id width="auto"
                       }
        %}
        <button id="button_cf_select_edit_kzmenu"
                class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Edit menu _}
        </button>
      {% endif %}
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_menu"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_menu"
        action={script script="$('#"++element_id++"_details').text(($('#menu_selector option:selected').text()))"}
        action={submit target="form_cf_select_menu"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
  $('#menu_selector').selectpicker({size: 5});
  $(function() {
      $('#menu_selector').on('change', function(){
        var selected = $(this).find("option:selected").val();
        var selected_name = $(this).find("option:selected").text();
        z_event("refresh_edit_menu_btn_cf_menu", { kz_element_id: selected, kz_element_name: selected_name });
      });
  });
{% endjavascript %}
