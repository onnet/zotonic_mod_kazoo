<div class="row">
  {% for agent in m.kazoo[{agents account_id=account_id}] %}
    {% with m.kazoo[{agents_status agent_id=agent[1]["id"] account_id=account_id}] as astatus %}
      {# print agent #}
      {# print m.kazoo[{agents_status agent_id=agent[1]["id"] account_id=account_id}] #}
      <div class="col-xs-3">
        <div class="panel
                    {% if astatus == "ready" %}
                      panel-zprimary
                    {% elif astatus == "logged_out" %}
                      panel-zalarm
                    {% else %}
                      panel-info
                    {% endif %}
                    ">
          <div class="panel-heading text-center">
            {{ agent[1]["first_name"] }}
            {{ agent[1]["last_name"] }}
          </div>
          <div class="panel-body text-center">
            {{ astatus }}
          </div>
        </div>
      </div>
    {% endwith %}
  {% endfor %}
</div>
