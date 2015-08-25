Test  {{ q.triggervalue }}

<div class="pl-10 pr-10 col-md-6">
{% print m.kazoo[{kz_get_acc_doc_by_account_id account_id=q.triggervalue}] %}
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_rs_allocated_numbers_tpl} action={update target="rs_allocated_numbers_tpl" template="rs_allocated_numbers.tpl" headline=_"Account's allocated numbers"}} %}
  <span id="rs_allocated_numbers_tpl">
        {% include "rs_allocated_numbers.tpl" headline=_"Account's allocated numbers" %}
  </span>
</div>
