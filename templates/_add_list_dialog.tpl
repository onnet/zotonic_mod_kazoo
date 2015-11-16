{% with m.kazoo[{kz_get_account_list list_id=list_id}] as list %}
{% wire id="form_add_list" type="submit" postback="add_new_list" delegate="mod_kazoo" %}
<form id="form_add_list" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
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
