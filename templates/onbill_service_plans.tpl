{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="onbill_service_plan_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="onbill_service_plan_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="onbill_service_plan_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="onbill_service_plan_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"create" id="add_json_service_plan"
              action={dialog_open title=_"Create new service plan." template="_create_new_service_plan.tpl"}
     %}
    <span id="service_plan_buttons"></span>
    <div class="btn-group pull-right" style="margin-left: 3px;">
      <a class="btn btn-xs btn-onnet dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-calendar"></i>
        {_ select _}
        <span class="caret"></span>
      </a>
      <ul class="dropdown-menu nav-list nav">
       {% wire name="service_plan_edit_event" action={update target="onbill_service_plan_widget_opened"
                                                             template="onbill_service_plan_lazy.tpl"
                                                     }
                                              action={update target="service_plan_buttons"
                                                             template="onbill_service_plans_buttons.tpl"
                                                     }   
                                              action={ show target="onbill_service_plan_widget_opened" }
                                              action={ hide target="arrow_right_"++#dtid }
                                              action={ show target="arrow_down_"++#dtid }
       %}
        {% for service_plan in m.kazoo.kz_service_plans %}
          <li>
            <a href="#" onclick="z_event('service_plan_edit_event', { service_plan_id: '{{ service_plan["id"] }}' });">
                {{ service_plan["name"] }}
            </a>
          </li>
        {% endfor %}
      </ul>
    </div>

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="onbill_service_plan_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="onbill_service_plan_widget_opened"}] %}display: none;{% endif %}">
</div>
{% endblock %}
