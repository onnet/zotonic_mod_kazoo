{% if m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Main account number _}</th>
      <th class="text-left">
         <span id="account_caller_idexternalnumber">
            {% include "_show_field_select.tpl" type="account"
                                                doc_id="_no_need_"
                                                field_name=["caller_id","external","number"] 
                                                options=m.kazoo.get_acc_numbers
                                                prefix="account_"
                                                postfix="_bootsearch"
            %}
         </span>
      </th>
    </tr>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Account language _}</th>
      <th class="text-left">
         <span id="language">
            {% include "_show_field_select.tpl" type="account"
                                                doc_id="_no_need_"
                                                field_name="language"
                                                options=["en-us","ru-ru","fr-fr"]
            %}
         </span>
      </th>
    </tr>
    <tr>
      <th class="text-center1">{_ All calls recording _}</th>
      <th>
          <span id="account_record_call">
            <i id="toggle_account_record_call"
               class="fa fa-toggle-{% if account_doc[1]["record_call"] %}on{% else %}off{% endif %} pointer"></i>
            {% wire id="toggle_account_record_call"
                    type="click"
                    action={postback postback={toggle_field type doc_id field_name prefix account_id}
                                     delegate="mod_kazoo"
                                     inject_args type="account"
                                                 doc_id="_no_need_"
                                                 field_name="record_call"
                                                 prefix="account_"
                                                 account_id=account_id
                           }
            %}
          </span>
      </th>
    </tr>
    <tr>
      <th class="text-center1">{_ Account timezone _}</th>
      <th class="text-left">
         <span id="general_timezone">
            {% include "_show_field_select.tpl" type="account"
                                                doc_id="_no_need_"
                                                field_name="timezone"
                                                options=m.kazoo.tz_list
                                                prefix="general_"
                                                postfix="_bootsearch"
            %}
         </span>
      </th>
    </tr>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Music on hold _}</th>
      <th class="text-left">
         <span id="account_music_on_holdmedia_id">
            {% include "_show_field_select.tpl" type="account"
                                                doc_id="_no_need_"
                                                field_name=["music_on_hold","media_id"] 
                                                options=m.kazoo.kz_list_account_media_short
                                                prefix="account_"
                                                postfix="_bootsearch"
            %}
         </span>
      </th>
    </tr>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Dialplan _}</th>
      <th class="text-left">
         <span id="account_dial_plansystem">
            {% include "_show_field_select.tpl" type="account"
                                                doc_id="_no_need_"
                                                field_name=["dial_plan","system"] 
                                                options=m.kazoo.list_system_dialplans_names
                                                prefix="account_"
                                                postfix="_bootsearch"
            %}
         </span>
      </th>
    </tr>
    <tr>
      <th class="text-center1">{_ Outbound routing _}</th>
        <th class="text-left">
         <span id="account_outbound_routing_selection">
          {% include "_account_outbound_routing_selection.tpl" %}
         </span>
      </th>
    </tr>
  </thead>
</table>
{% endwith %}
{% else %}
{% endif %}
