{% with m.kazoo[{kz_get_subscription subscription_id=transaction["subscription_id"] account_id=account_id}] as subscription %}

<div class="">
  <table class="table table-hover table-centered">
   <body>
    <tr class="trans-list">
      <td class="trans-h">First Bill Date</td>
      <td class="trans-t">{{ subscription[1]["billing_first_date"]|inno_timestamp_to_date|date:"Y-m-d" }}</td>
    </tr>
    <tr class="trans-list">
      <td class="trans-h">Current Billing Period</td>
      <td class="trans-t">
         {{ subscription[1]["billing_start_date"]|inno_timestamp_to_date|date:"Y-m-d" }}
         – 
         {{ subscription[1]["billing_end_date"]|inno_timestamp_to_date|date:"Y-m-d" }}
      </td>
    </tr>
    <tr class="trans-list">
      <td class="trans-h">Next Bill Date</td>
      <td class="trans-t">{{ subscription[1]["next_bill_date"]|inno_timestamp_to_date|date:"Y-m-d" }}</td>
    </tr>
    <tr class="trans-list">
      <td class="trans-h">Next Billing Period Amount</td>
      <td class="trans-t">{{ m.config.mod_kazoo.local_currency_sign.value }}{{ subscription[1]["next_bill_amount"] }}</td>
    </tr>
   </body>
  </table>
</div>

    {# print transaction #}
    {# print subscription[1] #}

{% endwith %}

