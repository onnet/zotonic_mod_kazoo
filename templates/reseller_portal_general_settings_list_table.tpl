{% if m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}
<table class="table table-condensed table-hover table-centered">
    <thead>
        <tr>
            <th style="width: 40%;"class="text-center1">{_ Reseller's name _}</th>
            <th class="text-left">
              <span id="sender_name">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["sender_name"] account_id=account_id %}
              </span>
            </th>
        </tr>
        <tr>
            <th style="width: 40%;"class="text-center1">{_ Account language _}</th>
            <th class="text-left">
             <span id="language">
                {% include "_show_field_select.tpl" type="account" doc_id="_no_need_" field_name="language" options=["en-us","ru-ru","fr-fr"] %}
             </span>
            </th>
        </tr>
        <tr>
            <th class="text-center1">{_ Account timezone _}</th>
            <th class="text-left">
             <span id="general_timezone">
                {% include "_show_field_select.tpl" type="account" doc_id="_no_need_" field_name="timezone" options=m.kazoo.tz_list prefix="general_" postfix="_bootsearch" %}
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
