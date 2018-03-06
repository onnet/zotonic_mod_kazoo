<span>
  {% with m.kazoo[{kz_get_acc_doc_by_account_id account_id=account_id}] as account_doc %}
    {% print m.kazoo[{kz_get_acc_doc_by_account_id account_id=account_id}] %}
    {% print account_doc[1]["id"]|account_id_to_encoded %}
  {% endwith %}
</span>
