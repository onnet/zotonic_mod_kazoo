<table id="rs_account_registrations_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th class="text-center">{_ Username _}</th>
            <th class="text-center">{_ User agent _}</th>
            <th class="text-center">{_ Contact IP _}</th>
            <th class="text-center">{_ Details _}</th>
        </tr>
    </thead>
    <tbody>
        {% for device in m.kazoo[{get_registrations_by_accountid account_id=account_id}] %}
          <tr>
             <td class="text-center">{{ device["username"] }}</td>
             <td class="text-center">{{ device["user_agent"]|truncate:19 }}</td>
             <td class="text-center"><a target="_blank" href='https://{{ device["contact_ip"] }}'>{{ device["contact_ip"] }}</a></td>
             <td style="text-align: center;">
                    <i id="info_{{ device["username"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>
                    {% wire id="info_"++device["username"] action={ dialog_open title=_"Registration details" template="_details.tpl" arg=device } %}
             </td>
          </tr>
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#rs_account_registrations_table').dataTable({
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

