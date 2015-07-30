{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrow_right_"++#dtid type="click"
        action={update target="send_fax_widget_opened" template="_send_fax_tbody.tpl"}
        action={ show target="send_fax_widget_opened" }
        action={ hide target="arrow_right_"++#dtid }
        action={ show target="arrow_down_"++#dtid }
        action={ show target="send_fax_button" }
        action={ show target="show_fax_list" }
        action={ postback postback={trigger_innoui_widget arg="send_fax_widget_opened" } delegate="mod_kazoo" }
%}
{% wire id="arrow_down_"++#dtid type="click"
        action={ hide target="send_fax_widget_opened" }
        action={ show target="arrow_right_"++#dtid }
        action={ hide target="arrow_down_"++#dtid }
        action={ hide target="send_fax_button" }
        action={ hide target="show_fax_list" }
        action={ hide target="refresh_fax_list" }
        action={ hide target="return_to_send_fax" }
        action={ postback postback={trigger_innoui_widget arg="send_fax_widget_opened" } delegate="mod_kazoo" }
%}
    <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
        <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="send_fax_widget_opened"}] %}display: none;{% endif %}" 
                                        class="arrowpad fa fa-arrow-circle-right"></i>
        <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="send_fax_widget_opened"}] %}display: none;{% endif %}" 
                                       class="arrowpad fa fa-arrow-circle-down"></i>
    </span>
    {{ headline }}
    {% button id="send_fax_button" class="btn btn-xs btn-onnet pull-right display_none" text=_"submit fax"
              action={submit target="send-fax-form"}
    %}
    {% button id="show_fax_list" class="btn btn-xs btn-onnet pull-right display_none" text=_"show sent faxes" 
              action={update target="send_fax_widget_opened" template="_outgoing_faxes_tbody.tpl"}
              action={ toggle target="send_fax_button" }
              action={ toggle target="show_fax_list" }
              action={ toggle target="return_to_send_fax" }
              action={ toggle target="refresh_fax_list" }
    %}
    {% button id="return_to_send_fax" class="btn btn-xs btn-onnet pull-right display_none" text=_"send fax" 
              action={update target="send_fax_widget_opened" template="_send_fax_tbody.tpl"}
              action={ toggle target="send_fax_button" }
              action={ toggle target="show_fax_list" }
              action={ toggle target="return_to_send_fax" }
              action={ toggle target="refresh_fax_list" }
    %}
    {% button id="refresh_fax_list" class="btn btn-xs btn-onnet pull-right display_none" text=_"refresh" 
              action={update target="send_fax_widget_opened" template="_outgoing_faxes_tbody.tpl"}
    %}

{% endblock %}

{% block widget_content %}
            
<div id="send_fax_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="send_fax_widget_opened"}] %}display: none;{% endif %}">
    {% include "_send_fax_tbody.tpl" %}
</div>
            
{% endblock %}
