<i id="toggle_{{ prefix }}{{ field_name }}"
   class="pointer
          fa
          fa-toggle-{% if m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name}]
                    %}on{% else %}off{% endif %}"></i>
{% wire id="toggle_"++prefix++field_name
        type="click"
        action={postback postback={toggle_field type doc_id field_name prefix account_id}
                         delegate="mod_kazoo"
                         inject_args type=type
                                     doc_id=doc_id
                                     field_name=field_name
                                     prefix=prefix
                                     account_id=account_id
               }
%}
