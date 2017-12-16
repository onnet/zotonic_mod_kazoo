{# print candidates #}
<table class="table table-condensed table-centered">
  <thead>
    {% for candidate in candidates %}
      <tr>
        <th width="15%">
          {{ m.notifier.first[{account_balance account_id=candidate[1]["id"]}]|currency_sign }}
        </th>
        <th width="70%">
          {{ candidate[1]["name"] }}
        </th>
        <th width="15%">
          <span style="float:right;">
            {% button class="btn btn-xs btn-onnet pull-right"
                      text=_"add credit"
                      action={dialog_open title=_"Add credit to"++" "++candidate[1]["name"]
                                          template="_rs_add_credit.tpl"
                                          account_id=candidate[1]["id"]}
            %}
          </span>
        </th>
      </tr>
    {% endfor %}
  </thead>
</table>