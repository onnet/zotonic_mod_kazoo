<table class="table table-condensed table-centered">
    <thead>
        <tr><th colspan="3">
            {% wire id="arrows_"++#rspmcid type="click"
                    action={ toggle target="rs_per_minute_calls_lists_table_opened" }
                    action={ toggle target=#mytr }
                    action={ toggle target="arrow_right_"++#rspmcid }
                    action={ toggle target="arrow_down_"++#rspmcid }
                    action={ postback postback={trigger_innoui_widget arg="rs_per_minute_calls_lists_table_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #rspmcid }}" style="cursor: pointer; padding-left: 0.7em;">
                <i id="arrow_right_{{ #rspmcid }}" style="{% if m.kazoo[{ui_element_opened element="rs_per_minute_calls_lists_table_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #rspmcid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_per_minute_calls_lists_table_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
               {_ Per minute calls _}
               <span style="float:right; padding-right:2em;">
                 {{ m.config.mod_kazoo.local_currency_sign.value
                 }}{{
                    m.kazoo[{kz_ledgers_summ account_id=account_id payments_month_chosen=payments_month_chosen ledger_id="per-minute-voip"}]|units_to_money|format_price:[".",""]
                 }}
               </span>
            </th>
        </tr>
        <tr id="{{ #mytr }}" style="{% if not m.kazoo[{ui_element_opened element="rs_per_minute_calls_lists_table_opened"}] %}display: none;{% endif %}"><th colspan="3"></th></tr>
    </thead>
</table>
<span id="rs_per_minute_calls_lists_table_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_per_minute_calls_lists_table_opened"}] %}display: none;{% endif %}">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="rs_per_minute_calls_lists_table_opened"
                                                                    template="rs_widget_per_minute_calls_list_table.tpl"
                                                                    account_id=account_id
                                                                    payments_month_chosen=payments_month_chosen}
        %}
      </div>
</span>
