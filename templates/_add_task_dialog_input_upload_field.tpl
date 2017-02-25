{% if available_tasks[category][1][q.triggervalue][1]["expected_content"] %}
          <label class="form-control-onnet margin-bottom-xs">
            {_ Select file _}
            <input id="tasktfile"
                   type="file"
                   name="taskfile"
                   accept="text/csv" 
                   class="form-control margin-bottom-xs"
                   onchange="this.style.width = '100%';">
          </label>
{% endif %}
