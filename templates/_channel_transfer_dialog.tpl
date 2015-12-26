    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <select id="callflow_select" name="target" class="col-xs-12 form-control margin-bottom-xs" title="{_ Select Callflow _}"  data-live-search="true">
            {% for callflow in m.kazoo.kz_list_account_callflows %}
                <option value="{{ callflow["numbers"][1] }}">
                  {% if callflow["name"] %}{{ callflow["name"] }}{% elseif callflow["numbers"][1] %}{{ callflow["numbers"][1] }}{% else %}{{ callflow["patterns"][1] }}{% endif %}
                </option>
            {% endfor %}
          </select>
        </div>
        <div class="col-sm-4">
          {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Transfer" action={postback postback={channel_transfer channel_id=channel_id}
                                                                                                       qarg="callflow_select"
                                                                                                       delegate="mod_kazoo"
                                                                                             }
          %}
        </div>
        <div class="col-sm-4">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
        </div>
      </div>
    </div>
