{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="rs_payments_list_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="rs_payments_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       style="{% if m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="{% if not m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% wire id="selected_billing_period"
            type="change"
            action={postback postback={refresh_rs_payments_list account_id}
                             delegate="mod_kazoo"
                             qarg="selected_billing_period"
                             inject_args account_id=account_id
                   }
    %}
    <select id="selected_billing_period"
            name="selected_billing_period"
            data-width="fit"
            data-live-search="true"
            class="pull-right">
      {% for billing_period in m.onbill[{billing_periods account_id=account_id}] %}
        <option value="{{ billing_period["period_start"][1]["day_begins_ts"]
                        }},{{
                          billing_period["period_end"][1]["day_ends_ts"] }}"
                {% if selected_billing_period|split:","|first == billing_period["period_start"][1]["day_begins_ts"] %}
                  selected
                {% endif %}>
          {% if billing_period["period_start"][1]["billing_day"] == 1 %}
            {{ billing_period["period_start"][1]["month_short"] }}
            {{ billing_period["period_start"][1]["year"] }}
          {% else %}
            {{ billing_period["period_start"][1]["day"]
             }} {{
               billing_period["period_start"][1]["month_short"]
             }} {{
               billing_period["period_start"][1]["year"]
             }} - {{
               billing_period["period_end"][1]["day"]
             }} {{
               billing_period["period_end"][1]["month_short"]
             }} {{
               billing_period["period_end"][1]["year"] }}
          {% endif %}
        </option>
      {% endfor %}
    </select>
  {% javascript %}
    $('#selected_billing_period').selectpicker({
      style: 'btn-xs btn-onnet',
      size: 4
    });
  {% endjavascript %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_payments_list_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="rs_payments_list_widget_opened"
                                template="rs_widget_transactions_list_table.tpl"
                                account_id=account_id
                                selected_billing_period=selected_billing_period
                                transactions=transactions
                                headline=_"Transactions list"
                        }
        %}
   </div>
</div>
{% endblock %}
