{% if q.triggervalue %}
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4 col-sm-offset-2">
        {% wire id="metaflows_module"
                type="change"
                action={slide_down target="commit_cancel_captures_button_div"}
                action={slide_up target="cancel_captures_button_div"}
        %}
        <select id="metaflows_module"
                name="metaflows_module"
                class="form-control margin-bottom-xs"
                style="text-align:center;"
                data-live-search="true">
            <option value="">-- {_ Chose module _} --</option>
            {% if q.triggervalue == "patterns" %}
              <option value="callflow">{_ Callflow _}</option>
              <option value="transfer">{_ Transfer _}</option>
            {% elseif q.triggervalue == "numbers" %}
              <option value="hold">{_ Hold _}</option>
            {% endif %}
        </select>
      </div>
    </div>
  </div>
  <div id="commit_cancel_captures_button_div" class="form-group display_none">
    <div class="row">
      <div class="col-sm-4 col-sm-offset-2">
        {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs"
                  text=_"Commit capture"
                  type="submit"
        %}
      </div>
      <div class="col-sm-4">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Cancel"
                  action={update target="metaflows_capture_add_span"
                                 template="_metaflows_capture_add.tpl"
                         }
        %}
      </div>
    </div>
  </div>
  <div id="cancel_captures_button_div" class="form-group display_none1">
    <div class="row">
      <div class="col-sm-8 col-sm-offset-2">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Cancel"
                  action={update target="metaflows_capture_add_span"
                                 template="_metaflows_capture_add.tpl"
                         }
        %}
      </div>
    </div>
  </div>
{% endif %}
