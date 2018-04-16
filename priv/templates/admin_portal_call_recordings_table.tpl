{# if m.kazoo[{ui_element_opened element="ap_recordings_list_widget_opened"}] #}
<table id="admin_portal_call_recordings_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;">{_ Date _}</th>
      <th style="text-align: center;">{_ From _}</th>
      <th style="text-align: center;">{_ To _}</th>
      <th style="text-align: center;">{_ Duration _}</th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% with m.kazoo.get_user_timezone as user_timezone %}
      {% for recording in m.kazoo.list_account_recordings %}
          {% include "admin_recordings_table_line.tpl" recording=recording[1] timezone=user_timezone %}
      {% endfor %}
    {% endwith %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_call_recordings_table').dataTable({
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

});
{% endjavascript %}
{# endif #}
