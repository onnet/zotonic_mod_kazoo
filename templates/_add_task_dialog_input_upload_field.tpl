{% if available_tasks[category][1][q.triggervalue][1]["expected_content"] == "text/csv" %}
          <label class="form-control-onnet margin-bottom-xs">
            {_ Select file _}
            <input id="task_args"
                   type="file"
                   name="task_args"
                   accept="text/csv" 
                   class="form-control margin-bottom-xs"
                   onchange="this.style.width = '100%';">
          </label>
{% elif available_tasks[category][1][q.triggervalue][1]["expected_content"] == "application/json" %}
          <label class="form-control-onnet margin-bottom-xs">
            {_ Select date _}
            <input id="task_args"
                   type="text"
                   class="form-control margin-bottom-xs"
                   name="task_args"
                   value="{{ now|sub_day|date: 'd/m/Y' }}"
                   data-date="{{ now|sub_day|date: 'd/m/Y' }}"
                   data-date-format="dd/mm/yyyy"
                   data-date-autoclose="true"
                   data-date-language={{ z_language }}
                   data-date-start-date="-6m"
                   data-date-end-date="-1d"
                   readonly/>
            {% javascript %}
              $('#task_args').datepicker();
            {% endjavascript %}
          </label>
{% endif %}
