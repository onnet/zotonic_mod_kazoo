<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <th colspan="3">
        {_ Opening balance _}
        <span style="float:right; padding-right:2em;">
          {% with m.kazoo[{kz_list_transactions account_id=account_id
                                                selected_billing_period=selected_billing_period
                                                type="monthly_recurring"
                         }]
             as rollup_doc
          %}
            {% if rollup_doc[1]["type"] == "debit" %}
              {{ (rollup_doc[1]["amount"] * (-1))|currency_sign }}
            {% else %}
              {{ rollup_doc[1]["amount"]|currency_sign }}
            {% endif %}
          {% endwith %}
        </span>
      </th>
    </tr>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

{% include  "rs_widget_payments_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

{% include  "rs_widget_monthly_fees_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

{% include  "rs_widget_per_minute_calls_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    <tr>
      <th colspan="3">
        {% print selected_billing_period|split:","|last|inno_timestamp_expired %} 
        {% if selected_billing_period|split:","|last|inno_timestamp_expired == "expired" %} 
          {_ Closing balance _}
          <span style="float:right; padding-right:2em;">
            {{ m.kazoo[{kz_list_transactions account_id=account_id
                                             selected_billing_period=selected_billing_period
                                             type="next_monthly_recurring"
                      }]|currency_sign
            }}
          </span>
        {% else %}
          {_ Current balance _}
          <span style="float:right; padding-right:2em;">
            {% include "_current_child_account_credit.tpl" %}
          </span>
        {% endif %}
      </th>
    </tr>
  </thead>
</table>
