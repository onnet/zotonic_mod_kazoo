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
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh results"
              action={mask target="admin_portal_call_history_table" message=_"Sending request"++"..."}
              action={postback postback="refresh_admin_callstats" delegate="mod_kazoo" qarg="callstatsdayInput"}
    %}
     <input id="callstatsdayInput" type="text" class="input-small-onnet pull-right" name="callstatsdayInput"
                                                    value="{% if m.signal[signal].selected_day %}{{ m.signal[signal].selected_day }}{% else %}{{ now|date: 'd/m/Y' }}{% endif %}"
                                                    data-date="{% if m.signal[signal].selected_day %}{{ m.signal[signal].selected_day }}{% else %}{{ now|date: 'd/m/Y' }}{% endif %}"
                                                    data-date-format="dd/mm/yyyy"
                                                    data-date-autoclose="true"
                                                    data-date-language={{ z_language }}
                                                    data-date-start-date="-6m"
                                                    data-date-end-date="+1d"
                                                    readonly/>
    <span class="pull-right pr-05"> {_ Choose date _}: </span>
    {% javascript %}
        $('#callstatsdayInput').datepicker();
    {% endjavascript %}
    <i id="show_legs_toggler" class="fa fa-toggle-{% if m.session.show_cdr_legs %}on{% else %}off{% endif %} pointer pull-right" style="margin: 0.1em 1em 0 0"></i>
    {% wire id="show_legs_toggler"
            type="click"
            action={postback postback="toggle_show_legs_status" delegate="mod_kazoo"}
            action={mask target="admin_portal_call_history_table" message=_"Sending request"++"..."}
            action={postback postback="refresh_admin_callstats" delegate="mod_kazoo" qarg="callstatsdayInput"}
    %}
    <span class="pull-right pr-05"> {_ Detailed _}: </span>
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_calls_list_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="ap_calls_list_widget_opened"
                                                                    template="admin_portal_call_history_table.tpl"
                                                                    calls=m.kazoo[{kz_list_account_cdr selected_day=m.signal[signal].selected_day}]
                                                                    selected_day=m.signal[signal].selected_day}
        %}
    </div>
</div>
{% endblock %}
