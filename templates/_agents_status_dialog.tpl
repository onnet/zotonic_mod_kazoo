<div class="row row-centered">
  {% for agent in m.kazoo[{agents account_id=account_id}] %}
    {% include "_agents_status_dialog_element.tpl"
               agent=agent
               account_id=account_id
    %}
  {% endfor %}
</div>
{% wire id="refresh_agents_status_dialog"
        action={replace target="agents_status_dialog"
                        template="_agents_status_dialog_lazy.tpl"
                        conference_id=conference_id
               }
%}
