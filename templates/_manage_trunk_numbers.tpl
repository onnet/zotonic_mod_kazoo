{% with m.kazoo[{kz_get_trunk_server trunk_id=trunk_id server_index=server_index}] as server %}
{% wire id="form_manage_trunk_numbers" type="submit" postback="manage_trunk_numbers" delegate="mod_kazoo" %}
<form id="form_manage_trunk_numbers" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          {% wire id="spare_number_selector" type="change" action={insert_bottom target="ts_numbers_list" template="_ts_number.tpl"}
                                                           action={script script="$('#spare_number_selector option:selected').hide();"}
                                                           action={script script="$('#spare_number_selector').get(0).selectedIndex = 0;"}
          %}
          <select id="spare_number_selector" class="form-control margin-bottom-xs" style="text-align:center;" data-live-search="true">
            <option style="text-align:center;"> -- {_ Select number to add _} -- </option>
            {% for spare_number in m.kazoo.get_acc_numbers_info %}
              <option id="option_{{ spare_number|element:1|cleanout }}" name="spare_number" value="{{ spare_number|element:1 }}"
                                           {% if spare_number[2][1]["used_by"] %}style="display:none;"{% else %}style="text-align:center;"{% endif %}>
                {{ spare_number|element:1 }}
              </option>
            {% endfor %}
          </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <ul id="ts_numbers_list" class="list-group">
            {% for did in server[1]["DIDs"][1] %}
              {% include "_ts_number.tpl" ts_number=did|element:1 %}
            {% endfor %}
          </ul>
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
<div class="form-group">
  <div class="row">
    {% wire id="button_save_numbers_list" action={submit target="form_manage_trunk_numbers"} %}
    <div class="col-sm-6">
      <button id="button_save_numbers_list" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save numbers list _}</button>
    </div>
    {% wire id="button_cancel_numbers_list" action={dialog_close} %}
    <div class="col-sm-6">
      <button id="button_cancel_numbers_list" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Cancel _}</button>
    </div>
  </div>
</div>
{% endwith %}
