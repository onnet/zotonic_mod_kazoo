    <div class="row">
    <br />
    <div class="col-sm-10">
    <!-- Username field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Username _}</label></div>
        <div id="edit_username" class="col-xs-5 zalarm">{{ user_doc["username"] }}</div>
    </div>
    <!-- User status -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ User status _}</label></div>
        <div id="user_enabled_status" class="col-xs-5">{% if user_doc["enabled"] %}<span class="zprimary">Enabled</span>{% else %}<span class="zalarm">Disabled</span>{% endif %}</div>
    </div>
    <!-- First Name field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ First Name _}</label></div>
        <div id="first_name" class="col-xs-5">
            {% wire id="edit_first_name" type="click" action={ update target="first_name" template="_edit_field.tpl" type="user" doc_id=user_id field_name="first_name" } %}
            <span>
                {{ user_doc["first_name"] }}
                <i id="edit_first_name" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <!-- Last Name field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Last Name _}</label></div>
        <div id="last_name" class="col-xs-5">
            {% wire id="edit_last_name" type="click" action={ update target="last_name" template="_edit_field.tpl" type="user" doc_id=user_id field_name="last_name" } %}
            <span>
                {{ user_doc["last_name"] }}
                <i id="edit_last_name" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <!-- Email field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Email _}</label></div>
        <div id="email" class="col-xs-5">
            {% wire id="edit_email" type="click" action={ update target="email" template="_edit_field.tpl" type="user" doc_id=user_id field_name="email" } %}
            <span>
                {{ user_doc["email"] }}
                <i id="edit_email" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <!-- User privilege level -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ User privilege level _}</label></div>
        <div id="priv_level" class="col-xs-5">
            {% wire id="edit_priv_level" type="click" action={ update target="priv_level" template="_edit_field_select.tpl" type="user" doc_id=user_id field_name="priv_level" options=["admin","user"] } %}
            <span>
                {{ user_doc["priv_level"] }}
                <i id="edit_priv_level" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <!-- Email Notifications -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Email Notifications _}</label></div>
        <div class="col-xs-5">
        <div>
            Voicemail
            <span id="vm_to_email_enabled">
                {% if user_doc["vm_to_email_enabled"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
                <i id="toggle_vm_to_email_enabled" class="fa fa-refresh pointer" title="Change"></i>
                {% wire id="toggle_vm_to_email_enabled" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                              delegate="mod_kazoo"
                                                                              inject_args type="user" doc_id=user_id field_name="vm_to_email_enabled"}
                %}
            </span>
        </div>
        <div>
            Fax
            <span id="fax_to_email_enabled">
                {% if user_doc["fax_to_email_enabled"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
                <i id="toggle_fax_to_email_enabled" class="fa fa-refresh pointer" title="Change"></i>
                {% wire id="toggle_fax_to_email_enabled" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                              delegate="mod_kazoo"
                                                                              inject_args type="user" doc_id=user_id field_name="fax_to_email_enabled"}
                %}
            </span>
        </div>
        </div>
    </div>
    <!-- Timezone -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Timezone _}</label></div>
        <div id="timezone" class="col-xs-5">
            {% wire id="edit_timezone" type="click" action={ update target="timezone" template="_edit_field_select.tpl" type="user" doc_id=user_id field_name="timezone" options=m.kazoo.tz_list } %}
            <span>
                {{ user_doc["timezone"] }}
                <i id="edit_timezone" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <br />
    </div>
    <div class="col-xs-2" id="user_enable_control">
        {% if user_doc["enabled"] %}
            <div>
                {% button class="col-xs-12 btn btn-zalarm mb-1 long-text" text=_"Disable" action={ postback postback={disable_doc type doc_id field_name}
                                                                                                        inject_args type="user" doc_id=user_id field_name="enabled" 
                                                                                                        delegate="mod_kazoo"}
                %}
            </div>
        {% else %}
            <div>
                {% button class="col-xs-12 btn btn-zprimary mb-1 long-text" text=_"Enable" action={ postback postback={enable_doc type doc_id field_name}
                                                                                                   inject_args type="user" doc_id=user_id field_name="enabled"
                                                                                                   delegate="mod_kazoo"}
                %}
            </div>
        {% endif %}
    </div>
    <div class="col-xs-2">
        <div>
            {% button class="col-xs-12 btn btn-zalarm mb-1 long-text" text=_"Delete"  action={confirm text="Do you really want to delete this user?"
                                                                                                   action={ postback postback={delete_user user_id} inject_args user_id=user_id delegate="mod_kazoo"}
                                                                                                   action={dialog_close}
                                                                                          }
            %}
        </div>
    </div>
    <div class="col-xs-2">
        <div>
            {% button class="col-xs-12 btn btn-zprimary mb-1 long-text" text=_"Close"  action={ dialog_close } %}
        </div>
    </div>
    </div>

