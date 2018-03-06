{% with m.kazoo[{cf_get_element_by_id element_id=element_id}] as element_data %}
{% wire id="form_cf_select_response"
        type="submit"
        postback="cf_select_response"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_response" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-2">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="sip_code"
               name="code"
               placeholder="{_ Code _}"
               value="{{ element_data[1]["data"][1]["code"] }}">
      </div>
      <div class="col-sm-5">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="message"
               name="message"
               placeholder="{_ Message _}"
               value="{{ element_data[1]["data"][1]["message"] }}">
      </div>
      <div class="col-sm-5">
        <select id="response_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;"
                data-live-search="true">
          {% for option in m.kazoo.kz_list_account_media %}
            <option value="{{ option[1]["id"] }}"
                    {% if option[1]["id"] == element_data[1]["data"][1]["media"] %}
                      selected
                    {% endif %}>{{ option[1]["name"] }}</option>
          {% endfor %}
        </select>
      </div>
    </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_response"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Commit _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_response"
        action={script script="$('#"++element_id++"_details').text('SIP Code: ' + ($('#sip_code').val()))"}
        action={submit target="form_cf_select_response"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
  $('#response_selector').selectpicker({size: 5});
  $(function() {
      $('#response_selector').on('change', function(){
        var selected = $(this).find("option:selected").val();
        var selected_name = $(this).find("option:selected").text();
      });
  });
{% endjavascript %}
{% endwith %}
