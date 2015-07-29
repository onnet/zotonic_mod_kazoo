<span>
    {% if type=="device" and field_name=="owner_id" %}
        {{ m.inno[{kz_doc_field type="user" doc_id=m.inno[{kz_doc_field type=type doc_id=doc_id field=field_name}] field="first_name"}] }}
        {{ m.inno[{kz_doc_field type="user" doc_id=m.inno[{kz_doc_field type=type doc_id=doc_id field=field_name}] field="first_name"}] }}
    {% else %}
        {{ m.inno[{kz_doc_field type=type doc_id=doc_id field=field_name}] }} 
    {% endif %}
    <i id="edit_{{ field_name }}" class="fa fa-edit pointer" title="Edit field"></i>
</span>
{% wire id="edit_"++field_name type="click" action={ update target=field_name template="_edit_field_select.tpl" type=type doc_id=doc_id field_name=field_name options=options } %}
