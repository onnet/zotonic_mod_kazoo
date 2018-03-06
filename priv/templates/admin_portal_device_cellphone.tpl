<div class="row">
  <br />
  <div class="col-sm-10">
    <!-- Device Nickname field -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">Device Nickname</label></div>
      <div id="name" class="col-xs-5 zalarm">
        {% include "_show_field.tpl" type="device" doc_id=device_id field_name=["name"] %}
      </div>
    </div>
    <!-- User status -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">Device status</label></div>
      <div id="device_enabled_status" class="col-xs-5">
        {% if device_doc["call_forward"][1]["enabled"] %}
          <span class="zprimary">Enabled</span>
        {% else %}
          <span class="zalarm">Disabled</span>
        {% endif %}
      </div>
    </div>

    <!-- Assign To -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">Assign To</label></div>
      <div id="owner_id" class="col-xs-5">
        {% wire id="edit_owner_id"
                type="click"
                action={update target="owner_id" 
                               template="_edit_field_select.tpl" 
                               type="device"
                               doc_id=device_id
                               field_name="owner_id"
                               options=m.kazoo.kz_list_account_users_short
                       }
        %}
        <span>
          {{ m.kazoo[{kz_doc_field type="user" doc_id=device_doc["owner_id"] field="first_name"}] }}
          {{ m.kazoo[{kz_doc_field type="user" doc_id=device_doc["owner_id"] field="last_name"}] }}
          <i id="edit_owner_id" class="fa fa-edit pointer" title="Edit field"></i>
        </span>
      </div>
    </div>

    <!-- Number field -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">Number</label></div>
      <div id="call_forwardnumber" class="col-xs-5">
        {% wire id="edit_call_forwardnumber"
                type="click"
                action={update target="call_forwardnumber"
                               template="_edit_field.tpl"
                               type="device"
                               doc_id=device_id
                               field_name=["call_forward","number"]
                       }
        %}
        <span>
          {{ device_doc["call_forward"][1]["number"] }}
          <i id="edit_call_forwardnumber" class="fa fa-edit pointer" title="Edit field"></i>
        </span>
      </div>
    </div>
    <!-- Keep Caller ID -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">Keep Caller ID</label></div>
      <div id="call_forwardkeep_caller_id" class="col-xs-5">
        <i id="toggle_call_forwardkeep_caller_id"
           class="pointer
                  fa fa-toggle-{% if device_doc["call_forward"][1]["keep_caller_id"] %}on{% else %}off{% endif %}"></i>
        {% wire id="toggle_call_forwardkeep_caller_id"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 delegate="mod_kazoo"
                                 inject_args type="device"
                                             doc_id=device_id
                                             field_name=["call_forward","keep_caller_id"]
                                             account_id=account_id
                       }
        %}
      </div>
    </div>
    <!-- Require Key Press -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">Require Key Press</label></div>
      <div id="call_forwardrequire_keypress" class="col-xs-5">
        <i id="toggle_call_forwardrequire_keypress"
           class="pointer
                  fa
                  fa-toggle-{% if device_doc["call_forward"][1]["require_keypress"] %}on{% else %}off{% endif %}"></i>
        {% wire id="toggle_call_forwardrequire_keypress"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 delegate="mod_kazoo"
                                 inject_args type="device"
                                             doc_id=device_id
                                             field_name=["call_forward","require_keypress"]
                                             account_id=account_id
                       }
        %}
      </div>
    </div>
  <br />
  </div>
  <div class="col-xs-2" id="device_enable_control">
    {% if device_doc["call_forward"][1]["enabled"] %}
      <div>
        {% button class="col-xs-12 btn btn-zalarm mb-1"
                  text=_"Disable"
                  action={postback postback={disable_doc type doc_id field_name} 
                                   inject_args type="device"
                                               doc_id=device_id
                                               field_name=["call_forward","enabled"] 
                                   delegate="mod_kazoo"
                         }
        %}
      </div>
    {% else %}
      <div>
        {% button class="col-xs-12 btn btn-zprimary mb-1"
                  text=_"Enable"
                  action={postback postback={enable_doc type doc_id field_name}
                                   inject_args type="device"
                                               doc_id=device_id
                                               field_name=["call_forward","enabled"]
                                   delegate="mod_kazoo"
                         }
        %}
      </div>
    {% endif %}
  </div>
  <div class="col-xs-2">
    <div>
      {% button class="col-xs-12 btn btn-zalarm mb-1"
                text=_"Delete"
                action={confirm text="Do you really want to delete this device?"
                                action={postback postback={delete_device device_id}
                                                 inject_args device_id=device_id
                                                 delegate="mod_kazoo"
                                       }
                                action={dialog_close}
                       }
      %}
    </div>
  </div>
  <div class="col-xs-2">
    <div>
      {% button class="col-xs-12 btn btn-zprimary mb-1" text=_"Close" action={dialog_close} %}
    </div>
  </div>
</div>
