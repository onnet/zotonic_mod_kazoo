    <input id="{{ field_name }}_input" name="input_value" style="width:70%; height:20px; text-align:center;" type="text" value="{{ m.inno[{kz_doc_field type=type doc_id=doc_id field=field_name}] }}"/>
    <i id="{{ field_name }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
    {% wire id=field_name++"_undo" type="click" action={ update target=field_name template="_show_field.tpl" type=type doc_id=doc_id field_name=field_name } %}
    <i id="{{ field_name }}_save" class="fa fa-save pointer" title="Save"></i>
    {% wire id=field_name++"_save" type="click" action={postback postback={save_field type doc_id field_name} 
                                                                 delegate="inno" 
                                                                 qarg=field_name++"_input" inject_args type=type doc_id=doc_id field_name=field_name}
     %}
