<span id="operations_edit_onbill_variables_dialog_span">
{% wire action={connect signal={operations_edit_onbill_variables_dialog_signal signal_filter=m.kazoo.signal_filter account_id=account_id}
                        action={replace target="operations_edit_onbill_variables_dialog_span"
                                       template="operations_edit_onbill_variables_dialog.tpl"
                                       account_id=account_id
                               }
               }
%}
{% with
     m.onbill[{onbill_get_variables account_id=account_id }],
     m.onbill[{onbill_get_variables account_id=m.session.kazoo_account_id}]
   as
     account_onbill_variables,
     reseller_onbill_variables
%}
  {% if reseller_onbill_variables[1]["country_of_residence"] == "ru" %}
    {% include "operations_edit_onbill_variables_dialog_ru.tpl" account_id=account_id %}
  {% else %}
    {% include "operations_edit_onbill_variables_dialog_default.tpl" account_id=account_id %}
  {% endif %}
{% endwith %}
</span>

