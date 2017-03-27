<div class="pl-10 pr-10 col-md-6">
  <span id="onnet_widget_account_details_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="onnet_widget_account_details_tpl" 
                                template="onbill_widget_account_details.tpl"
                                dashboard
                                headline=_"Account details"}
        %}
      </div>
  </span>
  {% wire action={connect signal={update_fin_info_signal signal_filter=m.kazoo.signal_filter}
                          action={update target="onnet_widget_account_balance_tpl"
                          template="onnet_widget_account_balance.tpl"
                          headline=_"Account balance"}
                 }
  %}
  <span id="onnet_widget_account_balance_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="onnet_widget_account_balance_tpl" 
                                template="onnet_widget_account_balance.tpl"
                                dashboard
                                headline=_"Account balance"}
        %}
      </div>
  </span>
  {# Credit status #}
  <div id="update_widget_dashboard_credit">
    {# with m.onbill.promised_payment as pr_pt #}
      {# if pr_pt[1]["enabled"] #}
        {# include "onbill_widget_dashboard_credit.tpl" headline=_"Credit" pr_pt=pr_pt #}
      {# endif #}
    {# endwith #}
  </div>

</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_fin_info_signal signal_filter=m.kazoo.signal_filter}
                          action={update target="onnet_widget_monthly_fees_tpl"
                          template="onnet_widget_monthly_fees.tpl"
                          headline=_"Current services"}
                 }
  %}
  <span id="onnet_widget_monthly_fees_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="onnet_widget_monthly_fees_tpl" 
                                template="onnet_widget_monthly_fees.tpl"
                                headline=_"Current services"}
        %}
      </div>
  </span>
  <span id="onnet_widget_order_additional_number_tpl">
      {% include "onnet_widget_order_additional_number.tpl" %}
  </span>
  {% wire action={connect signal={onnet_allocated_numbers_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="onnet_allocated_numbers_tpl"
                          template="onnet_allocated_numbers.tpl"
                          headline=_"Allocated numbers"}
                 }
  %}
  <span id="onnet_allocated_numbers_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="onnet_allocated_numbers_tpl" 
                                template="onnet_allocated_numbers.tpl"
                                headline=_"Allocated numbers"}
        %}
      </div>
  </span>
  {% if m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status %}
  {% wire action={connect signal={reseller_registrations_widget_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="reseller_registrations_widget_tpl"
                          template="reseller_registrations_widget.tpl"
                          headline=_"System-wide registrations"}
                 }
  %}
  <span id="reseller_registrations_widget_tpl">
    {% include "reseller_registrations_widget.tpl" headline=_"System-wide registrations" %}
  </span>
  {% endif %}

  <span id="onnet_trunks_manager_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="onnet_trunks_manager_tpl" 
                                template="onnet_trunks_manager.tpl"
                                headline=_"Trunks manager"}
        %}
      </div>
  </span>
</div>
