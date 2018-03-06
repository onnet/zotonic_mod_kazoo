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
    <a href="{{ m.onbill[{attachment_download_link account_id=account_id
                                                   doc_id="test"
                                                   attachment_name="task_filename"
                                                   doc_type="onbill"}]
             }}">№</a>
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
                                   field_name=["agrm", carrier_id, "date"]
                                   account_id=account_id
                                   convert_macro="TO_GREGORIAN_SECONDS"
      %}
    </span>
  </th>
  <th class="text-right">
    {% with
         m.kazoo[{kz_doc_field type="onbill_variables"
                               doc_id="_no_need_"
                               field=["agrm", carrier_id, "att_name"]
                               account_id=account_id}]
        ,m.kazoo[{kz_doc_field type="onbill_variables"
                               doc_id="_no_need_"
                               field=["agrm", carrier_id, "number"]
                               account_id=account_id}]
       as
         att_name
        ,agrm_number
    %}
      {% if att_name %}
        <a href="{{ m.onbill[{attachment_download_link account_id=account_id
                                                       doc_id=agrm_number|cleanout
                                                       attachment_name=att_name
                                                       doc_type="onbill"}] }}"
        ><i class="fa fa-download" title="{_ Download _}"></i></a>
      {% else %}
        <i id="agrm{{ carrier_id }}create"
           class="fa fa-plus pointer"
           title="{_ Create _}"></i>
        <i id="agrm{{ carrier_id }}spinner"
           style="display: none;"
           class="fa fa-spinner fa-spin"
           title="{_ Please wait _}"></i>
        {% wire id="agrm"++carrier_id++"create"
                action={hide target="agrm"++carrier_id++"create"}
                action={show target="agrm"++carrier_id++"spinner"}
                action={postback postback={generate_rs_agrm account_id=account_id
                                                            carrier_id=carrier_id
                                          }
                                 delegate="mod_kazoo"
                       }
        %} 
      {% endif %}
    {% endwith %}
  </th>
</tr>
