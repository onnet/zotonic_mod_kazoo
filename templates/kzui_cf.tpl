<div class="row">
  <div class="col-xs-2">
    {% wire id="callflow_manager_selector" type="change" action={ postback postback={cf_load}  delegate="mod_kazoo"} %}
    <select id="callflow_manager_selector" name="selected" class="col-xs-12 form-control margin-bottom-xs selectpicker"
                                           style="text-align:center;display: none;" title="-- {_ Select to edit _} --" data-live-search="true">
      {% if not m.session.current_callflow %}
      {% endif %}
      <option value="new">-- {_ Add new Callflow _} --</option>
      {% for option in m.kazoo.kz_list_account_callflows %}
        {% if not option["featurecode"] and ( option["numbers"][1]|match:"^\\+?\\d+$" or option["patterns"][1] ) %}
          <option value="{{ option["id"] }}" {% if m.session.current_callflow[1]["id"] == option["id"] %}selected{% endif %}>
            {% if option["name"] %}{{ option["name"] }}{% elseif option["numbers"][1] %}{{ option["numbers"][1] }}{% else %}{{ option["patterns"][1] }}{% endif %}
          </option>
        {% endif %}
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#callflow_manager_selector').selectpicker({
      style: 'btn-zalarm',
      size: 7
    });
  {% endjavascript %}
  {% wire id="cf_reload_btn" action={confirm text=_"Do you really want to reload this callflow?"
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
  {% wire id="cf_save_btn" action={confirm text=_"Do you really want to save this callflow?"
                                   action={postback postback={cf_save cf="current_callflow"} delegate="mod_kazoo"}
                           }
  %}
  <div class="col-xs-2">
    <button id="cf_save_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
  </div>
  {% wire id="cf_delete_btn" action={confirm text=_"Do you really want to delete this callflow?"
                                     action={postback postback={cf_delete cf="current_callflow"} delegate="mod_kazoo"}
                             } 
  %}
  <div class="col-xs-2">
    <button id="cf_delete_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Delete _}</button>
  </div>
</div>
<div id="callflow_container" style="width:100%!important; padding-top:1em;">
  <div class="callflow-view clearfix">
    <div class="real-content">
      <div id="ws_callflow" class="clearfix">
        {% include "kzui_cf_tools.tpl" %}
        <div class="flowchart">
          <div class="callflow">
            <div>
              <span class="flow">
                <div id="ws_cf_flow">
                  <div class="child">
                    {% droppable id="flow0" tag={drop_args drop_id="flow" drop_parent="root"} delegate="mod_kazoo" %}
                    <div id="flow0" class="branch">
                      <div name="root" class="node">
                        <div class="root">
                          <div class="top_bar">
                            {% wire action={connect signal={update_cf_edit_name signal_filter=m.kazoo.signal_filter}
                                    action={update target="cf_edit_name" template="_cf_name.tpl"}}
                            %}
                            <span id="cf_edit_name" class="name">
                              {% include "_cf_name.tpl" %}
                            </span>
                            {% wire id="cf_edit_name_icon" action={ dialog_open title=_"Edit callflow name" template="_cf_edit_name.tpl" } %}
                            <span id="cf_edit_name_icon" class="edit_icon">
                            </span>
                            <div class="tooltip">
                            </div>
                          </div>
                          {% wire action={connect signal={update_cf_numbers_div signal_filter=m.kazoo.signal_filter}
                                                  action={update target="cf_numbers_div" template="_cf_numbers.tpl"}}
                          %}
                          <div id="cf_numbers_div" class="content">
                              {% include "_cf_numbers.tpl" %}
                          </div>
                        </div>
                      </div>
                      <div id="flow-root" class="children">
                      {% wire action={postback postback={check_children id="flow0" drop_id="flow" drop_parent="root"} delegate="mod_kazoo"} %}
                      </div>
                    </div>
                  </div>
                </div>
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
