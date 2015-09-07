{% wire id="form_cf_select_record_call" type="submit" postback="cf_select_record_call" delegate="mod_kazoo" %}
<form id="form_cf_select_record_call" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
            <select id="record_call_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
                <option value="mp3" {% if kz_element_id=="mp3" %}selected="selected"{% endif %}>mp3</option>
                <option value="wav" {% if kz_element_id=="wav" %}selected="selected"{% endif %}>wav</option>
            </select>
        </div>
      </div>
    </div>
    <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_record_call" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_record_call" action={script script="$('#"++element_id++"_details').text(($('#record_call_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_record_call"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
