<table class="table table-condensed table-centered">
  <thead>
    <tr><th colspan="3">
    {% wire id="arrows_"++#rsmfeesid type="click"
            action={ toggle target="rs_monthly_fees_lists_table_opened" }
            action={ toggle target=#mytr }
            action={ toggle target="arrow_right_"++#rsmfeesid }
            action={ toggle target="arrow_down_"++#rsmfeesid }
            action={ postback postback={trigger_innoui_widget arg="rs_monthly_fees_lists_table_opened" } delegate="mod_kazoo" }
    %}
      <span id="arrows_{{ #rsmfeesid }}" style="cursor: pointer; padding-left: 0.7em;">
        <i id="arrow_right_{{ #rsmfeesid }}"
           style="{% if m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}" 
           class="arrowpad fa fa-arrow-circle-right"
        ></i>
        <i id="arrow_down_{{ #rsmfeesid }}"
           style="{% if not m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}" 
           class="arrowpad fa fa-arrow-circle-down"
        ></i>
      </span>
       {_ Monthly fees _}
       <span style="float:right; padding-right:2em;">
         {{
            m.kazoo[{kz_list_transactions account_id=account_id payments_month_chosen=payments_month_chosen type="debit_summ"}]
            |format_price:[".",""]
            |currency_sign
         }}
       </span>
       {% if account_id %}
         <span style="float:right; padding-right:2em;">
          {% button class="btn btn-xs btn-onnet pull-right" text=_"add debit" id="child_area_add_debit"
                    action={dialog_open title=_"Add debit to "++account_doc[1]["name"] template="_rs_add_debit.tpl" account_id=account_id}
          %}
         </span>
       {% endif %}
    </th>
  </tr>
  <tr id="{{ #mytr }}" style="{% if not m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}">
    <th colspan="3"></th>
  </tr>
  </thead>
</table>
<span id="rs_monthly_fees_lists_table_opened"
      style="{% if not m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}"
>
   <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="rs_monthly_fees_lists_table_opened"
                            template="rs_widget_monthly_fees_list_table.tpl"
                            account_id=account_id
                            payments_month_chosen=payments_month_chosen}
    %}
  </div>
</span>
