{% with m.kazoo.kz_account_access_lists as sip_access_lists %}
{% wire id="form_account_sip_acl" type="submit" postback="add_account_sip_acl" delegate="mod_kazoo" %}
<form id="form_account_sip_acl" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
            <select id="sip_access_lists_order" name="sip_access_lists_order" class="form-control margin-bottom-xs" style="text-align:center;">
              <option value="allow,deny" {% if sip_access_lists[1]["order"] == "allow,deny" %}selected{% endif %}> allow configured, deny others </option>
              <option value="deny,allow" {% if sip_access_lists[1]["order"] == "deny,allow" %}selected{% endif %}> deny configured, allow others </option>
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <div class="input-group">
            <input id="new_account_ip_acl_entry" name="new_ip_entry" type="text" class="form-control" placeholder="5.6.7.8/27" />
            {% wire id="add_account_ip_acl_entry"
                    type="click"
                    action={postback postback="add_account_ip_acl_entry" delegate="mod_kazoo" qarg="new_account_ip_acl_entry"}
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
            {% for account_ip_acl_entry in sip_access_lists[1]["cidrs"] %}
              {% include "_account_ip_acl_entry.tpl" %}
            {% endfor %}
          </ul>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save SIP ACL _}</button>
        </div>
      </div>
    </div>
</form>
{% endwith %}
