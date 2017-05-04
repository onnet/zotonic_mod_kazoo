<table class="table table-condensed table-centered">
  <thead>
    <tr><th colspan="3">
      {% wire id="arrows_"++#rspmid type="click"
              action={toggle target="rs_payments_lists_table_opened"}
              action={toggle target=#mytr}
              action={toggle target="arrow_right_"++#rspmid}
              action={toggle target="arrow_down_"++#rspmid}
              action={postback postback={trigger_innoui_widget arg="rs_payments_lists_table_opened"} delegate="mod_kazoo"}
      %}
        <span id="arrows_{{ #rspmid }}" style="cursor: pointer; padding-left: 0.7em;">
          <i id="arrow_right_{{ #rspmid }}"
             class="arrowpad fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #rspmid }}"
             style="display: none;" 
             class="arrowpad fa fa-arrow-circle-down"></i>
        </span>
         {_ Monthly payments _}
         <span style="float:right; padding-right:2em;">
           {{
              m.kazoo[{kz_list_transactions account_id=account_id
                                            selected_billing_period=selected_billing_period
                                            type="credit_summ"}]
              |format_price:[".",""]
              |currency_sign
           }}
         </span>
         {% if account_id %}
           <span style="float:right; padding-right:2em;">
            {% button class="btn btn-xs btn-onnet pull-right"
                      text=_"add credit"
                      id="child_area_add_credit"
                      action={dialog_open title=_"Add credit to "++account_doc[1]["name"]
                                          template="_rs_add_credit.tpl"
                                          account_id=account_id}
            %}
           </span>
         {% endif %}
      </th>
    </tr>
    <tr id="{{ #mytr }}" style="display: none;">
      <th colspan="3"></th>
    </tr>
  </thead>
</table>
{% wire action={connect signal={rs_payments_lists_table_opened signal_filter=m.kazoo.signal_filter}
                        action={update target="rs_payments_lists_table_opened"
                                       template="rs_widget_payments_list_table.tpl"
                                       account_id=account_id
                                       selected_billing_period=selected_billing_period
                               }
               }
%}
<span id="rs_payments_lists_table_opened" style="display: none;">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="rs_payments_lists_table_opened"
                            template="rs_widget_payments_list_table.tpl"
                            account_id=account_id
                            selected_billing_period=selected_billing_period
                    }
    %}
  </div>
</span>
