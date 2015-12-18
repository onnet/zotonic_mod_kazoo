{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="conference_participants_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="conference_participants_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="conference_participants_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="conference_participants_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh" action={emit signal={update_conference_participants_tpl} } %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"add participant" id="addconfparticipantbtn"
                         action={confirm text=_"Do you really want to add participant"++"?"
                              action={postback postback={add_conf_participant conference_id=conference_id} qarg="a_leg_number" qarg="callflow_number_selector" delegate="mod_kazoo"}
                         }
    %}
    <input id="a_leg_number" class="input input-number-onnet pull-right" type="text" name="a_leg_number" placeholder="{{ m.config.mod_kazoo.placeholder_phone.value }}" maxlength="12">
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="conference_participants_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="conference_participants_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="conference_participants_widget_opened"
                                                                    template="_conference_participants_table.tpl" conference_id=conference_id}
        %}
    </div>
</div>

{% endblock %}
