<input id="{{ prefix }}{{ field_name }}_input"
       name="input_value"
       style="width:{% if width %}{{ width }}{% else %}70%{% endif %};
              height:{% if height %}{{ height }}{% else %}20px{% endif %};
              text-align:{% if text-align %}{{ text-align }}{% else %}center{% endif %};"
       type="text"
       placeholder="{{ placeholder }}"
       value="{{ m.kazoo[{kz_doc_field type=type
                                       doc_id=doc_id
                                       field=field_name
                                       account_id=account_id}] }}"/>
<i id="{{ prefix }}{{ field_name }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
{% wire id=prefix++field_name++"_undo"
        type="click"
        action={update target=prefix++field_name
                       template="_show_field.tpl"
                       type=type
                       doc_id=doc_id
                       field_name=field_name
                       account_id=account_id
                       prefix=prefix
                       postfix=postfix
                       width=width
                       convert_macro=convert_macro
                       placeholder=placeholder}
%}
<i id="{{ prefix }}{{ field_name }}_save" class="fa fa-save pointer" title="{_ Save _}"></i>
{% wire id=prefix++field_name++"_save"
        type="click"
        action={postback postback={save_field type doc_id field_name prefix postfix account_id width convert_macro}
                         delegate="mod_kazoo" 
                         qarg=prefix++field_name++"_input"
                         inject_args type=type
                                     doc_id=doc_id
                                     field_name=field_name
                                     prefix=prefix
                                     postfix=postfix
                                     account_id=account_id
                                     width=width
                                     convert_macro=convert_macro
               }
%}
