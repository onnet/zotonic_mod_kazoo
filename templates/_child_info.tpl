<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_onbill_account_details signal_filter=m.kazoo.signal_filter}
                  action={update target="onbill_account_details_span"
                                 template="onbill_account_details.tpl"
                                 headline=_"Account details"
                                 account_id=account_id
                         }
                 }
  %}
  <span id="onbill_account_details_span">
    {% include "onbill_account_details.tpl" headline=_"Account details" %}
  </span>
  {% if m.session.display_billing %}
    {% wire action={connect signal={update_onbill_periodic_service signal_filter=m.kazoo.signal_filter}
                    action={update target="onbill_periodic_services_span"
                                   template="onbill_periodic_services.tpl"
                                   headline=_"Periodic services"
                                   account_id=account_id
                           }
                   }
    %}
    <span id="onbill_periodic_services_span">
      {% include "onbill_periodic_services.tpl" headline=_"Periodic services" %}
    </span>
    {% include "onbill_variables_doc.tpl" headline=_"Customer settings" account_id=account_id %}
  {% endif %}
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_rs_allocated_numbers_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="rs_allocated_numbers_tpl"
                                         template="rs_allocated_numbers.tpl"
                                         headline=_"Account's allocated numbers"
                                         account_id=account_id
                                 }
                 }
  %}
  <span id="rs_allocated_numbers_tpl">
        {% include "rs_allocated_numbers.tpl" headline=_"Account's allocated numbers" account_id=account_id %}
  </span>
  {% wire action={connect signal={rs_widget_e911_addresses_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="rs_widget_e911_addresses_tpl"
                                         template="rs_widget_e911_addresses.tpl"
                                         headline=_"E911 addresses"
                                         account_id=account_id
                                 }
                 }
  %}
  <span id="rs_widget_e911_addresses_tpl">
    {% include "rs_widget_e911_addresses.tpl" headline=_"E911 addresses" account_id=account_id %}
  </span>
  {% if m.session.display_billing %}
    {% wire action={connect signal={update_fin_info_signal signal_filter=m.kazoo.signal_filter}
                            action={update target="rs_widget_transactions_list_tpl"
                                           template="rs_widget_transactions_list.tpl"
                                           headline=_"Transactions list"
                                           account_id=account_id
                                   }
                   }
    %}
    <span id="rs_widget_transactions_list_tpl">
      {% include "rs_widget_transactions_list.tpl" headline=_"Transactions list" account_id=account_id %}
    </span>
  {% endif %}
  {% wire action={connect signal={update_rs_account_registrations_tpl signal_filter=m.kazoo.signal_filter}
                          action={update target="rs_account_registrations_tpl"
                                         template="rs_account_registrations.tpl"
                                         headline=_"Account's current registrations"
                                         account_id=account_id
                                 }
                 }
  %}
  <span id="rs_account_registrations_tpl">
    {% include "rs_account_registrations.tpl" headline=_"Account's current registrations" account_id=account_id %}
  </span>
</div>
