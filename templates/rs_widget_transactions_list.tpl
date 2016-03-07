{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="rs_payments_list_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="rs_payments_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh results" 
              action={postback postback={refresh_rs_payments_list account_id child_account_doc}
                               delegate="mod_kazoo"
                               qarg="payments_month_chosen"
                               inject_args account_id=account_id child_account_doc=child_account_doc
                     }
              action={mask target="payments_lists_table" message=_"Sending request"++"..."}
    %}
     <input id="payments_month_chosen" type="text" class="input-small-onnet pull-right" name="payments_month_chosen"
                                                    value="{% if payments_month_chosen %}{{ payments_month_chosen }}{% else %}{{ now|date: 'm/Y' }}{% endif %}"
                                                    data-date="{% if payments_month_chosen %}{{ payments_month_chosen }}{% else %}{{ now|date: 'm/Y' }}{% endif %}"
                                                    data-date-min-view-mode="months"
                                                    data-date-format="mm/yyyy"
                                                    data-date-autoclose="true"
                                                    data-date-language={{ z_language }}
                                                    data-date-start-date="-36m"
                                                    data-date-end-date="+0d"
                                                    readonly/>
    <span class="pull-right pr-05"> {_ Choose month _}: </span>
    {% javascript %}
        $('#payments_month_chosen').datepicker();
    {% endjavascript %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_payments_list_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="rs_payments_list_widget_opened"
                                                                    template="rs_widget_transactions_list_table.tpl"
                                                                    account_id=account_id
                                                                    child_account_doc=child_account_doc
                                                                    payments_month_chosen=payments_month_chosen
                                                                    transactions=transactions
                                                                    headline=_"Transactions list"}
        %}
   </div>
</div>
{% endblock %}
