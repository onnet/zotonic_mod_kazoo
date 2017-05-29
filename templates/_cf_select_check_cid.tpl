{% with
     m.kazoo[{cf_get_module_info module_name=tool_name module_path=element_id}]
   as
     this_check_cid
%}
{% wire id="form_cf_select_check_cid"
        type="submit"
        postback="cf_select_check_cid"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_check_cid" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        {% wire id="use_absolute_mode_selector"
                type="change"
                action={update target="check_cid_type_div"
                               template="_cf_check_cid_type.tpl"
                       }
        %}
        <select id="use_absolute_mode_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="true">{_ Exact numbers _}</option>
          <option value="false">{_ Regex match _}</option>
        </select>
      </div>
    <div id="check_cid_type_div"class="col-sm-6">
      {% include "_cf_check_cid_type.tpl" %}
    </div>
  </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_check_cid"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% endwith %}
{% wire id="button_cf_select_check_cid"
        action={script script="$('#"++element_id++"_details').text(($('#use_absolute_mode_selector option:selected').text()))"}
        action={submit target="form_cf_select_check_cid"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
