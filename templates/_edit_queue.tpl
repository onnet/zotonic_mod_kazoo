{# print m.kazoo[{queue queue_id=queue_id account_id=account_id}] #}
{# print m.kazoo[{queue_roster queue_id=queue_id account_id=account_id}] #}

<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li id="basic_li" class="active pointer">
    <a href="#tab_content" role="tab" data-toggle="tab">
      {_ Basic _}
    </a>
  </li>
  {% if queue_id %}
    <li id="agentssettings_li">
      <a href="#tab_content" role="tab" data-toggle="tab">
        {_ Agents _}
      </a>
    </li>
  {% endif %}
</ul>

{% wire id="basic_li"
        type="click"
        action={add_class class="active" target="basic_li"}
        action={remove_class class="active" target="agentssettings_li"}
        action={update target="tab_content"
                       template="_edit_queue_dialog.tpl"
                       queue_id=queue_id
               }
%}

{% wire id="agentssettings_li"
        type="click"
        action={add_class class="active" target="agentssettings_li"}
        action={remove_class class="active" target="basic_li"}
        action={update target="tab_content"
                       template="_edit_queue_agents.tpl"
                       queue_id=queue_id
               }
%}

<div class="tab-content">
  <div class="active tab-pane fade in" id="tab_content">
    <div class="text-center">
      {% ilazy  class="fa fa-spinner fa-spin fa-3x"
                action={update target="tab_content"
                               template="_edit_queue_dialog.tpl"
                               queue_id=queue_id
                       }
      %}
    </div>
  </div>
</div>
</div>
