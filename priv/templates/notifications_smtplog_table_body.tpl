<table id="rs_notifications_smtplog_table"
       class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="text-center">{_ Date _}</th>
      <th class="text-center">{_ To _}</th>
      <th class="text-center">{_ Subject _}</th>
      <th class="text-center">{_ Details _}</th>
    </tr>
  </thead>
  <tbody>
    {% for notification in m.kazoo.notifications_smtplog %}
      <tr>
        <td class="text-center">
          {{
            notification[1]["created"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone
          }}
        </td>
        <td class="text-center">{{ notification[1]["to"] }}</td>
        <td class="text-center">
          {{ notification[1]["subject"]|truncate:19 }}
        </td>
        <td style="text-align: center;">
          <i id="info_{{ notification[1]["id"]|cleanout }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++notification[1]["id"]|cleanout
                  action={dialog_open title=_"Notification details"
                                      template="_notifications_smtp_log_details.tpl"
                                      notification_id=notification[1]["id"]
                                      notification_created=notification[1]["created"]
                                      width="auto"
                         }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#rs_notifications_smtplog_table').dataTable({
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
