{% with m.kazoo[{kz_get_account_blacklist blacklist_id=blacklist_id}] as blacklist %}
{% wire id="form_add_blacklist" type="submit" postback="add_new_blacklist" delegate="mod_kazoo" %}
<form id="form_add_blacklist" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="blacklist_name" name="blacklist_name" placeholder="Enter blacklist name here" value="{{ blacklist[1]["name"] }}">
        </div>
        <div class="col-sm-6">
          <div class="input-group">
            <input id="new_blacklisted_number" name="new_blacklisted_number" type="text" class="form-control"/>
            {% wire id="add_blacklisted_number"  type="click" action={postback postback="add_blacklisted_number" delegate="mod_kazoo" qarg="new_blacklisted_number"}
                                                              action={set_value target="new_blacklisted_number" value=""}
            %}
            <span id="add_blacklisted_number" class="input-group-addon bradius-0 pointer">
             {_ Add number _}
            </span>
          </div>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <ul id="blacklisted_numbers_list" class="list-group">
            {% for blacklisted_n in blacklist[1]["numbers"][1] %}
              {% include "_blacklisted_number.tpl" blacklisted_number=blacklisted_n|element:1 %}
            {% endfor %}
          </ul>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save blacklist _}</button>
        </div>
      </div>
    </div>
{% if blacklist_id %}
  <input type="hidden" name="blacklist_id" value="{{ blacklist[1]["id"] }}">
{% endif %}
{# print blacklist #}
</form>
{% endwith %}
