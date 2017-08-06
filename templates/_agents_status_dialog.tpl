<div class="row row-centered">
  {% for agent in m.kazoo[{agents account_id=account_id}] %}
    {% include "_agents_status_dialog_element.tpl"
               agent_id=agent[1]["id"]
               account_id=account_id
               first_name=agent[1]["first_name"]
               last_name=agent[1]["last_name"]
    %}
  {% endfor %}
</div>
{% wire id="refresh_agents_status_dialog"
        action={replace target="agents_status_dialog"
                        template="_agents_status_dialog_lazy.tpl"
                        conference_id=conference_id
               }
%}
