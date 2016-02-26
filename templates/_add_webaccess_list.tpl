{% with m.kazoo[{kz_account_doc_field field1="crossbar_ip_acl"}] as account_ip_acl %}
{% wire id="form_account_ip_acl" type="submit" postback="add_account_ip_acl" delegate="mod_kazoo" %}
<form id="form_account_ip_acl" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <div class="input-group">
            <input id="new_account_ip_acl_entry" name="new_ip_entry" type="text" class="form-control" placeholder="1.2.3.4 or 5.6.7.8/27" />
            {% wire id="add_account_ip_acl_entry"  type="click" action={postback postback="add_account_ip_acl_entry" delegate="mod_kazoo" qarg="new_account_ip_acl_entry"}
                                                              action={set_value target="new_account_ip_acl_entry" value=""}
            %}
            <span id="add_account_ip_acl_entry" class="input-group-addon bradius-0 pointer">
             {_ Add entry _}
            </span>
          </div>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <ul id="account_ip_acl_entries_list" class="list-group">
            {% for account_ip_acl_entry in account_ip_acl %}
              {% include "_account_ip_acl_entry.tpl" %}
            {% endfor %}
          </ul>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save ACL _}</button>
        </div>
      </div>
    </div>
</form>
{% endwith %}
