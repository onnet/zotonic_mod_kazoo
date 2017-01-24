{% with m.kazoo.kz_get_acc_doc as account_doc %}
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th width="55%">{_ Account status _}</th>
      <th>
        {% if account_doc[1]["enabled"] %}
          <span class="zprimary">
            {% if account_doc[1]["trial_time_left"] %}
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
                                            one_button_only="true"
                               }
                %}
            {% else %}
              {_ Active _}
            {% endif %}
          </span>
        {% else %}
          <span class="zalarm">{_ Blocked _}</span>
        {% endif %}
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>{_ Current balance _}</td>
      <td>{% include "_current_account_credit.tpl" %}</td>
    </tr>
    {% wire type={mqtt topic="~site/public/hello"} action={growl text="hello"} %}
  </tbody>
</table>
{% endwith %}
