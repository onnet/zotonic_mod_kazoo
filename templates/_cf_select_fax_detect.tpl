{% wire id="form_cf_select_fax_detect"
        type="submit"
        postback="cf_select_fax_detect"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_fax_detect" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-3  col-sm-offset-4">
       <label class="form-control-onnet margin-bottom-xs">
          {_ Fax detect duration _}
        <select id="fax_detect_duration_s"
                name="duration"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
        </select>
       </label>
      </div>
    <div id="fax_detect_type_div"class="col-sm-6">
      {% include "_cf_fax_detect_type.tpl" %}
    </div>
  </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_fax_detect"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_fax_detect"
        action={script script="$('#"++element_id++"_details').text(($('#use_absolute_mode_selector option:selected').text()))"}
        action={submit target="form_cf_select_fax_detect"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
