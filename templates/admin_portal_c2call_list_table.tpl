{% if m.kazoo[{ui_element_opened element="ap_c2call_widget_opened"}] %}
<table id="admin_portal_c2call_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center1;">{_ Name _}</th>
            <th style="text-align: center;">{_ Extension _}</th>
            <th style="text-align: center;">{_ Dial first _}</th>
            <th style="text-align: center;">{_ Auth _}</th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody>
        {% for c2call in m.kazoo.kz_list_account_c2calls %}
        {% with m.kazoo[{kz_get_account_c2call c2call_id=c2call["id"]}] as c2call_details %}
	<tr>
            <td style="text-align: center1;">{{ c2call["name"] }}</td>
            <td style="text-align: center;">{{ c2call_details[1]["extension"] }}</td>
            <td style="text-align: center;">{{ c2call_details[1]["dial_first"] }}</td>
            <td style="text-align: center;">
              {% if c2call_details[1]["auth_required"] %}
                <i class="fa fa-check zprimary" title="Enabled"></i>
              {% else %}
                <i class="fa fa-remove zalarm" title="Disabled"></i>
              {% endif %}
            </td>
            <td style="text-align: center;"><i id="info_{{ c2call["id"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Current information _}"></i></td>
            {% wire id="info_"++c2call["id"] action={ dialog_open title=c2call["name"]
                                                                  template="_c2call_details.tpl"
                                                                  c2call_id=c2call["id"]
                                                    }
             %}
            <td style="text-align: center;"><i id="edit_{{ c2call["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++c2call["id"] action={ dialog_open title=_"Edit" ++ " " ++ c2call["name"] template="_edit_c2call_lazy.tpl" c2call_id=c2call["id"] width="auto" } %}
            <td style="text-align: center;"><i id="delete_{{ c2call["id"] }}" class="fa fa-trash-o pointer" title="{_ Delete _}"></i></td>
            {% wire id="delete_"++c2call["id"]
                    action={confirm text=_"Do you really want to delete c2call "++c2call["name"]++"?"
                                action={postback postback={delete_c2call c2call_id=c2call["id"]} delegate="mod_kazoo"}
                           }
            %}
        </tr>
        {% endwith %}
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_c2call_table').dataTable({
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

