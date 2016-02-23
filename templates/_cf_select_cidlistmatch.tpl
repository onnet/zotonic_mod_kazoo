{% with m.kazoo[{cf_get_module_info module_name=tool_name module_path=element_id}] as this_cidlistmatch %}
{% wire id="form_cf_select_cidlistmatch" type="submit" postback="cf_select_cidlistmatch" delegate="mod_kazoo" %}
<form id="form_cf_select_cidlistmatch" method="post" action="postback">
   <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
            <select id="match_cid_list" name="selected" class="form-control margin-bottom-xs" style="text-align:center;">
            {% for list in m.kazoo.kz_list_account_lists %}
              {% if list["list_type"] == "phone_book" %}
                <option value="{{ list["id"] }}" {% if list["id"] == "phone_book" %}selected{% endif %}>{{ list["name"] }}</option>
              {% endif %}
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
      <button id="button_cf_select_cidlistmatch" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% endwith %}
{% wire id="button_cf_select_cidlistmatch" action={script script="$('#"++element_id++"_details').text(($('#match_cid_list option:selected').text()))"}
                                  action={submit target="form_cf_select_cidlistmatch"}
%}
{% javascript %}
    $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
