{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={toggle target="onbill_variables_doc_"++account_id++"_widget_opened"}
        action={toggle target="arrow_right_"++#dtid}
        action={toggle target="arrow_down_"++#dtid}
        action={toggle target="save_json_"++account_id}
        action={toggle target="restore_json_"++account_id}
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="display: none;"
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    <i id="edit_onbill_variables_dialog_{{ account_id }}"
       class="fa fa-edit pointer"
       title="Edit account onbill settings"></i>
    {% wire id="edit_onbill_variables_dialog_"++account_id
            action={postback postback={edit_onbill_variables_dialog account_id=account_id}
                             delegate="mod_kazoo"
                   }
    %}
    <i id="download_onbill_variables_dialog_{{ account_id }}"
       class="pl-10 fa fa-download pointer"
       title="LB to Kazoo sync"></i>
    {% wire id="download_onbill_variables_dialog_"++account_id
            action={confirm text=_"Do you really want to download data from LB?"
                            action={postback postback={lb_to_kazoo_sync account_id=account_id}
                                             delegate="mod_kazoo"
                                   }
                   }
    %}
    <i id="upload_onbill_variables_dialog_{{ account_id }}"
       class="pl-10 fa fa-upload pointer"
       title="Kazoo to LB sync"></i>
    {% wire id="upload_onbill_variables_dialog_"++account_id
            action={confirm text=_"Do you really want to upload data to LB?"
                            action={postback postback={kazoo_to_lb_sync account_id=account_id}
                                             delegate="mod_kazoo"
                                   }
                   }
    %}
    {% button class="btn btn-xs btn-onnet pull-right display_none"
              text=_"save" id="save_json_"++account_id
              action={postback postback={onbill_set_variables_json account_id=account_id}
                               qarg="json_storage_"++account_id
                               delegate="mod_kazoo"
                     }
    %}
    {% button class="btn btn-xs btn-onnet pull-right display_none"
              text=_"restore"
              id="restore_json_"++account_id
    %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
{% wire action={connect signal={refresh_onbill_variables_doc_signal signal_filter=m.kazoo.signal_filter}
                        action={update target="onbill_variables_doc_"++account_id++"_widget_opened"
                                       template="onbill_variables_table.tpl"
                                       account_id=account_id
                               }
               }
%}

<div id="onbill_variables_doc_{{ account_id }}_widget_opened"
     style="display: none;">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="onbill_variables_doc_"++account_id++"_widget_opened"
                            template="onbill_variables_table.tpl"
                            account_id=account_id
                    }
    %}
  </div>
</div>
{% endblock %}
