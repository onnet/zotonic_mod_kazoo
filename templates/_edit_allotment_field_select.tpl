<select id="{{ allotment_name }}_{{ field_name }}_input" name="input_value" class="btn-xs btn-onnet" style="max-width:140px; height:20px; text-align:center;">
  {% with m.kazoo[{allotments account_id=account_id}][1][allotment_name][1][field_name] as current_value %}
  {% for option in options %}
        <option value="{{ option }}" {% if option == current_value %}selected{% endif %}>{{ option }}</option>
  {% endfor %}
  {% endwith %}
</select>
    <i id="{{ allotment_name }}_{{ field_name }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
    {% wire id=allotment_name++"_"++field_name++"_undo"
            type="click"
            action={update target="allotment_"++allotment_name++"_"++field_name
                           template="_show_allotment_field_select.tpl"
                           options=options
                           allotment_name=allotment_name
                           field_name=field_name
                           account_id=account_id
                           placeholder=placeholder
                   }
    %}
    <i id="{{ allotment_name }}_{{ field_name }}_save" class="fa fa-save pointer" title="{_ Save _}"></i>
    {% wire id=allotment_name++"_"++field_name++"_save"
            type="click"
            action={postback postback={save_field_select field_name account_id} 
                             delegate="mod_kazoo" 
                             qarg=field_name++"_input"
                             inject_args field_name=field_name account_id=account_id
                   }
    %}
