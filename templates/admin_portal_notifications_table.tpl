{% if m.kazoo[{ui_element_opened element="ap_notifications_widget_opened"}] %}
<table id="admin_portal_notifications_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center;"></th>
            <th style="text-align: center1;">{_ Template name _}</th>
            <th style="text-align: center;">{_ Category _}</th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody>
        {% for notification in m.kazoo.kz_list_account_notifications %}
	<tr>
            <td style="text-align: center1;">
              {% if notification["account_overridden"] %}
                {% if notification["enabled"] == "false" %}
                  {% wire id="disabled_"++notification["id"] action={confirm text=_"Do you really want to enable this notification?"
                                                                                action={ postback postback={enable_notification notification_id=notification["id"]} delegate="mod_kazoo"}
                                                                        }
                  %}
                  <i id="disabled_{{ notification["id"] }}" class="fa fa-toggle-off pointer" title="{_ Disabled _}"></i>
                {% else %}
                  {% wire id="enabled_"++notification["id"] action={confirm text=_"Do you really want to disable this notification?"
                                                                                action={ postback postback={disable_notification notification_id=notification["id"]} delegate="mod_kazoo"}
                                                                        }
                  %}
                  <i id="enabled_{{ notification["id"] }}" class="fa fa-toggle-on pointer" title="{_ Enabled _}"></i>
                {% endif %}
              {% endif %}
            </td>
            <td style="text-align: center1;">{{ notification["friendly_name"] }}</td>
            <td style="text-align: center;">{{ notification["category"] }}</td>
            <td style="text-align: center;"><i id="edit_{{ notification["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++notification["id"] action={ dialog_open title=_"Edit settings"++":"++" "++notification["friendly_name"]
                                                                        template="_edit_notification_lazy.tpl" notification_id=notification["id"] width="auto" } %}
            <td style="text-align: center;"><i id="html_{{ notification["id"] }}" class="fa fa-html5 pointer" title="{_ Edit _}"></i></td>
            {% wire id="html_"++notification["id"] action={ dialog_open title=_"Edit html template"++":"++" "++notification["friendly_name"]
                                                                        template="_edit_notification_html.tpl" notification_id=notification["id"] width="auto" } %}
            <td style="text-align: center;"><i id="text_{{ notification["id"] }}" class="fa fa-file-text-o pointer" title="{_ Edit _}"></i></td>
            {% wire id="text_"++notification["id"] action={ dialog_open title=_"Edit txt template"++":"++" "++notification["friendly_name"]
                                                                        template="_edit_notification_text.tpl" notification_id=notification["id"] width="auto" } %}
            <td style="text-align: center;"><i id="sendmail_{{ notification["id"] }}" class="fa fa-envelope-o pointer" title="{_ Send test _}"></i></td>
            {% wire id="sendmail_"++notification["id"] action={ dialog_open title=_"Send test message"++":"++" "++notification["friendly_name"]
                                                                        template="_sendmail_test_notification.tpl" notification_id=notification["id"] width="auto" } %}
            <td style="text-align: center;">
             {% if notification["account_overridden"] %}
                <i id="toggle_notification_{{ notification["id"] }}" class="fa fa-files-o zalarm pointer" title="{_ Overridden _}"></i>
                {% wire id="toggle_notification_"++notification["id"] action={confirm text=_"Do you really want to discard this template changes?"
                                                                              action={ postback postback={remove_notification_template notification_id=notification["id"]} delegate="mod_kazoo"}
                                                                      }
                %}
             {% else %}
                <i class="fa fa-file-o zprimary" title="{_ System default _}"></i>
             {% endif %}
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_notifications_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 2, "asc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},
"columnDefs": [
],

});
{% endjavascript %}
{% else %}
{% endif %}

