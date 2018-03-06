{% with m.kazoo[{period_balance account_id=account_id selected_billing_period=selected_billing_period}] as period_balance %}
<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <th colspan="3">
        {_ Opening balance _}
        <span style="float:right; padding-right:2em;">
          {{ period_balance[1]["opening_balance"]|currency_sign }}
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
  </thead>
</table>

{% include  "rs_widget_related_documents_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <th colspan="3">
        {% if selected_billing_period|split:","|last|inno_timestamp_expired == "expired" %} 
          {_ Closing balance _}
          <span style="float:right; padding-right:2em;">
            {{ period_balance[1]["closing_balance"]|currency_sign }}
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

{% endwith %}
