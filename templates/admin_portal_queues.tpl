{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={toggle target="ap_queues_widget_opened"}
        action={toggle target="arrow_right_"++#dtid}
        action={toggle target="arrow_down_"++#dtid}
        action={postback postback={trigger_innoui_widget arg="ap_queues_widget_opened"}
                         delegate="mod_kazoo"
               }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       style="{% if m.kazoo[{ui_element_opened element="ap_queues_widget_opened"}] %}
                display: none;
              {% endif %}"
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="{% if not m.kazoo[{ui_element_opened element="ap_queues_widget_opened"}] %}
                display: none;
              {% endif %}"
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}

         <span style="padding-left: 3em;">
            {_ max connect failures _}:
         </span>
         <span id="max_connect_failures">
            {% include "_show_field.tpl" type="account"
                                         doc_id="_no_need_"
                                         field_name=["max_connect_failures"]
                                         width="4em"
                                         convert_macro="TO_INT"
            %}
         </span>



    {% button class="btn btn-xs btn-onnet pull-right"
              text=_"add queue"
              action={dialog_open title=_"Add queue"
                                  template="_edit_queue_dialog.tpl"
                                  width="auto"
                     }
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_queues_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="ap_queues_widget_opened"}] %}
              display: none;
            {% endif %}">
  <div class="text-center p-3">
      {% ilazy class="fa fa-spinner fa-spin fa-3x"
               action={update target="ap_queues_widget_opened"
                              template="admin_portal_queues_table.tpl"
                      }
      %}
  </div>
</div>
{% endblock %}
