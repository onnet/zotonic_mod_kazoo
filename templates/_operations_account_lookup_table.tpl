{# print candidates #}
{% if candidates|length == 0 %}
<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <td colspan="3"> No accounts found </td>
    </tr>
  </thead>
</table>
{% elif candidates|length < 10 %}
<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;">
      <td colspan="3"></td>
    </tr>
    {% for candidate in candidates %}
      <tr>
        <th width="15%" style="vertical-align: middle;">
          {{ m.notifier.first[{account_balance account_id=candidate[1]["id"]}]|currency_sign }}
        </th>
        <th width="70%">
          <a id="link_{{ candidate[1]["id"] }}" href="#">{{ candidate[1]["name"] }}</a>
          {% wire id="link_"++candidate[1]["id"]
                  action={postback postback={redirect_to_reseller_portal account_id=candidate[1]["id"]}
                                   delegate="mod_kazoo"
                         }
          %}
        </th>
        <th width="15%" style="vertical-align: middle;">
          <span style="float:right;">
            {% button class="btn btn-xs btn-onnet pull-right"
                      text=_"add credit"
                      action={dialog_open title=candidate[1]["name"]
                                          template="_rs_add_credit.tpl"
                                          account_id=candidate[1]["id"]}
            %}
          </span>
        </th>
      </tr>
    {% endfor %}
  </thead>
</table>
{% elif candidates|length < 100 %}
<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;">
      <td colspan="2"></td>
    </tr>
    {% for candidate in candidates %}
      <tr>
        <th width="70%">
          <a id="link_{{ candidate[1]["id"] }}" href="#">{{ candidate[1]["name"] }}</a>
          {% wire id="link_"++candidate[1]["id"]
                  action={postback postback={redirect_to_reseller_portal account_id=candidate[1]["id"]}
                                   delegate="mod_kazoo"
                         }
          %}
        </th>
        <th width="15%" style="vertical-align: middle;">
          <span style="float:right;">
            {% button class="btn btn-xs btn-onnet pull-right"
                      text=_"add credit"
                      action={dialog_open title=candidate[1]["name"]
                                          template="_rs_add_credit.tpl"
                                          account_id=candidate[1]["id"]}
            %}
          </span>
        </th>
      </tr>
    {% endfor %}
  </thead>
</table>
{% else %}
<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <td colspan="3"> Too many accounts found </td>
    </tr>
  </thead>
</table>
{% endif %}
