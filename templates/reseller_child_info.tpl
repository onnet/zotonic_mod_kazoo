{% with m.session.rs_selected_account_id as account_id %}
<div class="pl-10 pr-10 col-md-6">
  {% include "rs_widget_account_details.tpl" headline=_"Account details" account_id=account_id %}
  {% include "rs_widget_e911_addresses.tpl" headline=_"E911 addresses" account_id=account_id %}
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_rs_allocated_numbers_tpl} action={update target="rs_allocated_numbers_tpl"
                                                                                  template="rs_allocated_numbers.tpl"
                                                                                  headline=_"Account's allocated numbers"
                                                                                  account_id=account_id}}
  %}
  <span id="rs_allocated_numbers_tpl">
        {% include "rs_allocated_numbers.tpl" headline=_"Account's allocated numbers" account_id=account_id %}
  </span>

  {% wire action={connect signal={update_rs_account_registrations_tpl} action={update target="rs_account_registrations_tpl"
                                                                                  template="rs_account_registrations.tpl"
                                                                                  headline=_"Account's current registrations"
                                                                                  account_id=account_id}}
  %}
  <span id="rs_account_registrations_tpl">
        {% include "rs_account_registrations.tpl" headline=_"Account's current registrations" account_id=account_id %}
  </span>
</div>
{% endwith %}
