    <input id="{{ allotment_name }}_{{ field_name }}_input"
           name="input_value"
           style="width:70%; height:20px; text-align:center;"
           type="text"
           placeholder="{{ placeholder }}"
           value="{{ m.kazoo[{allotments account_id=account_id}][1][allotment_name][1][field_name] }}"/>
    <i id="{{ allotment_name }}_{{ field_name }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
    {% wire id=allotment_name++"_"++field_name++"_undo"
            type="click"
            action={update target="allotment_"++allotment_name++"_"++field_name
                           template="_show_allotment_field.tpl"
                           allotment_name=allotment_name
                           field_name=field_name
                           account_id=account_id
                           placeholder=placeholder
                   }
    %}
    <i id="{{ allotment_name }}_{{ field_name }}_save" class="fa fa-save pointer" title="{_ Save _}"></i>
    {% wire id=allotment_name++"_"++field_name++"_save"
            type="click"
            action={postback postback={save_field type doc_id field_name account_id} 
                             delegate="mod_kazoo" 
                             qarg=field_name++"_input"
                             inject_args field_name=field_name account_id=account_id
                   }
    %}
