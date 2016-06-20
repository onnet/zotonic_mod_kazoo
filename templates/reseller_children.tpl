{% with m.session.rs_selected_account_id as account_id %}
<div class="row" style="margin-top: 2em; margin-bottom: 1em;">
  {% wire id="search_account_btn" action={ dialog_open title=_"Account lookup " template="_rs_search_dialog.tpl" } %}
  <div class="col-xs-2 col-xs-offset-1">
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
  {% wire id="create_account_btn" action={ dialog_open title=_"Create an account" template="_rs_add_account.tpl" } %}
  <div class="col-xs-2">
    <button id="create_account_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Create _}</button>
  </div>
</div>

<div id="child_sandbox" class="row">
{% if account_id %}
  {% include "reseller_child_info.tpl" %}
{% endif %}
</div>
{% endwith %}
