{% if q.triggervalue %}
  <label class="form-control-onnet margin-bottom-xs">{_ Select action _}
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
        <option value="">-- {_ Chose category _} --</option>
        {% for action in available_tasks[q.triggervalue][1] %}
          <option value="{{ action[1] }}">
            {{ action[1] }}
          </option>
        {% endfor %}
    </select>
  </label>
{% endif %}
