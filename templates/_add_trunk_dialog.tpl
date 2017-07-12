{% with m.kazoo[{kz_get_account_trunk trunk_id=trunk_id}] as trunk_doc %}
{% with m.kazoo[{kz_get_trunk_server trunk_id=trunk_id server_index=server_index}] as server %}
{% wire id="form_kz_trunk" type="submit" postback="kz_trunk_server" delegate="mod_kazoo" %}
<form id="form_kz_trunk" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Trunk name _} <small>(mandatory)</small>
            <input type="text"
                   class="form-control margin-bottom-xs"
                   id="server_name"
                   name="server_name"
                   placeholder="{_ Enter trunk name here _}"
                   value="{{ server[1]["server_name"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs pl-1">
            {_ Realm _}:
            <input type="text"
                   class="form-control margin-bottom-xs zprimary"
                   style="background-color: white!important;"
                   value="{% if trunk_doc[1]["account"][1]["auth_realm"]
                            %}{{ trunk_doc[1]["account"][1]["auth_realm"] }}{%
                              else %}{{ m.kazoo.get_account_realm }}{% endif %}"
                   readonly>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Media handling _}
            <select id="media_handling"
                    name="media_handling"
                    class="form-control margin-bottom-xs"
                    style="text-align:center;">
              <option value="bypass"
                      {% if server[1]["options"][1]["media_handling"] == "bypass" %}
                        selected
                      {% endif %}>
                bypass
              </option>
              <option value="process"
                      {% if server[1]["options"][1]["media_handling"] == "process" %}
                        selected
                      {% endif %}>
                process
              </option>
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Auth method _}
            {% wire id="auth_method"
                        type="change"
                        action={update target="auth_types"
                                       template="_add_trunk_dialog_auth_types.tpl"
                                       server=server
                               }
            %}
            <select name="auth_method" id="auth_method" class="form-control margin-bottom-xs">
              <option id="Password"
                      value="Password"
                      {% if server[1]["auth"][1]["auth_method"] == "Password" %}
                        selected
                      {% endif %}>
                {_ Password _}
              </option>
              <option id="IP"
                      value="IP"
                      {% if server[1]["auth"][1]["auth_method"] == "IP" %}
                        selected
                      {% endif %}>
                {_ IP _}
              </option>
            </select>
          </label>
        </div>
        <span id="auth_types">
            {% include "_add_trunk_dialog_auth_types.tpl" server=server %}
        </span>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">{_ Invite format _}
            <select id="inbound_format"
                    name="inbound_format"
                    class="form-control margin-bottom-xs"
                    style="text-align:center;">
              <option value="e164"
                      {% if server[1]["options"][1]["inbound_format"] == "e164" %}
                        selected
                      {% endif %}>
                E.164@Realm
              </option>
              <option value="username"
                      {% if server[1]["options"][1]["inbound_format"] == "username" %}
                        selected
                      {% endif %}>
                SIP_Username@Realm
              </option>
            </select>
          </label>
        </div>
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">
            {_ CID Number _}
            <select id="cid_number"
                    name="cid_number"
                    class="form-control margin-bottom-xs"
                    style="text-align:center;">
              <option style="text-align:center;" value="">
                -- {_ No specified CID _} --
              </option>
              {% for account_number in m.kazoo.get_acc_numbers %} 
                <option value="{{ account_number }}"
                        {% if server[1]["options"][1]["caller_id"][1]["cid_number"] == account_number %}
                          selected
                        {% endif %}>
                  {{ account_number }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">
            {_ CID Name _} <small>(mandatory)</small>
            <input type="text"
                   class="form-control margin-bottom-xs"
                   id="cid_name"
                   name="cid_name"
                   placeholder="{_ Enter CID name here _}"
                   value="{{ server[1]["options"][1]["caller_id"][1]["cid_name"] }}">
          </label>
        </div>
      </div>
    </div>
    {% if trunk_id %}
      <input type="hidden" name="trunk_id" value="{{ trunk_id }}">
    {% endif %}
    {% if server_index %}
      <input type="hidden" name="server_index" value="{{ server_index }}">
    {% endif %}
</form>
{% wire id="button_add_trunk_save" action={submit target="form_kz_trunk"} %}
<div class="form-group">
  <div class="row">
    <div class="col-sm-6">
      <button id="button_add_trunk_save"
              class="col-xs-12 btn btn-zalarm margin-bottom-xs">
        {_ Save settings _}
      </button>
    </div>
    {% wire id="button_cancel_numbers_list" action={dialog_close} %}
    <div class="col-sm-6">
      <button id="button_cancel_numbers_list"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Close _}
      </button>
    </div>
  </div>
</div>
{% endwith %}
{% endwith %}
