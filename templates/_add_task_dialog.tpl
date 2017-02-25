{% with m.kazoo.all_tasks[1]["tasks"][1] as available_tasks %}
  {% wire id="form_add_task" type="submit" postback="add_new_task" delegate="mod_kazoo" %}
  <form id="form_add_task" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">{_ Select job category _}
            {% wire id="task_category"
                    type="change"
                    action={update target="task_action_select_span"
                                   template="_add_task_dialog_action_select.tpl"
                                   available_tasks=available_tasks
                           }
            %}
            <select id="task_category"
                    name="task_category"
                    class="form-control margin-bottom-xs"
                    style="text-align:center;"
                    data-live-search="true">
                <option value="">-- {_ Chose category _} --</option>
                {% for available_task in available_tasks %}
                  <option value="{{ available_task[1] }}">
                    {{ available_task[1] }}
                  </option>
                {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-4">
            <span id="task_action_select_span">
              {% include "_add_task_dialog_action_select.tpl" %}
            </span>
        </div>
        <div class="col-sm-4">
            <span id="task_input_upload_field_span">
              {% include "_add_task_dialog_input_upload_field.tpl" %}
            </span>
        </div>
      </div>
    </div>
    <span id="task_description_span">
      {% include "_add_task_dialog_description_span.tpl" %}
    </span>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Add task for pending _}</button>
        </div>
      </div>
    </div>
  </form>
{% endwith %}
