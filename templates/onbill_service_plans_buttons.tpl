    {% button class="btn btn-xs btn-onnet pull-right" text=_"save"++" "++q.service_plan_id id="save_json_"++q.service_plan_id
              action={postback postback={onbill_set_doc_json doc_id=q.service_plan_id doc_type="onbill_service_plan"}
                               qarg="json_storage_"++q.service_plan_id
                               delegate="mod_onbill"
                     }
     %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"restore" id="restore_json_"++q.service_plan_id %}

