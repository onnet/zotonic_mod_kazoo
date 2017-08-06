{% wire id="form_cf_select_acdc_agent"
        type="submit"
        postback="cf_select_acdc_agent"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_acdc_agent" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <select id="acdc_agent_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
              <option value="login"
                      {% if "login"==kz_element_id %}
                        selected="selected"
                      {% endif %}>
                  Login
              </option>
              <option value="logout"
                      {% if "logout"==kz_element_id %}
                        selected="selected"
                      {% endif %}>
                  Logout
              </option>
              <option value="pause"
                      {% if "pause"==kz_element_id %}
                        selected="selected"
                      {% endif %}>
                  Pause
              </option>
              <option value="resume"
                      {% if "resume"==kz_element_id %}
                        selected="selected"
                      {% endif %}>
                  Resume
              </option>
        </select>
      </div>
    </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_acdc_agent"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_acdc_agent"
        action={script script="$('#"++element_id++"_details').text(($('#acdc_agent_selector option:selected').text()))"}
        action={submit target="form_cf_select_acdc_agent"}
%}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
