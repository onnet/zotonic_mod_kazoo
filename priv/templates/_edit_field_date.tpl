{% with m.kazoo[{kz_doc_field type=type
                              doc_id=doc_id
                              field=field_name
                              account_id=account_id}]
   as field_value
%}

<input id="{{ prefix }}{{ field_name }}_input"
       type="text"
       name="input_value"
       value="{% if field_value
              %}{{ field_value
                   |gregsec_to_date
                   |date:"d/m/Y":"UTC"
                }}{% else %}{{ now|date:"d/m/Y":"UTC" }}{% endif %}"
       data-date="{% if field_value
                  %}{{ field_value
                       |gregsec_to_date
                       |date:"d/m/Y":"UTC"
                    }}{% else %}{{ now|date:"d/m/Y":"UTC" }}{% endif %}"
       data-date-format="dd/mm/yyyy"
       data-date-autoclose="true"
       data-date-language={{ z_language }}
       data-date-end-date="+1m"
/>


<i id="{{ prefix }}{{ field_name }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
{% wire id=prefix++field_name++"_undo"
        type="click"
        action={update target=prefix++field_name
                       template="_show_field_date.tpl"
                       type=type
                       doc_id=doc_id
                       account_id=account_id
                       field_name=field_name
                       options=options
                       convert_macro=convert_macro
                       prefix=prefix
                       postfix=postfix}
%}
<i id="{{ prefix }}{{ field_name }}_save" class="fa fa-save pointer" title="{_ Save _}"></i>
{% wire id=prefix++field_name++"_save"
        type="click"
        action={postback postback={save_field type doc_id field_name options prefix postfix account_id convert_macro} 
                         delegate="mod_kazoo" 
                         qarg=prefix++field_name++"_input"
                         inject_args type=type
                                     doc_id=doc_id
                                     field_name=field_name
                                     options=options
                                     prefix=prefix
                                     postfix=postfix
                                     account_id=account_id
                                     convert_macro=convert_macro
               }
%}

{% javascript %}
    $('#{{ prefix }}{{ field_name }}_input').datepicker();
{% endjavascript %}

{% endwith %}
