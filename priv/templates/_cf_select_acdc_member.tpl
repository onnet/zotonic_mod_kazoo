{% wire id="form_cf_select_acdc_member"
        type="submit"
        postback="cf_select_acdc_member"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_acdc_member" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <select id="acdc_member_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          {% for option in m.kazoo[{queues account_id=account_id}] %}
              <option value="{{ option[1]["id"] }}"
                      {% if option[1]["id"]==kz_element_id %}
                        selected="selected"
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
    <div class="col-sm-12">
      <button id="button_cf_select_acdc_member"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_acdc_member"
        action={script script="$('#"++element_id++"_details').text(($('#acdc_member_selector option:selected').text()))"}
        action={submit target="form_cf_select_acdc_member"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
