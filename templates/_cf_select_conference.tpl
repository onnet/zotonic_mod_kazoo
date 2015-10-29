{% wire id="form_cf_select_conference" type="submit" postback="cf_select_conference" delegate="mod_kazoo" %}
<form id="form_cf_select_conference" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
            <select id="conference_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
              <option value="">{_ Conference Server _}</option>
              {% for option in m.kazoo.kz_list_account_conferences %}
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
    <div class="col-sm-6">
      {% wire id="button_cf_select_conference_create" action={dialog_open title=_"Add conference" template="_add_conference_dialog.tpl" width="auto"} %}
      <button id="button_cf_select_conference_create" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Add conference _}</button>
    </div>
    {% wire name="refresh_edit_conference_btn_cf_conference" action={ update target="edit_conference_btn_cf_conference" template="_cf_edit_conference_button.tpl" } %}
    <div id="edit_conference_btn_cf_conference" class="col-sm-6">
      {% if kz_element_id %}
        {% wire id="button_cf_select_edit_kzconference" action={ dialog_open title=_"Edit conference"++" "++kz_element_name template="_edit_conference_lazy.tpl" conference_id=kz_element_id width="auto" } %}
        <button id="button_cf_select_edit_kzconference" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Edit conference _}</button>
      {% endif %}
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_conference" class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_conference" action={script script="$('#"++element_id++"_details').text(($('#conference_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_conference"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
    $('#conference_selector').selectpicker({size: 5});

    $(function() {
        $('#conference_selector').on('change', function(){
          var selected = $(this).find("option:selected").val();
          var selected_name = $(this).find("option:selected").text();
          z_event("refresh_edit_conference_btn_cf_conference", { kz_element_id: selected, kz_element_name: selected_name });
        });
    });

{% endjavascript %}
