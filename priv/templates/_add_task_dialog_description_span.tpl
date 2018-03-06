<div class="form-group">
  <div class="row">
    {% if available_tasks[category][1][q.triggervalue][1]["description"] %}
      <div class="col-sm-12 ml-1">
        <label for="action_description" class="">
          <p>{_ Description _}:</p>
        </label>
        <span id="action_description">
          {{ available_tasks[category][1][q.triggervalue][1]["description"] }}
        </span>
      </div>
    {% endif %}
    {% if available_tasks[category][1][q.triggervalue][1]["doc"] %}
      <div class="col-sm-12 ml-1">
        <label for="action_doc_span">
          <p>{_ Doc _}:</p>
        </label>
        <span id="action_doc_span">
          {{ available_tasks[category][1][q.triggervalue][1]["doc"]|replace:["\\n","<br />"] }}
        </span>
      </div>
    {% endif %}
    {% if available_tasks[category][1][q.triggervalue][1]["expected_content"] %}
      <div class="col-sm-12 mt-1 ml-1">
        <label for="action_expected_content_span">
          <p>{_ Expected Content _}:</p>
        </label>
        <span id="action_expected_content_span">
          {{ available_tasks[category][1][q.triggervalue][1]["expected_content"] }}
        </span>
      </div>
    {% endif %}
    {% if available_tasks[category][1][q.triggervalue][1]["mandatory"] %}
      <div class="col-sm-12 ml-1">
        <label for="action_expected_content_span">
          <p>{_ Mandatory fields _}:</p>
        </label>
          <span id="action_expected_content_span">
          {{ available_tasks[category][1][q.triggervalue][1]["mandatory"] }}
        </span>
      </div>
    {% endif %}
    {% if available_tasks[category][1][q.triggervalue][1]["optional"] %}
      <div class="col-sm-12 ml-1">
        <label for="action_expected_content_span">
          <p>{_ Optional fields _}:</p>
        </label>
        <span id="action_expected_content_span">
          {% for optional_field in  available_tasks[category][1][q.triggervalue][1]["optional"] %}
            {{ optional_field }}{% if not forloop.last %}, {% endif %}
          {% endfor %}
        </span>
      </div>
    {% endif %}
  </div>
</div>
