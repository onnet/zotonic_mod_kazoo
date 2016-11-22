{% with m.session.rs_selected_account_id as account_id %}
<div class="row" style="margin-top: 2em; margin-bottom: 2em;">
  {% wire id="search_account_btn" action={ dialog_open title=_"Account lookup " template="_rs_search_dialog.tpl" } %}
  <div class="col-xs-2 {% if not account_id %}col-xs-offset-2{% endif %}">
    <button id="search_account_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Search _}</button>
  </div>
  <div class="col-xs-4">
    {% wire id="child_selector" type="change"
                                action={postback postback="rs_child_selected" delegate="mod_kazoo"}
    %}
    <select id="child_selector" name="selected" class="col-xs-12 form-control margin-bottom-xs selectpicker" style="text-align:center;display: none;"
                                title=" -- {_ Select account to edit _} -- " data-live-search="true">
      {% for option in m.kazoo.kz_list_account_children %}
          <option value="{{ option["id"] }}" {% if option["id"] == account_id %}selected{% endif %}>
            {{ option["name"] }} - {{ option["realm"] }}
          </option>
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#child_selector').selectpicker({
      style: 'btn-zalarm',
      size: 7
    });
  {% endjavascript %}


{% if account_id %}
  <div class="col-xs-2">
    {% wire id="user_mask_selector" type="change" action={postback postback={rs_account_mask account_id=account_id} delegate="mod_kazoo"} %}
    <select id="user_mask_selector" name="selected" class="col-xs-12 form-control margin-bottom-xs selectpicker" title="{_ Mask _}"  data-live-search="true">
      <option value="userless_mask">{_ Without user _}</option>
      {% for option in m.kazoo[{kz_list_account_users account_id=account_id}] %}
          <option value="{{ option["id"] }}">{{ option["username"] }}</option>
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#user_mask_selector').selectpicker({
      style: 'btn-zprimary',
      size: 5
    });
  {% endjavascript %}
{% endif %}



  {% wire id="create_account_btn" action={ dialog_open title=_"Create an account" template="_rs_add_account.tpl" } %}
  <div class="col-xs-2">
    <button id="create_account_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Create _}</button>
  </div>

{% if account_id %}
  {% wire id="rs_account_delete_btn" action={confirm text="Do you really want to delete this account?"
                                     action={postback postback={rs_account_delete account_id=account_id} delegate="mod_kazoo"}
                             }
  %}
  <div class="col-xs-2">
    <button id="rs_account_delete_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Delete _}</button>
  </div>
{% endif %}


</div>

<div id="child_sandbox" class="row">
{% if account_id %}
  {% include "reseller_child_info.tpl" %}
{% endif %}
</div>
{% endwith %}
