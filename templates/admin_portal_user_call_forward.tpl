<div class="row">
  <div class="col-sm-10">
    <br />

    <!-- Enable Call-Forward -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Enable Call-Forward</label></div>
        <div id="call_forwardenabled" class="col-xs-5">
            {% if user_doc["call_forward"][1]["enabled"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
            <i id="toggle_call_forwardenabled" class="fa fa-refresh pointer" title="Change"></i>
            {% wire id="toggle_call_forwardenabled" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                          delegate="inno"
                                                                          inject_args type="user" doc_id=user_id field_name=["call_forward","enabled"]}
            %}
        </div>
    </div>
    <!-- Redirect calls to -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Redirect calls to</label></div>
        <div id="call_forwardnumber" class="col-xs-5" >
            <span>{{ user_doc["call_forward"][1]["number"] }}</span>
            <i id="edit_call_forwardnumber" class="fa fa-edit pointer" title="Edit field"></i>
            {% wire id="edit_call_forwardnumber" type="click" action={ update target="call_forwardnumber" template="_edit_field.tpl" type="user" doc_id=user_id field_name=["call_forward","number"] } %}
        </div>
    </div>
    <!-- Bypass user's phones -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Bypass user's phones</label></div>
        <div id="call_forwardsubstitute" class="col-xs-5">
            {% if user_doc["call_forward"][1]["substitute"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
            <i id="toggle_call_forwardsubstitute" class="fa fa-refresh pointer" title="Change"></i>
            {% wire id="toggle_call_forwardsubstitute" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                          delegate="inno"
                                                                          inject_args type="user" doc_id=user_id field_name=["call_forward","substitute"]}
            %}
        </div>
    </div>
    <!-- Require Key Press -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Require Key Press</label></div>
        <div id="call_forwardrequire_keypress" class="col-xs-5">
            {% if user_doc["call_forward"][1]["require_keypress"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
            <i id="toggle_call_forwardrequire_keypress" class="fa fa-refresh pointer" title="Change"></i>
            {% wire id="toggle_call_forwardrequire_keypress" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                          delegate="inno"
                                                                          inject_args type="user" doc_id=user_id field_name=["call_forward","require_keypress"]}
            %}
        </div>
    </div>
    <!-- Keep Caller ID -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Keep Caller ID</label></div>
        <div id="call_forwardkeep_caller_id" class="col-xs-5">
            {% if user_doc["call_forward"][1]["keep_caller_id"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
            <i id="toggle_call_forwardkeep_caller_id" class="fa fa-refresh pointer" title="Change"></i>
            {% wire id="toggle_call_forwardkeep_caller_id" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                          delegate="inno"
                                                                          inject_args type="user" doc_id=user_id field_name=["call_forward","keep_caller_id"]}
            %}
        </div>
    </div>
    <!-- Direct Calls Only -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">Direct Calls Only</label></div>
        <div id="call_forwarddirect_calls_only" class="col-xs-5">
            {% if user_doc["call_forward"][1]["direct_calls_only"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
            <i id="toggle_call_forwarddirect_calls_only" class="fa fa-refresh pointer" title="Change"></i>
            {% wire id="toggle_call_forwarddirect_calls_only" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                          delegate="inno"
                                                                          inject_args type="user" doc_id=user_id field_name=["call_forward","direct_calls_only"]}
            %}
        </div>
    </div>

    <br />
  </div>
</div>
