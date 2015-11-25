<span>
    {% if type=="device" and field_name=="owner_id" %}
        {{ m.kazoo[{kz_doc_field type="user" doc_id=m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name}] field="first_name"}] }}
        {{ m.kazoo[{kz_doc_field type="user" doc_id=m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name}] field="last_name"}] }}
    {% elseif field_name==["music_on_hold","media_id"] %}
        {% with m.kazoo[{kz_doc_field type="media" doc_id=m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name}] field="name"}] as media_name %}
            {% if media_name %}
                {{ media_name }}
            {% else %}
                {_ Default music _}
            {% endif %}
        {% endwith %}
    {% else %}
        {{ m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name account_id=account_id}] }} 
    {% endif %}
    <i id="edit_{{ prefix }}{{ field_name }}" class="fa fa-edit pointer" title="Edit field"></i>
</span>
{% wire id="edit_"++prefix++field_name type="click" action={ update target=prefix++field_name template="_edit_field_select"++postfix++".tpl" type=type doc_id=doc_id field_name=field_name options=options prefix=prefix postfix=postfix account_id=account_id} %}
