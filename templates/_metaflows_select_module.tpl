{% if q.triggervalue %}
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4 col-sm-offset-2">
    {% wire id="task_action"
            type="change"
            action={update target="task_description_span"
                           template="_add_task_dialog_description_span.tpl"
                           available_tasks=available_tasks
                           category=q.triggervalue
                   }
            action={update target="task_input_upload_field_span"
                           template="_add_task_dialog_input_upload_field.tpl"
                           available_tasks=available_tasks
                           category=q.triggervalue
                   }
    %}
    <select id="task_action"
            name="task_action"
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
    <div id="add_captures_button_div" class="form-group">
      <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                    text=_"Commit capture"
                    action={slide_down target="add_captures_div"}
                    action={slide_up target="add_captures_button_div"}
          %}
        </div>
      </div>
    </div>
{% endif %}
