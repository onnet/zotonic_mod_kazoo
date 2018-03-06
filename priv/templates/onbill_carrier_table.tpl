
{% include "_onbill_json_editor.tpl" json_string=m.onbill[{onbill_get_carrier_json carrier_id=carrier_id }] doc_id=carrier_id %} 

<div id="json_field_{{ carrier_id }}" class='medium-12 columns'></div>
<input id="json_storage_{{ carrier_id }}" type="hidden" name="json_storage_{{ carrier_id }}" value="">
