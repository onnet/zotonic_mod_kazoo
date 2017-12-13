{% if m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}
<table class="table table-condensed table-hover table-centered">
  <thead>
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Reseller's name _}</th>
      <th class="text-left">
        <span id="sender_name">
              {% include "_show_field.tpl" type="account"
                                           doc_id="_no_need_"
                                           field_name=["sender_name"]
                                           account_id=account_id
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
      <th class="text-center1">{_ Account timezone _}</th>
      <th class="text-left">
       <span id="general_timezone">
          {% include "_show_field_select.tpl" type="account"
                                              doc_id="_no_need_"
                                              field_name="timezone"
                                              options=m.kazoo.tz_list prefix="general_"
                                              postfix="_bootsearch"
          %}
       </span>
      </th>
    </tr>
    {% with m.onbill[{onbill_get_variables account_id=m.session.kazoo_account_id }]
       as onbill_variables
    %}
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Display billing widgets _}</th>
      <th class="text-left">
        <span id="display_billing">
          <i id="toggle_display_billing"
             class="fa
                    fa-toggle-{% if onbill_variables[1]["display_billing"] %}on{% else %}off{% endif %}
                    pointer"></i>
          {% wire id="toggle_display_billing"
                  type="click"
                  action={mask target="ap_general_settings_widget_opened"}
                  action={postback postback="refresh_billing_status_vars" delegate="mod_kazoo"}
                  action={postback postback={toggle_field type doc_id field_name account_id}
                                   delegate="mod_kazoo"
                                   inject_args type="onbill_variables"
                                               doc_id="_no_need_"
                                               field_name="display_billing"
                                               account_id=m.session.kazoo_account_id
                         }
          %}
        </span>
      </th>
    </tr>
{% print onbill_variables %}
    <tr>
      <th style="width: 40%;"class="text-center1">{_ Display E911 widgets _}</th>
      <th class="text-left">
        <span id="display_e911">
          <i id="toggle_display_e911"
             class="fa
                    fa-toggle-{% if onbill_variables[1]["display_e911"] %}on{% else %}off{% endif %}
                    pointer"></i>
          {% wire id="toggle_display_e911"
                  type="click"
                  action={mask target="ap_general_settings_widget_opened"}
                  action={postback postback="refresh_billing_status_vars" delegate="mod_kazoo"}
                  action={postback postback={toggle_field type doc_id field_name account_id}
                                   delegate="mod_kazoo"
                                   inject_args type="onbill_variables"
                                               doc_id="_no_need_"
                                               field_name="display_e911"
                                               account_id=m.session.kazoo_account_id
                         }
          %}
        </span>
      </th>
    </tr>
    {% endwith %}
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
{% endif %}
