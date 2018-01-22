<tr>
  <th class="text-left"
      style="width: 35%;">
    {{ carrier_id }}
    <i id="delete_carrier_agrm_var_{{ carrier_id }}_{{ account_id }}"
       class="fa fa-trash-o pointer"></i>
    {% wire id="delete_carrier_agrm_var_"++carrier_id++"_"++account_id
            action={postback postback={delete_carrier_agrm_var account_id=account_id
                                                               agrm_carrier=carrier_id
                                      }
                             delegate="mod_kazoo"
                   }
    %} 
  </th>
  <th class="text-left">
    №
    <span id="agrm{{ carrier_id }}number">
      {% include "_show_field.tpl" type="onbill_variables"
                                   doc_id="_no_need_"
                                   field_name=["agrm", carrier_id, "number"]
                                   account_id=account_id
      %}
    </span>
    от 
    <span id="agrm{{ carrier_id }}date_gts">
      {% include "_show_field_date.tpl" type="onbill_variables"
                                   doc_id="_no_need_"
                                   field_name=["agrm", carrier_id, "date_gts"]
                                   account_id=account_id
                                   convert_macro="TO_GREGORIAN_SECONDS"
      %}
    </span>
  </th>
</tr>
