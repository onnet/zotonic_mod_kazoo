{% if m.kazoo[{ui_element_opened element="conference_participants_widget_opened"}] %}
<table id="conference_current_participants_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center;">{_ Join time _}</th>
            <th style="text-align: center;">{_ Participant _}</th>
            <th style="text-align: center;">{_ Talking _}</th>
            <th style="text-align: center;">{_ Microphone _}</th>
            <th style="text-align: center;">{_ Speaker _}</th>
            <th style="text-align: center;">{_ Kick off _}</th>
            <th style="text-align: center;"></th>
        </tr>
    </thead>
    <tbody id="conference_current_participants_table_tbody">
        {% for participant in m.kazoo[{kz_conference_participants conference_id=conference_id}] %}
          {% include "_conference_participants_table_line.tpl" conference_id=conference_id participant_id=participant["participant_id"] %}
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#conference_current_participants_table1').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "{_ All _}"]],
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

