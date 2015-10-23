{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_calls_list_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_calls_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" action={postback postback="refresh_admin_callstats" delegate="mod_kazoo" qarg="callstatsdayInput"} text=_"refresh results" %}
     <input id="callstatsdayInput" type="text" class="input-small-onnet pull-right" name="callstatsdayInput"
                                                    value="{% if m.signal[signal].selected_day %}{{ m.signal[signal].selected_day }}{% else %}{{ now|date: 'd/m/Y' }}{% endif %}"
                                                    data-date="{% if m.signal[signal].selected_day %}{{ m.signal[signal].selected_day }}{% else %}{{ now|date: 'd/m/Y' }}{% endif %}"
                                                    data-date-format="dd/mm/yyyy"
                                                    data-date-autoclose="true"
                                                    data-date-language={{ z_language }}
                                                    data-date-start-date="-6m"
                                                    data-date-end-date="+0d"
                                                    readonly/>
    <span class="pull-right pr-05"> {_ Choose day _}: </span>
    {% javascript %}
        $('#callstatsdayInput').datepicker();
    {% endjavascript %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_calls_list_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="ap_calls_list_widget_opened"
                                                                    template="admin_portal_call_history_table.tpl"
                                                                    selected_day=m.signal[signal].selected_day}
        %}
    </div>
</div>
{% endblock %}
