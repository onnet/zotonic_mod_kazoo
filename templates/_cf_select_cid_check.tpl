{% with m.kazoo[{cf_get_module_info module_name=tool_name module_path=element_id}] as this_cid_check %}
{% wire id="form_cf_select_cid_check" type="submit" postback="cf_select_cid_check" delegate="mod_kazoo" %}
<form id="form_cf_select_cid_check" method="post" action="postback">
   <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
            {% wire id="use_absolute_mode_selector" type="change" action={ update target="cid_check_type_div" template="_cf_cid_check_type.tpl" }%}
            <select id="use_absolute_mode_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
                    <option value="true">{_ Exact numbers _}</option>
                    <option value="false">{_ Regex match _}</option>
            </select>
        </div>
        <div id="cid_check_type_div"class="col-sm-6">
          {% include "_cf_cid_check_type.tpl" %}
        </div>
      </div>
    </div>
    <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_cid_check" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% print this_cid_check %}
{% endwith %}
{% wire id="button_cf_select_cid_check" action={script script="$('#"++element_id++"_details').text(($('#use_absolute_mode_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_cid_check"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
