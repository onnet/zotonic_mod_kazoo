{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#rdid type="click"
        action={toggle target="onbill_periodic_services_widget_opened"}
        action={toggle target="arrow_right_"++#rdid}
        action={toggle target="arrow_down_"++#rdid}
        action={postback postback={trigger_innoui_widget arg="onbill_periodic_services_widget_opened"}
                         delegate="mod_kazoo"
               }
%}
  <span id="arrows_{{ #rdid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #rdid }}"
       style="{% if m.kazoo[{ui_element_opened element="onbill_periodic_services_widget_opened"}] %}
                display: none;
              {% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #rdid }}"
       style="{% if not m.kazoo[{ui_element_opened element="onbill_periodic_services_widget_opened"}] %}
                display: none;
              {% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button id="add_service_btn"
              class="btn btn-xs btn-onnet pull-right"
              text=_"add service"
              action={dialog_open title=_"Add periodic service"
                                  template="_periodic_service.tpl"
                                  account_id=account_id
                     }
    %}
    <i id="show_active_periodic_services_toggler"
       class="fa fa-toggle-{% if m.session.show_periodic_fees == "show_all" %}off{% else %}on{% endif %}
              pointer pull-right"
       style="margin: 0.1em 1em 0 0"></i>
    <span class="pull-right pr-05"> {_ Active only _}: </span>
    {% if m.session.show_periodic_fees == "show_all" %}
      {% wire id="show_active_periodic_services_toggler"
              action={session_set key="show_periodic_fees" value="active_only"}
              action={emit signal={update_onbill_periodic_service signal_filter=m.kazoo.signal_filter}}
      %}
    {% else %}
      {% wire id="show_active_periodic_services_toggler"
              action={session_set key="show_periodic_fees" value="show_all"}
              action={emit signal={update_onbill_periodic_service signal_filter=m.kazoo.signal_filter}}
      %}
    {% endif %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
{% wire action={connect signal={update_onbill_periodic_services_lazy_tpl signal_filter=m.kazoo.signal_filter}
                action={update target="onbill_periodic_services_widget_opened"
                               template="onbill_periodic_services_lazy.tpl"
                               account_id=account_id
                               headline=_"Periodic services"
                       }
               }
%}
<div id="onbill_periodic_services_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="onbill_periodic_services_widget_opened"}] %}
              display: none;
            {% endif %}">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="onbill_periodic_services_widget_opened"
                            template="onbill_periodic_services_lazy.tpl"
                            account_id=account_id
                            headline=_"Periodic services"
                    }
    %}
  </div>
</div>
{% endblock %}
