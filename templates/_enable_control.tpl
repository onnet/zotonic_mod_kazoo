{% if m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name}] %}
    <div>
        {% button class="col-xs-12 btn btn-onnet-orange mb-1" text=_"Disable"  action={ postback postback={disable_doc type doc_id field_name} 
                                                                                                 inject_args type=type doc_id=doc_id field_name=field_name 
                                                                                                 delegate="mod_kazoo"}
        %}
    </div>
{% else %}
    <div>
        {% button class="col-xs-12 btn btn-zprimary mb-1" text=_"Enable"  action={ postback postback={enable_doc type doc_id field_name}
                                                                                            inject_args type=type doc_id=doc_id field_name=field_name
                                                                                            delegate="mod_kazoo"}
        %}
    </div>
{% endif %}
