<table id="rs_tasks_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="text-center">{_ Date _}</th>
      <th class="text-center">{_ Category _}</th>
      <th class="text-center">{_ Action _}</th>
      <th class="text-center">{_ Status _}</th>
      <th class="text-center">{_ Details _}</th>
    </tr>
  </thead>
  <tbody>
    {% for task in m.kazoo.account_tasks %}
      <tr>
        <td class="text-center">{{ task["created"]|inno_timestamp_to_date }}</td>
        <td class="text-center">{{ task["category"]|truncate:13 }}</td>
        <td class="text-center">{{ task["action"]|truncate:13 }}</td>
        <td class="text-center">{{ task["status"] }}</td>
        <td style="text-align: center;">
          {% if task["csvs"] %}
            <i class="fa fa-download zprimary pointer" title="{_ Download _}"></i>
          {% endif %}
          <i id="info_{{ notification["id"]|cleanout }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>
          {% wire id="info_"++notification["id"]|cleanout
                  action={dialog_open title=_"Notification details"
                                      template="_notifications_smtp_log_details.tpl"
                                      notification_id=notification["id"]
                                      notification_created=notification["created"]
                                      width="auto"
                         }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#rs_tasks_table').dataTable({
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

