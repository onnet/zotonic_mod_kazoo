{% with m.kazoo[{cf_get_element_by_id element_id=element_id}] as element_data %}
{% wire id="form_cf_select_route_to_cid"
        type="submit"
        postback="cf_select_route_to_cid"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_route_to_cid" method="post" action="postback">
  <div class="form-group pt-1">
    <div class="row">
      <div class="col-sm-3 col-sm-offset-3">
        <label for="user_cid_lookup"
               class="checkbox-inline
                      {% if "user"|member:element_data[1]["data"][1]["endpoint_types"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="user_cid_lookup"
                 name="endpoint_types"
                 value="user"
                 {% if "user"|member:element_data[1]["data"][1]["endpoint_types"] %}
                   checked
                 {% endif %}>
          {_ Lookup users' CID _}
        </label>
      </div>
      <div class="col-sm-3">
        <label for="device_cid_lookup"
               class="checkbox-inline
                      {% if "device"|member:element_data[1]["data"][1]["endpoint_types"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="device_cid_lookup"
                 name="endpoint_types"
                 value="device"
                 {% if "device"|member:element_data[1]["data"][1]["endpoint_types"] %}
                   checked
                 {% endif %}>
          {_ Lookup devices' CID _}
        </label>
      </div>
    </div>
  </div>
  <div class="form-group pt-1">
    <div class="row">
      <div class="col-sm-3 col-sm-offset-3">
        <label for="external_cid_lookup"
               class="checkbox-inline
                      {% if "external"|member:element_data[1]["data"][1]["cid_types"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="external_cid_lookup"
                 name="cid_types"
                 value="external"
                 {% if "external"|member:element_data[1]["data"][1]["cid_types"] %}
                   checked
                 {% endif %}>
          {_ Lookup external CID _}
        </label>
      </div>
      <div class="col-sm-3">
        <label for="internal_cid_lookup"
               class="checkbox-inline
                      {% if "internal"|member:element_data[1]["data"][1]["cid_types"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="internal_cid_lookup"
                 name="cid_types"
                 value="internal"
                 {% if "internal"|member:element_data[1]["data"][1]["cid_types"] %}
                   checked
                 {% endif %}>
          {_ Lookup internal CID _}
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div id="number_input_div"class="col-sm-12 text-center">
        {_ Ring endpoint for _}
        <input type="text"
               name="timeout"
               id="parameter_input"
               maxlength="3"
               size="3"
               style="height: 34px; text-align: center;"
               value="{% if element_data[1]["data"][1]["timeout"] %}{{ element_data[1]["data"][1]["timeout"] }}{% else %}20{% endif %}">
        {_ seconds _}.
      </div>
      <div id="number_input_div"class="col-sm-4">
      </div>
    </div>
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
<div class="form-group pt-1">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_select_route_to_cid"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{% wire id="button_cf_select_route_to_cid"
        action={submit target="form_cf_select_route_to_cid"}
%}
{% endwith %}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>
