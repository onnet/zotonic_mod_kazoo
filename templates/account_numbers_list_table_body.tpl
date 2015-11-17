<table id="rs_numbers_list_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th class="text-center">{_ Number _}</th>
            <th class="text-center">{_ Allocated to _}</th>
        </tr>
    </thead>
    <tbody>
        {% for number in m.kazoo.get_acc_numbers_info %}
          <tr  id="number_line_{{ forloop.counter }}">
             <td class="text-center">{{ number[1] }}</td>
             <td class="text-center">{{ m.kazoo[{kz_doc_field type="account" doc_id="no_matter" field="name" account_id=number[2][1]["assigned_to"]}] }}</td>
          </tr>
        {% endfor %}
    </tbody>
</table>
{% javascript %}
var oTable = $('#rs_numbers_list_table').dataTable({
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

