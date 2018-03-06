{% with m.kazoo[{kz_get_account_blacklist blacklist_id=blacklist_id}] as blacklist %}
{% wire id="form_add_blacklist" type="submit" postback="add_new_blacklist" delegate="mod_kazoo" %}
<form id="form_add_blacklist" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6 col-sm-offset-3">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="blacklist_name"
               name="blacklist_name"
               placeholder="{_ Enter blacklist name here _}"
               value="{{ blacklist[1]["name"] }}"/>
      </div>
    </div>
  </div>
  <div class="form-group">
    <label class="form-control-onnet margin-bottom-xs">
      {_ Add new number to blacklist _}
    <div class="row">
      <div class="col-sm-4">
          <input id="new_blacklisted_number"
                 name="new_blacklisted_number"
                 type="text"
                 class="form-control"
                 placeholder="{_ Enter new number _}"/>
      </div>
      <div class="col-sm-6">
          <input id="new_blacklisted_description"
                 name="new_blacklisted_description"
                 type="text"
                 class="form-control"
                 placeholder="{_ Enter description for new number _}"/>
      </div>
      <div class="col-sm-2">
          {% button id="add_blacklisted_number"
                    class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                    text=_"Add"
                    action={set_value target="new_blacklisted_number" value=""}
                    action={set_value target="new_blacklisted_description" value=""}
                    action={postback postback="add_blacklisted_number"
                                     delegate="mod_kazoo"
                                     qarg="new_blacklisted_number"
                                     qarg="new_blacklisted_description"
                           }
          %}
      </div>
    </div>
    </label>
  </div>
  <div class="form-group">
    <label class="form-control-onnet margin-bottom-xs">
      {_ Blacklisted numbers _}
    <div class="row">
      <div class="col-sm-12">
        <ul id="blacklisted_numbers_list" class="list-group">
          {% for blacklisted_n in blacklist[1]["numbers"][1] %}
            {% include "_blacklisted_number.tpl"
                       blacklisted_number=blacklisted_n|element:1
                       blacklisted_description=blacklisted_n[2][1]["description"]
            %}
          {% endfor %}
        </ul>
      </div>
    </div>
    </label>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Save blacklist _}
        </button>
      </div>
    </div>
  </div>
{% if blacklist_id %}
  <input type="hidden" name="blacklist_id" value="{{ blacklist[1]["id"] }}">
{% endif %}
</form>
{% endwith %}
