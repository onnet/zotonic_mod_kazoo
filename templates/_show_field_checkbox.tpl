<i id="toggle_{{ prefix }}{{ field_name }}"
   class="fa fa-toggle-{% if m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name}] %}on{% else %}off{% endif %} pointer"></i>
{% wire id="toggle_"++prefix++field_name
        type="click"
        action={ postback postback={toggle_field type doc_id field_name prefix}
        delegate="mod_kazoo"
        inject_args type=type doc_id=doc_id field_name=field_name prefix=prefix}
%}
