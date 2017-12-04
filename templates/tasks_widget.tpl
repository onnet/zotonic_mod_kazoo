{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={toggle target="tasks_widget_opened"}
        action={toggle target="arrow_right_"++#id}
        action={toggle target="arrow_down_"++#id}
        action={postback postback={trigger_innoui_widget arg="tasks_widget_opened"}
                         delegate="mod_kazoo"
               }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}"
       style="{% if m.kazoo[{ui_element_opened element="tasks_widget_opened"}] %}
                display: none;
              {% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}"
       style="{% if not m.kazoo[{ui_element_opened element="tasks_widget_opened"}] %}
                display: none;
              {% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {% wire action={connect signal={refresh_tasks_widget_signal signal_filter=m.kazoo.signal_filter}
                          action={update target="tasks_widget_tpl"
                                         template="tasks_widget.tpl"
                                         headline=_"Background jobs"
                                 }
                 }
  %}
  {% button class="btn btn-xs btn-onnet pull-right"
            text=_"refresh"
            action={emit signal={refresh_tasks_widget_signal signal_filter=m.kazoo.signal_filter}}
  %}
  {% button class="btn btn-xs btn-onnet pull-right"
            text=_"add task"
            action={dialog_open title=_"Add background job"
                                template="_add_task_dialog.tpl"
                                width="auto"
                   }
  %}
  {{ headline }}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="tasks_widget_opened"
     style='{% if not m.kazoo[{ui_element_opened element="tasks_widget_opened"}] %}
              display: none;
            {% endif %}'>
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="tasks_widget_opened"
                            template="tasks_table_body.tpl"
                    }
    %}
  </div>
</div>
{% endblock %}
