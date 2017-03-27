{% with m.onbill[{onbill_get_service_plan service_plan_id=service_plan_id }] as service_plan_doc_json %}

{% if service_plan_doc_json %}
  {% include "_onbill_json_editor.tpl" json_string=m.onbill[{onbill_get_service_plan_json service_plan_id=service_plan_id }] doc_id=service_plan_id %} 
{% else %}
  {% include "_onbill_json_editor.tpl"
     json_string="{\"id\": \"" ++service_plan_id++ "\", \"name\": \"" ++service_plan_id++ "\", \"description\": \"\", \"plan\": \"\", \"bookkeepers\": \"\"}"
     doc_id=service_plan_id
  %} 
{% endif %}

<div id="json_field_{{ service_plan_id }}" class='medium-12 columns'></div>
<input id="json_storage_{{ service_plan_id }}" type="hidden" name="json_storage_{{ service_plan_id }}" value="">

{% endwith %}
