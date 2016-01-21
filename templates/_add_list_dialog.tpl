{% with m.kazoo[{kz_get_account_list list_id=list_id}] as list %}
{% wire id="form_add_list" type="submit" postback="add_new_list" delegate="mod_kazoo" %}
<form id="form_add_list" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
            <select id="list_type_id" name="list_type" class="form-control margin-bottom-xs" title="-- {_ List type _} --" style="text-align:center;">
                <option value="phone_book" {% if list[1]["list_type"] == "phone_book" %}selected{% endif %}>Phone book</option>
                <option value="dynamic_cid" {% if list[1]["list_type"] == "dynamic_cid" %}selected{% endif %}>Dynamic CID</option>
            </select>
        </div>
        <div class="col-sm-3">
          <input type="text" class="form-control margin-bottom-xs" id="list_name" name="list_name" placeholder="{_ Enter list name here _}" value="{{ list[1]["name"] }}">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="list_description" name="list_description" placeholder="{_ Enter description name here _}" value="{{ list[1]["description"] }}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save list _}</button>
        </div>
      </div>
    </div>
{% if list_id %}
  <input type="hidden" name="list_id" value="{{ list[1]["id"] }}">
{% endif %}
</form>
{% endwith %}
