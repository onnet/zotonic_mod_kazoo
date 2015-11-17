<div class="row" style="margin-top: 2em; margin-bottom: 1em;">
  <div class="col-xs-2 col-xs-offset-1">
  </div>
  <div class="col-xs-4">
    {% wire id="conference_selector" type="change" action={postback postback="conference_selected" delegate="mod_kazoo"} %}
    <select id="conference_selector" name="selected" class="col-xs-12 form-control margin-bottom-xs selectpicker" style="text-align:center;display: none;"
                                title=" -- {_ Select conference to manage _} -- " data-live-search="true">
      {% for option in m.kazoo.kz_list_account_conferences %}
          <option value="{{ option["id"] }}" {% if option["id"] == conference_id %}selected{% endif %}>
            {{ option["name"] }} - {{ option["realm"] }}
          </option>
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#conference_selector').selectpicker({
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
{% if conference_id %}
  {% include "conference_info.tpl" conference_id=conference_id %}
{% endif %}
</div>
