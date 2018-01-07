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

    <span id="{{ account_id }}agrm{{ carrier_id }}date_jsonday">
      {% include "_show_field_select.tpl" type="onbill_variables"
                                          doc_id="_no_need_"
                                          field_name=["agrm", carrier_id, "date_json", "day"]
                                          options=1|range:31
                                          prefix=account_id
      %}
    </span>
    .
    <span id="{{ account_id }}agrm{{ carrier_id }}date_jsonmonth">
      {% include "_show_field_select.tpl" type="onbill_variables"
                                          doc_id="_no_need_"
                                          field_name=["agrm", carrier_id, "date_json", "month"]
                                          options=[["1", _"Jan"]
                                                  ,["2", _"Feb"]
                                                  ,["3", _"Mar"]
                                                  ,["4", _"Apr"]
                                                  ,["5", _"May"]
                                                  ,["6", _"Jun"]
                                                  ,["7", _"Jul"]
                                                  ,["8", _"Aug"]
                                                  ,["9", _"Sep"]
                                                  ,["10", _"Oct"]
                                                  ,["11", _"Nov"]
                                                  ,["12", _"Dec"]
                                                  ]
                                          prefix=account_id
      %}
    </span>
    .
    <span id="{{ account_id }}agrm{{ carrier_id }}date_jsonyear">
      {% include "_show_field_select.tpl" type="onbill_variables"
                                          doc_id="_no_need_"
                                          field_name=["agrm", carrier_id, "date_json", "year"]
                                          options=[now|sub_year|date: 'Y'
                                                  ,now|date: 'Y'
                                                  ,now|add_year|date: 'Y'
                                                  ]
                                          prefix=account_id
      %}
    </span>
  </th>
</tr>
