<div class="row">
  <br />
  <div class="col-sm-10">
    <!-- Username field -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">{_ Username _}</label></div>
      <div id="edit_username" class="col-xs-7 zalarm">{{ user_doc["username"] }}</div>
    </div>
    <!-- User status -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">{_ User status _}</label></div>
      <div id="user_enabled_status" class="col-xs-7">
        {% if user_doc["enabled"] %}
          <span class="zprimary">Enabled</span>
        {% else %}
          <span class="zalarm">Disabled</span>
        {% endif %}
      </div>
    </div>
    <!-- First Name field -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">{_ First Name _}</label></div>
      <div id="first_name" class="col-xs-7">
        {% wire id="edit_first_name"
                type="click"
                action={update target="first_name"
                               template="_edit_field.tpl"
                               type="user"
                               doc_id=user_id
                               field_name="first_name"
                        }
        %}
        <span>
          {{ user_doc["first_name"] }}
          <i id="edit_first_name" class="fa fa-edit pointer" title="Edit field"></i>
        </span>
      </div>
    </div>
    <!-- Last Name field -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">{_ Last Name _}</label></div>
      <div id="last_name" class="col-xs-7">
        {% wire id="edit_last_name"
                type="click"
                action={update target="last_name"
                               template="_edit_field.tpl"
                               type="user"
                               doc_id=user_id
                               field_name="last_name"
                       }
        %}
        <span>
          {{ user_doc["last_name"] }}
          <i id="edit_last_name" class="fa fa-edit pointer" title="Edit field"></i>
        </span>
      </div>
    </div>
    <!-- Email field -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">{_ Email _}</label></div>
      <div id="email" class="col-xs-7">
        {# wire id="edit_email"
                type="click"
                action={update target="email"
                               template="_edit_field.tpl"
                               type="user"
                               doc_id=user_id
                               field_name="email"
                       }
        #}
        <span>
          {{ user_doc["email"] }}
          <i id="edit_email"
             class="fa fa-info-circle pointer"
             title="{_ In order to replace email address change username _}"></i>
        </span>
      </div>
    </div>
    <!-- User privilege level -->
    <div class="row">
      <div class="col-xs-5">
        <label class="edit_user_label">{_ User privilege level _}</label>
      </div>
      <div id="priv_level" class="col-xs-7">
        {% wire id="edit_priv_level"
                type="click"
                action={update target="priv_level"
                               template="_edit_field_select.tpl"
                               type="user"
                               doc_id=user_id
                               field_name="priv_level"
                               options=["admin","user"]
                       }
        %}
        <span>
          {{ user_doc["priv_level"] }}
          <i id="edit_priv_level" class="fa fa-edit pointer" title="Edit field"></i>
        </span>
      </div>
    </div>
    <!-- Email Notifications -->
    <div class="row">
      <div class="col-xs-5"><label class="edit_user_label">{_ Email Notifications _}</label></div>
      <div class="col-xs-7">
        <div>
          Voicemail
          <span id="vm_to_email_enabled">
            <i id="toggle_vm_to_email_enabled"
               class="fa fa-toggle-{% if user_doc["vm_to_email_enabled"] %}on{% else %}off{% endif %} pointer"></i>
            {% wire id="toggle_vm_to_email_enabled"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name account_id}
                                     inject_args type="user"
                                                 doc_id=user_id
                                                 field_name="vm_to_email_enabled"
                                                 account_id=account_id
                                     delegate="mod_kazoo"
                           }
            %}
          </span>
        </div>
        <div>
          Fax to email
          <span id="fax_to_email_enabled">
            <i id="toggle_fax_to_email_enabled"
               class="fa fa-toggle-{% if user_doc["fax_to_email_enabled"] %}on{% else %}off{% endif %} pointer"></i>
            {% wire id="toggle_fax_to_email_enabled"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name account_id}
                                     inject_args type="user"
                                                 doc_id=user_id
                                                 field_name="fax_to_email_enabled"
                                                 account_id=account_id
                                     delegate="mod_kazoo"
                           }
            %}
          </span>
        </div>
      </div>
    </div>
    <!-- Timezone -->
    <div class="row">
      <div class="col-xs-5">
        <label class="edit_user_label">{_ Timezone _}</label>
      </div>
      <div id="user_timezone" class="col-xs-7">
        {% include "_show_field_select.tpl" type="user"
                                            doc_id=user_id
                                            field_name="timezone"
                                            options=m.kazoo.tz_list
                                            prefix="user_"
                                            postfix="_bootsearch"
        %}
      </div>
    </div>
    <!-- T.38 Flag -->
    <div class="row">
      <div class="col-xs-5">
        <label class="edit_user_label">T.38</label>
      </div>
      <div id="mediafax_option" class="col-xs-5">
        <i id="toggle_mediafax_option"
           class="fa fa-toggle-{% if user_doc["media"][1]["fax_option"] == "true" %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_mediafax_option"
                type="click"
                action={postback postback={toggle_field type doc_id field_name account_id}
                                 delegate="mod_kazoo"
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name=["media","fax_option"]
                                             account_id=account_id
                       }
        %}
      </div>
    </div>
    <!-- Dialplan -->
    <div class="row">
      <div class="col-xs-5">
        <label class="edit_user_label">{_ Dialplan _}</label>
      </div>
      <div id="user_dial_plansystem" class="col-xs-7">
        {% include "_show_field_select.tpl" type="user"
                                            doc_id=user_id
                                            field_name=["dial_plan","system"]
                                            options=m.kazoo.list_system_dialplans_names
                                            prefix="user_"
                                            postfix="_bootsearch"
        %}
      </div>
    </div>
    <!-- MOH -->
    <div class="row">
      <div class="col-xs-5">
        <label class="edit_user_label">{_ Music on hold _}</label>
      </div>
      <div id="user_music_on_holdmedia_id" class="col-xs-7">
        {% include "_show_field_select.tpl" type="user"
                                            doc_id=user_id
                                            field_name=["music_on_hold","media_id"]
                                            options=m.kazoo.kz_list_account_media_short
                                            prefix="user_"
                                            postfix="_bootsearch"
        %}
      </div>
    </div>
    <!-- Record calls -->
    <div class="row">
      <div class="col-xs-5">
        <label class="edit_user_label">{_ Record calls _}</label>
      </div>
      <div id="user_record_call" class="col-xs-7">
        <i id="toggle_user_record_call"
          class="fa fa-toggle-{% if user_doc["record_call"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_user_record_call"
                type="click"
                action={postback postback={toggle_field type doc_id field_name prefix account_id}
                                 inject_args type="user"
                                             doc_id=user_id
                                             field_name="record_call"
                                             prefix="user_"
                                             account_id=account_id
                                 delegate="mod_kazoo"
                       }
        %}
      </div>
    </div>
    <br />
  </div>
  <div class="col-xs-2" id="user_enable_control">
    {% if user_doc["enabled"] %}
      <div>
        {% button class="col-xs-12 btn btn-zalarm mb-1 long-text"
                  text=_"Disable"
                  action={postback postback={disable_doc type doc_id field_name}
                                   inject_args type="user"
                                               doc_id=user_id
                                               field_name="enabled" 
                                   delegate="mod_kazoo"
                         }
        %}
      </div>
    {% else %}
      <div>
        {% button class="col-xs-12 btn btn-zprimary mb-1 long-text"
                  text=_"Enable"
                  action={postback postback={enable_doc type doc_id field_name}
                                   inject_args type="user"
                                               doc_id=user_id
                                               field_name="enabled"
                                   delegate="mod_kazoo"
                         }
        %}
      </div>
    {% endif %}
  </div>
  <div class="col-xs-2">
    <div>
      {% button class="col-xs-12 btn btn-zalarm mb-1 long-text"
                text=_"Delete"
                action={confirm text="Do you really want to delete this user?"
                                action={postback postback={delete_user user_id}
                                                 inject_args user_id=user_id
                                                 delegate="mod_kazoo"
                                       }
                                action={dialog_close}
                       }
      %}
    </div>
  </div>
  <div class="col-xs-2">
    <div>
      {% button class="col-xs-12 btn btn-zprimary mb-1 long-text" text=_"Close"  action={dialog_close} %}
    </div>
  </div>
</div>
