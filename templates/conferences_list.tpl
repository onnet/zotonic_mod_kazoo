<div class="row" style="margin-top: 2em; margin-bottom: 1em;">
  <div class="col-xs-2 col-xs-offset-1">
  </div>
  <div class="col-xs-2">
    {% wire id="conference_selector" type="change" action={postback postback="conference_selected" delegate="mod_kazoo"} %}
    <select id="conference_selector" name="b_leg_number" class="col-xs-12 form-control margin-bottom-xs selectpicker" style="text-align:center;display: none;"
                                title=" -- {_ Conferences _} -- " data-live-search="true">
      {% for option in m.kazoo.kz_list_account_conferences %}
          <option value="{{ option["id"] }}" {% if option["id"] == conference_id %}selected{% endif %}>
            {{ option["name"] }}
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
  <div class="col-xs-2">
    <select id="account_list_selector" name="selected_list" class="col-xs-12 form-control margin-bottom-xs selectpicker" title="{_ Participants list _}"  data-live-search="true">
      {% for list in m.kazoo.kz_list_account_lists %}
          <option value="{{ list["id"] }}">{{ list["name"] }}</option>
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#account_list_selector').selectpicker({
      style: 'btn-zprimary',
      size: 5
    });
  {% endjavascript %}
  {% wire id="start_conference_btn" action={confirm text="Do you really want to start conference?"
                                            action={postback postback={start_outbound_conference conference_id=conference_id}
                                                             qarg="account_list_selector"
                                                             qarg="conference_selector"
                                                             delegate="mod_kazoo"
                                                   }
                                           }
  %}
  <div class="col-xs-2">
    <button id="start_conference_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Start _}</button>
  </div>
</div>

<div id="child_sandbox" class="row">
{% if conference_id %}
  {% include "conference_info.tpl" conference_id=conference_id %}
{% endif %}
</div>
