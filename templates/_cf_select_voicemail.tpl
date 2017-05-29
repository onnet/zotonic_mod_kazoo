{% wire id="form_cf_select_voicemail"
        type="submit"
        postback="cf_select_voicemail"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_voicemail" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <select id="voicemail_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;"
                data-live-search="true">
          {% for option in m.kazoo.kz_list_account_vmboxes %}
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
      {% wire id="button_cf_select_vmbox_create"
              action={dialog_open title=_"Add vmbox"
                                  template="_add_vm_dialog.tpl"
                                  width="auto"
                     }
      %}
      <button id="button_cf_select_vmbox_create"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Add voicemail _}
      </button>
    </div>
    {% wire name="refresh_edit_vmbox_btn_cf_vmbox"
            action={update target="edit_vmbox_btn_cf_vmbox"
                           template="_cf_edit_vm_button.tpl"
                   }
    %}
    <div id="edit_vmbox_btn_cf_vmbox" class="col-sm-6">
      {% if kz_element_id %}
        {% wire id="button_cf_select_edit_kzvmbox"
                action={dialog_open title=_"Edit voicemail"++" "++kz_element_name
                                    template="_add_vm_dialog.tpl"
                                    vmbox_id=kz_element_id width="auto"
                       }
        %}
        <button id="button_cf_select_edit_kzvmbox"
                class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Edit voicemail _}
        </button>
      {% endif %}
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_voicemail"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_voicemail"
        action={script script="$('#"++element_id++"_details').text(($('#voicemail_selector option:selected').text()))"}
        action={submit target="form_cf_select_voicemail"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
  $('#voicemail_selector').selectpicker({size: 5});
  $(function() {
      $('#voicemail_selector').on('change', function(){
        var selected = $(this).find("option:selected").val();
        var selected_name = $(this).find("option:selected").text();
        z_event("refresh_edit_vmbox_btn_cf_vmbox", { kz_element_id: selected, kz_element_name: selected_name });
      });
  });
{% endjavascript %}
