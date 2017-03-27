    <i id="pvt_limits_{{ field_name }}_save" class="fa fa-save pointer pull-right" title="{_ Save _}"></i>
    <i id="pvt_limits_{{ field_name }}_undo" class="fa fa-remove pointer pull-right" title="Cancel"></i>
    <input id="pvt_limits_{{ field_name }}_input"
           name="input_value"
           style="width:60%; height:20px; text-align:center;"
           class="pull-right"
           type="text"
           placeholder="{{ placeholder }}"
           value="{{ m.onbill[{onbill_pvt_limits account_id=account_id}][1][field_name] }}"/>
    {% wire id="pvt_limits_"++field_name++"_undo"
            type="click"
            action={update target="pvt_limits_"++field_name
                           template="_show_pvt_limits_field.tpl"
                           field_name=field_name
                           account_id=account_id
                           placeholder=placeholder
                           filter=filter
                   }
    %}
    {% wire id="pvt_limits_"++field_name++"_save"
            type="click"
            action={postback postback={save_pvt_limits_field field_name account_id} 
                             delegate="mod_onbill" 
                             qarg="pvt_limits_"++field_name++"_input"
                             inject_args field_name=field_name account_id=account_id
                   }
            action={update target="pvt_limits_"++field_name
                           template="_show_pvt_limits_field.tpl"
                           field_name=field_name
                           account_id=account_id
                           placeholder=placeholder
                           filter=filter
                   }
    %}
