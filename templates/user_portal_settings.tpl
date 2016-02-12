{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="user_settings_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ toggle target="btn_"++#dtid }
        action={ toggle target="pwdbtn_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="user_settings_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="user_settings_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="user_settings_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% if not m.kazoo[{ui_element_opened element="user_settings_widget_opened"}] %}
        {% button id="btn_"++#dtid class="btn btn-xs btn-onnet pull-right display_none" text=_"submit" action={submit target="user_settings_form_form"} %}
        {% button id="pwdbtn_"++#dtid class="btn btn-xs btn-onnet pull-right display_none" text=_"change password"
                                      action={dialog_open title=_"Change password" template="_change_user_password.tpl"} %}
    {% else %}
        {% button id="btn_"++#dtid class="btn btn-xs btn-onnet pull-right" text=_"submit" action={submit target="user_settings_form_form"} %}
        {% button id="pwdbtn_"++#dtid class="btn btn-xs btn-onnet pull-right" text=_"change password"
                                      action={dialog_open title=_"Change password" template="_change_user_password.tpl"} %}
    {% endif %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}

<div id="user_settings_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="user_settings_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="user_settings_widget_opened"
                                                                    template="user_portal_settings_lazy.tpl"
                                                                    headline=_"Settings"}
        %}
    </div>
</div>

{% endblock %}
