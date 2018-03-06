<div class="row">
  <div class="col-sm-10">
    <br />
    <!-- Enable Call-Forward -->
    <div class="row">
      <div class="col-xs-7">
        <label class="edit_user_label">{_ Enable Call-Forward _}</label>
      </div>
      <div id="call_forwardenabled" class="col-xs-4">
        <i id="toggle_call_forwardenabled"
           class="fa fa-toggle-{% if user_doc["call_forward"][1]["enabled"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_call_forwardenabled"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name=["call_forward","enabled"]
                                             account_id=account_id
                                 delegate="mod_kazoo"
                       }
        %}
      </div>
    </div>
    <!-- Redirect calls to -->
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">{_ Redirect calls to _}</label></div>
      <div id="call_forwardnumber" class="col-xs-4" >
        <span>{{ user_doc["call_forward"][1]["number"] }}</span>
          <i id="edit_call_forwardnumber" class="fa fa-edit pointer" title="Edit field"></i>
          {% wire id="edit_call_forwardnumber"
                  type="click"
                  action={update target="call_forwardnumber"
                                 template="_edit_field.tpl"
                                 type="user"
                                 doc_id=user_id
                                 field_name=["call_forward","number"]
                         }
          %}
      </div>
    </div>
    <!-- Bypass user's phones -->
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">{_ Bypass user's phones _}</label></div>
      <div id="call_forwardsubstitute" class="col-xs-4">
        <i id="toggle_call_forwardsubstitute"
           class="fa fa-toggle-{% if user_doc["call_forward"][1]["substitute"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_call_forwardsubstitute"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name=["call_forward","substitute"]
                                             account_id=account_id
                                 delegate="mod_kazoo"
                       }
        %}
      </div>
    </div>
    <!-- Require Key Press -->
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">{_ Require Key Press _}</label></div>
      <div id="call_forwardrequire_keypress" class="col-xs-4">
        <i id="toggle_call_forwardrequire_keypress"
           class="fa fa-toggle-{% if user_doc["call_forward"][1]["require_keypress"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_call_forwardrequire_keypress"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name=["call_forward","require_keypress"]
                                             account_id=account_id
                                 delegate="mod_kazoo"
                       }
        %}
      </div>
    </div>
    <!-- Keep Caller ID -->
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">{_ Keep Caller ID _}</label></div>
      <div id="call_forwardkeep_caller_id" class="col-xs-4">
        <i id="toggle_call_forwardkeep_caller_id"
           class="fa fa-toggle-{% if user_doc["call_forward"][1]["keep_caller_id"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_call_forwardkeep_caller_id"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name=["call_forward","keep_caller_id"]
                                             account_id=account_id
                                 delegate="mod_kazoo"
                       }
        %}
      </div>
    </div>
    <!-- Direct Calls Only -->
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">{_ Direct Calls Only _}</label></div>
      <div id="call_forwarddirect_calls_only" class="col-xs-4">
        <i id="toggle_call_forwarddirect_calls_only"
           class="fa fa-toggle-{% if user_doc["call_forward"][1]["direct_calls_only"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_call_forwarddirect_calls_only"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name=["call_forward","direct_calls_only"]
                                             account_id=account_id
                                 delegate="mod_kazoo"
                       }
        %}
      </div>
    </div>
    <br />
  </div>
</div>
