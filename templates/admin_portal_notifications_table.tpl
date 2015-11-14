{% if m.kazoo[{ui_element_opened element="ap_notifications_widget_opened"}] %}
<table id="admin_portal_notifications_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center1;">{_ Template name _}</th>
            <th style="text-align: center;">{_ Category _}</th>
            <th style="text-align: center;">{_ Modified _}</th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody>
        {% for notification in m.kazoo.kz_list_account_notifications %}
	<tr>
            <td style="text-align: center1;">{{ notification["friendly_name"] }}</td>
            <td style="text-align: center;">{{ notification["category"] }}</td>
            {% wire id="toggle_notification_"++notification["id"] action={confirm text=_"Do you really want to change this setting?"
                                                                            action={ postback postback={toggle_notification notification_id=notification["id"]} delegate="mod_kazoo"}
                                                                    }
            %}
            <td style="text-align: center;">
             {% if notification["enabled"] %}
                <i id="toggle_notification_{{ notification["id"] }}" class="fa fa-check zprimary pointer" title="Active">
             {% else %}
                <i id="toggle_notification_{{ notification["id"] }}" class="fa fa-remove zalarm pointer" title="Deactivated">
             {% endif %}
            </td>
            <td style="text-align: center;"><i id="edit_{{ notification["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++notification["id"] action={ dialog_open title=_"Edit template"++" "++notification["name"]
                                                                        template="_edit_notification_lazy.tpl" notification_id=notification["id"] width="auto" } %}
        </tr>
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_notifications_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
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

