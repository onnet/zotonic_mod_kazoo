{% wire id="form_cf_select_voicemail" type="submit" postback="cf_select_voicemail" delegate="mod_kazoo" %}
<form id="form_cf_select_voicemail" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
            <select id="voicemail_selector" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for option in m.kazoo.kz_list_account_vmboxes %}
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
    <div class="col-sm-12">
      <button id="button_cf_select_voicemail" class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_voicemail" action={script script="$('#"++element_id++"_details').text(($('#voicemail_selector option:selected').text()))"}
                                  action={submit target="form_cf_select_voicemail"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
