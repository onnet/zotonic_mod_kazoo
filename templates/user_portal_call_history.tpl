{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_calls_list_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_calls_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       style="{% if m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="{% if not m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
  <span id="select_range_span"
        class="{% if m.signal[signal].selected_billing_period != "range" %}display_none{% endif %} ml-1">
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh results"
              action={mask target="user_portal_call_history_table" message=_"Sending request"++"..."}
              action={postback postback="refresh_user_callstats"
                               qarg="selected_billing_period"
                               qarg="callstatsdayFrom"
                               qarg="callstatsdayTo"
                               delegate="mod_kazoo"
                     }
    %}
    <input id="callstatsdayTo"
           type="text"
           class="input-small-onnet pull-right"
           name="callstatsdayTo"
           value="{% if m.signal[signal].callstatsdayTo
                  %}{{ m.signal[signal].callstatsdayTo }}{%
                  else
                  %}{{ now|date: 'd/m/Y' }}{% endif %}"
           data-date="{% if m.signal[signal].callstatsdayTo
                      %}{{ m.signal[signal].callstatsdayTo }}{%
                      else
                      %}{{ now|date: 'd/m/Y' }}{% endif %}"
           data-date-format="dd/mm/yyyy"
           data-date-autoclose="true"
           data-date-language={{ z_language }}
           data-date-start-date="-6m"
           data-date-end-date="+1d"
           readonly/>
    <span class="pull-right pr-05 pl-05"> - </span>
    {% javascript %}
      $('#callstatsdayTo').datepicker();
    {% endjavascript %}
    <input id="callstatsdayFrom"
           type="text"
           class="input-small-onnet pull-right ml-1"
           name="callstatsdayFrom"
           value="{% if m.signal[signal].callstatsdayFrom
                  %}{{ m.signal[signal].callstatsdayFrom }}{%
                  else
                  %}{{ now|sub_day|date: 'd/m/Y' }}{% endif %}"
           data-date="{% if m.signal[signal].callstatsdayFrom
                      %}{{ m.signal[signal].callstatsdayFrom }}{%
                      else
                      %}{{ now|sub_day|date: 'd/m/Y' }}{% endif %}"
           data-date-format="dd/mm/yyyy"
           data-date-autoclose="true"
           data-date-language={{ z_language }}
           data-date-start-date="-6m"
           data-date-end-date="+1d"
           readonly/>
    {% javascript %}
      $('#callstatsdayFrom').datepicker();
    {% endjavascript %}
  </span>
  <select id="selected_billing_period"
          name="selected_billing_period"
          data-width="fit"
          data-live-search="true"
          class="btn-xs btn-onnet pull-right pr-1">
    <option value="today"
           {% if m.signal[signal].selected_billing_period == "today" %}
             selected
           {% endif %}>{_ Today _}</option>
    <option value="7_days"
            {% if m.signal[signal].selected_billing_period == "7_days" %}
              selected
            {% endif %}>{_ 7 days _}</option>
    <option value="this_month"
            {% if m.signal[signal].selected_billing_period == "this_month" %}
              selected
            {% endif %}>{_ This month _}</option>
    <option value="range"
            {% if m.signal[signal].selected_billing_period == "range" %}
              selected
            {% endif %}>{_ Range _}</option>
  </select>
  {% wire id="selected_billing_period"
          type="change"
          action={script script="Type = $('#selected_billing_period').val();
                                 if (Type == 'range') {
                                      $('#select_range_span').show();
                                 } else {
                                      $('#select_range_span').hide();
                                      z_event('show_selected_period_cdr');
                                 }"
                 }
  %}
  {% wire name="show_selected_period_cdr" action={postback postback="refresh_user_callstats"
                                                           qarg="selected_billing_period"
                                                           qarg="callstatsdayFrom"
                                                           qarg="callstatsdayTo"
                                                           delegate="mod_kazoo"
                                                 }
  %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_calls_list_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="ap_calls_list_widget_opened"}] %}display: none;{% endif %}">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="ap_calls_list_widget_opened"
                            template="user_portal_call_history_table.tpl"
                            calls=m.kazoo[{list_user_cdr created_from=m.signal[signal].created_from
                                                         created_to=m.signal[signal].created_to
                                         }]
                    }

    %}
  </div>
</div>
{% endblock %}
