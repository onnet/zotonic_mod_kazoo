{% with m.kazoo[{services_status account_id=account_id}],
        m.kazoo.kz_get_acc_doc
        as
        billing_status,
        account_doc
%}
<table class="table table-condensed table-centered">
  <tbody>
    <tr>
      <th width="50%">
        {_ Account status _}
      </th>
      <th>
        {% if account_doc[1]["trial_time_left"] %}
          <span class="zprimary">
            {_ Trial _}
            <small>
              ({{ (account_doc[1]["trial_time_left"]/60/60/24)|to_integer }} {_ days left _})
            </small>
            <i id="info_trial_open_dialog"
               class="fa fa-info-circle pointer pull-right pr-1"
               style="padding-top: 0.2em;"
               title="Trial conditions info"></i>
            {% wire id="info_trial_open_dialog"
                    action={dialog_open title=_"Trial subscription terms and conditions"
                                        template="_trial_mode_restrictions.tpl"
                           }
            %}
          </span>
        {% else %}
          {% if billing_status[1]["in_good_standing"] %}
            <span class="zprimary">{_ Good standing _}</span>
          {% else %}
            {% if billing_status[1]["reason"] == "administratively_convicted" %}
              <span class="zalarm">{_ Administratively disabled _}</span>
            {% else %}
              <span class="zalarm">{_ Insufficient Funds _}</span>
            {% endif %}
          {% endif %}
        {% endif %}
      </th>
    </tr>
    <tr>
      <th>
        {_ Current balance _}
      </th>
      <th class="bold {% if billing_status[1]["in_good_standing"] %}zprimary{% else %}zalarm{% endif %}">
        {% include "_current_account_credit.tpl" %}
      </th>
    </tr>
  </tbody>
</table>
{% endwith %}

