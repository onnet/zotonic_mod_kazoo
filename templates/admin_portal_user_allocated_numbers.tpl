<div class="row">
  <br />
  <div class="col-xs-12">

    <div class="row">
        <div class="col-xs-4 col-xs-offset-1"><h4>{_ PSTN Numbers _}</h4></div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label"></label></div>
        <div id="caller_idinternalname" class="col-xs-6" >
            <span>{{ user_doc["caller_id"][1]["internal"][1]["name"] }}</span>
            <i id="edit_caller_idinternalname" class="fa fa-edit pointer" title="Edit field"></i>
            {% wire id="edit_caller_idinternalname" type="click" action={ update target="caller_idinternalname" template="_edit_field.tpl" type="user" doc_id=user_id field_name=["caller_id","internal","name"] } %}
        </div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Caller ID Number</label></div>
        <div id="caller_idinternalnumber" class="col-xs-6" >
            <span>{{ user_doc["caller_id"][1]["internal"][1]["number"] }}</span>
            <i id="edit_caller_idinternalnumber" class="fa fa-edit pointer" title="Edit field"></i>
            {% wire id="edit_caller_idinternalnumber" type="click" action={ update target="caller_idinternalnumber" template="_edit_field.tpl" type="user" doc_id=user_id field_name=["caller_id","internal","number"] } %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-xs-offset-1"><h4>{_ Internal Numbers _}</h4></div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Caller ID Name</label></div>
        <div id="caller_idexternalname" class="col-xs-6" >
            <span>{{ user_doc["caller_id"][1]["external"][1]["name"] }}</span>
            <i id="edit_caller_idexternalname" class="fa fa-edit pointer" title="Edit field"></i>
            {% wire id="edit_caller_idexternalname" type="click" action={ update target="caller_idexternalname" template="_edit_field.tpl" type="user" doc_id=user_id field_name=["caller_id","external","name"] } %}
        </div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Caller ID Number</label></div>
        <div id="caller_idexternalnumber" class="col-xs-6" >
            <span>{{ user_doc["caller_id"][1]["external"][1]["number"] }}</span>
            <i id="edit_caller_idexternalnumber" class="fa fa-edit pointer" title="Edit field"></i>
            {% wire id="edit_caller_idexternalnumber" type="click" action={ update target="caller_idexternalnumber" template="_edit_field.tpl" type="user" doc_id=user_id field_name=["caller_id","external","number"] } %}
        </div>
    </div>

  <br />
  </div>
</div>

{% for number in m.inno.get_acc_numbers_info %}
    {% print number[2][1]["used_by"] %}
    {% if not number[2][1]["used_by"] %}
        {% print number[2][1] %}
    {% endif %}
{% endfor %}
Callflows:
{% print m.inno.kz_list_account_callflows %}
Numbers:
{% print m.inno.get_acc_numbers_info %}
