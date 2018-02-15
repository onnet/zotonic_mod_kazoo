{% wire id="form_cf_select_play"
        type="submit"
        postback="cf_select_play"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_play" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
          <select id="play_selector"
                  name="selected"
                  class="form-control margin-bottom-xs"
                  style="text-align:center;"
                  data-live-search="true">
            {% for option in m.kazoo.kz_list_account_media %}
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
      {% wire id="button_cf_select_prompt_create"
              action={dialog_open title=_"Add sound file"
                                  template="_add_media_dialog.tpl"
                     }
      %}
      <button id="button_cf_select_prompt_create"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Add sound file _}
      </button>
    </div>
    {% wire name="refresh_edit_prompt_btn_cf_prompt"
            action={update target="edit_prompt_btn_cf_prompt"
                           template="_cf_edit_prompt_button.tpl"
                   }
    %}
    <div id="edit_prompt_btn_cf_prompt" class="col-sm-6">
      {% if kz_element_id %}
        {% wire id="button_cf_select_edit_kzprompt"
                action={dialog_open title=_"Edit prompt"++" "++kz_element_name
                                    template="_edit_media_lazy.tpl"
                                    prompt_id=kz_element_id width="auto"
                       }
        %}
        <button id="button_cf_select_edit_kzprompt"
                class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Edit prompt _}
        </button>
      {% endif %}
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_play"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_play"
        action={script
                script="$('#"++element_id++"_details').text(($('#play_selector option:selected').text()))"
               }
        action={submit target="form_cf_select_play"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
    $('#play_selector').selectpicker({size: 5});
    $(function() {
        $('#play_selector').on('change', function(){
          var selected = $(this).find("option:selected").val();
          var selected_name = $(this).find("option:selected").text();
          z_event("refresh_edit_prompt_btn_cf_prompt", {kz_element_id: selected, kz_element_name: selected_name});
        });
    });
{% endjavascript %}
