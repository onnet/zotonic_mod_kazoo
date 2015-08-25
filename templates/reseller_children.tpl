<div class="row text-center" style="padding-right: 195px;">
<h3>Reseller Portal</h3>
</div>
<div class="row" style="padding: 1em;">
  <div class="col-xs-2">
    {% wire id="child_selector" type="change" action={ update template="reseller_child_info.tpl" target="child_sandbox"} %}
    <select id="child_selector" name="selected" class="col-xs-12 form-control margin-bottom-xs selectpicker" style="text-align:center;display: none;" data-live-search="true">
      <option value="">-- {_ Select to edit _} --</option>
      <option value="new">-- {_ Add new account _} --</option>
      {% for option in m.kazoo.kz_list_account_children %}
          <option value="{{ option["id"] }}">
            {{ option["name"] }}
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
  {% wire id="cf_reload_btn" action={confirm text="Do you really want to reload this callflow?"
                                   action={postback postback={cf_reload cf="current_callflow"} delegate="mod_kazoo"}
                           }
  %}
  <div class="col-xs-2">
    <button id="cf_reload_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Reload _}</button>
  </div>
  {% wire id="cf_details_btn" action={ dialog_open title=_"Callflow details" template="_cf_current_callflow_details.tpl" class="iamclass" width="auto" } %}
  <div class="col-xs-2">
    <button id="cf_details_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Details _}</button>
  </div>
  {% wire id="cf_save_btn" action={confirm text="Do you really want to save this callflow?"
                                   action={postback postback={cf_save cf="current_callflow"} delegate="mod_kazoo"}
                           }
  %}
  <div class="col-xs-2">
    <button id="cf_save_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
  </div>
  {% wire id="cf_delete_btn" action={confirm text="Do you really want to delete this callflow?"
                                     action={postback postback={cf_delete cf="current_callflow"} delegate="mod_kazoo"}
                             } 
  %}
  <div class="col-xs-2">
    <button id="cf_delete_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Delete _}</button>
  </div>
</div>

<div id="child_sandbox" class="row">
</div>

{% print  m.kazoo.kz_list_account_children %}
