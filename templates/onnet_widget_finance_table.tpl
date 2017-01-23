<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th>{_ Account status _}</th>
      <th>
        {% if m.kazoo[{kz_account_doc_field field1="enabled"}] %}
          <span class="zprimary">
            {% if m.session.kazoo_account_trial %}
              {_ Trial _}
              <small>
                ({{ (m.session.kazoo_account_trial_time_left/60/60/24)|to_integer }} {_ days left _})
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
