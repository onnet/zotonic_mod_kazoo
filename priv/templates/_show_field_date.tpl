<span>
  {{ m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name account_id=account_id}]|gregsec_to_date|date:"Y-m-d" }}
  <i id="edit_{{ prefix }}{{ field_name }}" class="fa fa-edit pointer" title="Edit field"></i>
</span>
{% wire id="edit_"++prefix++field_name
        type="click"
        action={update target=prefix++field_name
                       template="_edit_field_date.tpl"
                       type=type
                       doc_id=doc_id
                       field_name=field_name
                       account_id=account_id
                       placeholder=placeholder
                       prefix=prefix
                       postfix=postfix
                       width=width
                       convert_macro=convert_macro
               }
%}
