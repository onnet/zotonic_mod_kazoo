<table class="table table-hover table-centered table-condensed">
    <tbody>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
          <tr>
            <td>{_ Current balance _}</td>
            <td>
              £{{ m.kazoo[{current_account_credit account_id=account_id}]|format_price }}
                {% if m.modules.info.mod_bt.enabled %}
                  {% button class="btn btn-xs btn-onnet pull-right" text=_"add credit" id="child_area_add_credit"
                            action={dialog_open title=_"Add credit to "++account_doc[1]["name"] template="_rs_add_credit.tpl" account_id=account_id}
                  %}
                  {% button class="btn btn-xs btn-onnet pull-right" text=_"add debit" id="child_area_add_debit"
                            action={dialog_open title=_"Add debit to "++account_doc[1]["name"] template="_rs_add_debit.tpl" account_id=account_id}
                  %}
                {% endif %}
            </td>
          </tr>
    </tbody>
</table>
