{% if q.triggervalue %}
  {% include "operations_edit_onbill_variables_carrier_row.tpl" carrier_id=q.triggervalue account_id=account_id %}
{% else %}
  {% include "operations_edit_onbill_variables_carrier_row.tpl" carrier_id=carrier account_id=account_id %}
{% endif %}
