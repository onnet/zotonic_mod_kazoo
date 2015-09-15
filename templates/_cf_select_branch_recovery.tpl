{% wire id="form_cf_select_branch_recovery" type="submit" postback="cf_select_branch_recovery" delegate="mod_kazoo" %}
<form id="form_cf_select_branch_recovery" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
            <select id="branch_recovery_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
              {% for option in m.kazoo.kz_list_cf_slots %}
                  <option value="{{ option["id"] }}">{{ option["name"] }}</option>
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
      <button id="button_cf_select_branch_recovery" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_branch_recovery" action={script script="$('#"++element_id++"_details').text(($('#branch_recovery_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_branch_recovery"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
    $('#branch_recovery_selector').selectpicker({size: 5});
{% endjavascript %}
