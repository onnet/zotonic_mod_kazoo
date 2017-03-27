
{% include "_onbill_json_editor.tpl" json_string=m.onbill[{onbill_get_variables_json account_id=account_id }] doc_id=account_id %} 

<div id="json_field_{{ account_id }}" class='medium-12 columns'></div>
<input id="json_storage_{{ account_id }}" type="hidden" name="json_storage_{{ account_id }}" value="">
