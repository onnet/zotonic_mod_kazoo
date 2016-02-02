    <div class="row">
    <br />
    <div class="col-sm-10">
    <!-- Device Nickname field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Device Nickname _}</label></div>
        <div id="name" class="col-xs-5">
            {% wire id="edit_name" type="click" action={ update target="name" template="_edit_field.tpl" type="device" doc_id=device_id field_name=["name"] } %}
            <span>
                {{ device_doc["name"] }}
                <i id="edit_name" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <!-- User status -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Device status _}</label></div>
        <div id="device_enabled_status" class="col-xs-5">{% if device_doc["enabled"] %}<span class="zprimary">Enabled</span>{% else %}<span class="zalarm">Disabled</span>{% endif %}</div>
    </div>

    <!-- Assign To -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Assign To _}</label></div>
        <div id="owner_id" class="col-xs-5">
            {% wire id="edit_owner_id" type="click" action={ update target="owner_id" 
                                                                    template="_edit_field_select.tpl" 
                                                                    type="device" doc_id=device_id field_name="owner_id" options=m.kazoo.kz_list_account_users_short } %}
            <span>
                {{ m.kazoo[{kz_doc_field type="user" doc_id=device_doc["owner_id"] field="first_name"}] }} {{ m.kazoo[{kz_doc_field type="user" doc_id=device_doc["owner_id"] field="last_name"}] }}
                <i id="edit_owner_id" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>



    <!-- Realm field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Realm _}</label></div>
        <div id="edit_realm" class="col-xs-5">{{ m.kazoo.get_account_realm }}</div>
    </div>
    <!-- Username field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Username _}</label></div>
        <div id="sipusername" class="col-xs-5">
            {% wire id="edit_sipusername" type="click" action={ update target="sipusername" template="_edit_field.tpl" type="device" doc_id=device_id field_name=["sip","username"] } %}
            <span>
                {{ device_doc["sip"][1]["username"] }}
                <i id="edit_sipusername" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </div>
    </div>
    <!-- Password field -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Password _}</label></div>
        <div class="col-xs-5">
        {% wire id="eye_sippassword" action={ toggle target="sippassword"} action={ toggle target="hiddensippassword"} %}
        <i id="eye_sippassword" class="fa fa-eye pointer" title="Display pasword"></i>
        <span id="hiddensippassword">**********</span>
        <span id="sippassword" style="display:none;">
            {% wire id="edit_sippassword" type="click" action={ update target="sippassword" template="_edit_field.tpl" type="device" doc_id=device_id field_name=["sip","password"] } %}
            <span>
                {{ device_doc["sip"][1]["password"] }}
                <i id="edit_sippassword" class="fa fa-edit pointer" title="Edit field"></i>
            </span>
        </span>
        </div>
    </div>
    <!-- T.38 Flag -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">T.38</label></div>
        <div id="mediafax_option" class="col-xs-5">
            {% if device_doc["media"][1]["fax_option"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
            <i id="toggle_mediafax_option" class="fa fa-refresh pointer" title="Change"></i>
            {% wire id="toggle_mediafax_option" type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                          delegate="mod_kazoo"
                                                                          inject_args type="device" doc_id=device_id field_name=["media","fax_option"]}
            %}
        </div>
    </div>
    <!-- MOH -->
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Music on hold _}</label></div>
        <div id="device_music_on_holdmedia_id" class="col-xs-5">
            {% include "_show_field_select.tpl" type="device" doc_id=device_id field_name=["music_on_hold","media_id"]
                                                options=m.kazoo.kz_list_account_media_short prefix="device_" postfix="_bootsearch" %}
        </div>
    </div>
    <br />
    </div>
    <div class="col-xs-2" id="device_enable_control">
        {% if device_doc["enabled"] %}
            <div>
                {% button class="col-xs-12 btn btn-zalarm mb-1 long-text" text=_"Disable"  action={ postback postback={disable_doc type doc_id field_name}
                                                                                                         inject_args type="device" doc_id=device_id field_name="enabled"
                                                                                                         delegate="mod_kazoo"}
                %}
            </div>
        {% else %}
            <div>
                {% button class="col-xs-12 btn btn-zprimary mb-1 long-text" text=_"Enable"  action={ postback postback={enable_doc type doc_id field_name}
                                                                                                    inject_args type="device" doc_id=device_id field_name="enabled"
                                                                                                    delegate="mod_kazoo"}
                %}
            </div>
        {% endif %}
    </div>
    <div class="col-xs-2">
        <div>
            {% button class="col-xs-12 btn btn-zalarm mb-1 long-text" text=_"Delete"  action={confirm text="Do you really want to delete this device?"
                                                                                                   action={ postback postback={delete_device device_id} inject_args device_id=device_id delegate="mod_kazoo"}
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

