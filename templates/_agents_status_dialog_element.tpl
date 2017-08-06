    {% with m.kazoo[{agents_status agent_id=agent[1]["id"] account_id=account_id}] as astatus %}
      <div class="col-xs-3 col-centered">
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
            {% if astatus == "ready" %}
              <i id="logout_{{ agent[1]["id"] }}"
                 class="fa fa-stop pointer zprimary pl-1"
                 title="{_ Logout _}"></i>
              {% wire id="logout_"++agent[1]["id"]
                      action={postback postback={logout_agent agent_id=agent[1]["id"]}
                                       delegate="mod_kazoo"
                             }
              %}
            {% elif astatus == "logged_out" %}
              <i id="login_{{ agent[1]["id"] }}"
                 class="fa fa-play pointer zalarm pl-1"
                 title="{_ Login _}"></i>
              {% wire id="login_"++agent[1]["id"]
                      action={postback postback={login_agent agent_id=agent[1]["id"]}
                                       delegate="mod_kazoo"
                             }
              %}
            {% else %}
              <i id="unknown_{{ agent[1]["id"] }}"
                 class="fa fa-play pointer pl-1"
                 title="{_ Login _}"></i>
              {% wire id="unknown_"++agent[1]["id"]
                      action={postback postback={login_agent agent_id=agent[1]["id"]}
                                       delegate="mod_kazoo"
                             }
              %}
            {% endif %}
          </div>
        </div>
      </div>
    {% endwith %}
