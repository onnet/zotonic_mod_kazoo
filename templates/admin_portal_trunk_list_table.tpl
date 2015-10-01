{% if m.kazoo[{ui_element_opened element="ap_trunk_widget_opened"}] %}
<table id="admin_portal_trunk_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center1;">{_ Trunk Name _}</th>
            <th style="text-align: center;">{_ Auth method _}</th>
            <th style="text-align: center;">{_ Registration _}</th>
            <th style="text-align: center;">{_ Active _}</th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody>
        {% for trunk in m.kazoo.kz_list_account_trunks %}
        {% for server_details in m.kazoo[{kz_get_account_trunk trunk_id=trunk}][1]["servers"] %}
        {% with m.kazoo[{kz_registration_details_by_username username=server_details["auth"][1]["auth_user"]}] as reg_details %}
	<tr>
            <td style="text-align: center1;">{{ server_details["server_name"] }}</td>
            <td style="text-align: center;">{{ server_details["auth"][1]["auth_method"] }}</td>
            <td style="text-align: center;">
              {% if reg_details %}
                {% wire id="info_"++forloop.counter action={ dialog_open title=_"Registration details" template="_details.tpl" arg=reg_details } %}
                <i id="info_{{ forloop.counter }}" class="fa fa-info-circle zprimary pointer" title="Enabled">
              {% else %}
                <i class="fa fa-remove zalarm" title="Disabled">
              {% endif %}
            </td>
            <td style="text-align: center;">
              {% if trunk_details[1]["servers"][1][1]["options"][1]["enabled"] %}
                <i class="fa fa-check zprimary" title="Enabled">
              {% else %}
                <i class="fa fa-remove zalarm" title="Disabled">
              {% endif %}
            </td>
            <td style="text-align: center;"><i id="edit_{{ forloop.counter }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++forloop.counter action={ dialog_open title=_"Edit trunk "++server_details["server_name"] template="_edit_trunk_lazy.tpl"
                                                                     trunk_id=trunk server_index=forloop.counter width="auto"} %}
            <td style="text-align: center;"><i id="delete_{{ forloop.counter }}" class="fa fa-trash-o pointer" title="{_ Delete _}"></i></td>
            {% wire id="delete_"++forloop.counter
                    action={confirm text=_"Do you really want to delete trunk "++server_details["server_name"]++"?"
                                action={postback postback={delete_trunk trunk_id=trunk server_index=forloop.counter} delegate="mod_kazoo"}
                           }
            %}
        </tr>
        {% endwith %}
        {% endfor %}
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_trunk_table').dataTable({
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

