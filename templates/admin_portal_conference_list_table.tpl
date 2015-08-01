{% if m.kazoo[{ui_element_opened element="ap_conference_widget_opened"}] %}
<table id="admin_portal_conference_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center1;">{_ Group name _}</th>
            <th style="text-align: center;">{_ Numbers _}</th>
            <th style="text-align: center;">{_ Play name _}</th>
            <th style="text-align: center;">{_ Muted _}</th>
            <th style="text-align: center;"></th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody>
        {% for conference in m.kazoo.kz_list_account_conferences %}
        {% with m.kazoo[{kz_get_account_conference conference_id=conference["id"]}] as conference_details %}
	<tr>
            <td style="text-align: center1;">{{ conference["name"] }}</td>
            <td style="text-align: center;">{% for number in conference_details[1]["member"][1]["numbers"] %}{{ number }}{% if not forloop.last %}, {% endif %}{% endfor %}</td>
            <td style="text-align: center;">
              {% if conference_details[1]["play_name"] %}
                <i class="fa fa-check zprimary" title="Enabled">
              {% else %}
                <i class="fa fa-remove zalarm" title="Disabled">
              {% endif %}
            </td>
            <td style="text-align: center;">
              {% if conference_details[1]["member"][1]["join_muted"] %}
                <i class="fa fa-check zprimary" title="Enabled">
              {% else %}
                <i class="fa fa-remove zalarm" title="Disabled">
              {% endif %}
            </td>
            <td style="text-align: center;"><i id="edit_{{ conference["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++conference["id"] action={ dialog_open title=_"Edit conference "++conference["name"] template="_edit_conference_lazy.tpl" conference_id=conference["id"] } %}
            <td style="text-align: center;"><i id="delete_{{ conference["id"] }}" class="fa fa-trash-o pointer" title="{_ Delete _}"></i></td>
            {% wire id="delete_"++conference["id"]
                    action={confirm text=_"Do you really want to delete conference "++conference["name"]++"?"
                                action={postback postback={delete_conference conference_id=conference["id"]} delegate="mod_kazoo"}
                           }
            %}
        </tr>
        {% endwith %}
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_conference_table').dataTable({
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

