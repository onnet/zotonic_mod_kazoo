{% if m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}
<table class="table table-condensed table-hover table-centered">
    <thead>
        <tr>
            <th class="text-center1">{_ Account language _}</th>
            <th class="text-left">
             <span id="language">
                {% include "_show_field_select.tpl" type="account" doc_id="_no_need_" field_name="language" options=["en-us","ru-ru","fr-fr"] %}
             </span>
            </th>
            <th class="text-center1">{_ All calls recording _}</th>
            <th>
              <span id="all_calls_recording_enabled">
                {% if account_doc[1]["preflow"][1]["always"] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
                <i id="toggle_all_calls_recording_enabled" class="fa fa-refresh pointer" title="Change"></i>
                {% wire id="toggle_all_calls_recording_enabled" type="click" action={ postback postback="toggle_all_calls_recording" delegate="mod_kazoo"} %}
              </span>
            </th>
        </tr>
        <tr>
            <th class="text-center1">{_ Account timezone _}</th>
            <th class="text-left">
             <span id="timezone">
                {% include "_show_field_select.tpl" type="account" doc_id="_no_need_" field_name="timezone" options=m.kazoo.tz_list %}
             </span>
            </th>
            <th class="text-center">{_  _}</th>
            <th>
            </th>
        </tr>
    </thead>
</table>
{% endwith %}
{% else %}
{% endif %}
