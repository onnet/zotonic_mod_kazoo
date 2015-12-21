<div class="row" style="padding: 1em; margin-bottom: 1em;">


  <div class="col-xs-2 col-xs-offset-1">
    {# wire id="account_conference_edit_btn" action={ dialog_open title=_"Edit conference " template="_edit_conference_lazy.tpl" conference_id=conference_id width="auto" } #}
   <!-- <button id="account_conference_edit_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Settings _}</button> -->
  </div>
  <div class="col-xs-2">
    <select id="account_list_selector" name="selected_list" class="col-xs-12 form-control margin-bottom-xs selectpicker" title="{_ Participants list _}"  data-live-search="true">
      {% for list in m.kazoo.kz_list_account_lists %}
          <option value="{{ list["id"] }}">{{ list["name"] }}</option>
      {% endfor %}
    </select>
  </div>
  <div class="col-xs-2">
    <select id="callflow_number_selector" name="b_leg_number" class="col-xs-12 form-control margin-bottom-xs selectpicker" title="{_ Select Callflow _}"  data-live-search="true">
      {% for callflow in m.kazoo[{kz_list_account_callflows filter=conference_id}] %}
          <option value="{{ callflow["numbers"][1] }}">
            {% if callflow["name"] %}{{ callflow["name"] }}{% elseif callflow["numbers"][1] %}{{ callflow["numbers"][1] }}{% else %}{{ callflow["patterns"][1] }}{% endif %}
          </option>
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#account_list_selector').selectpicker({
      style: 'btn-zprimary',
      size: 5
    });
    $('#callflow_number_selector').selectpicker({
      style: 'btn-zprimary',
      size: 5
    });
  {% endjavascript %}

  <div class="col-xs-2">
    <button id="start_conference_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Start _}</button>
  </div>
  {% wire id="start_conference_btn" action={confirm text="Do you really want to start conference?"
                                     action={postback postback={start_outbound_conference conference_id=conference_id} qarg="account_list_selector" qarg="callflow_number_selector" delegate="mod_kazoo"}
                             }
  %}
</div>

<div class="pl-10 pr-10 col-md-6 col-md-offset-3">

  {% wire action={connect signal={update_conference_participants_tpl} action={update target="conference_participants_tpl"
                                                                                  template="_conference_participants.tpl"
                                                                                  headline=_"Current participants"
                                                                                  conference_id=conference_id}}
  %}
  {% wire name="update_conference_participants" action={emit signal={update_conference_participants_tpl}} %}
  <span id="conference_participants_tpl">
        {% include "_conference_participants.tpl" headline=_"Current participants" conference_id=conference_id %}
  </span>

</div>
<div class="pl-10 pr-10 col-md-6">
</div>
