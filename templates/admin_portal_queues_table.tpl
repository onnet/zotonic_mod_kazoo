{% if m.kazoo[{ui_element_opened element="ap_queues_widget_opened"}] %}
<table id="admin_portal_queues_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center1;">{_ List name _}</th>
      <th style="text-align: center;">{_ Description _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for queue in m.kazoo[{queues account_id=account_id}] %}
      <tr>
        <td style="text-align: center1;">
          {{ queue[1]["name"] }}
        </td>
        <td style="text-align: center1;">
          {{ queue[1]["description"] }}
        </td>
        <td style="text-align: center;">
          <i id="edit_entries_{{ queue[1]["id"] }}"
             class="fa fa-edit pointer"
             title="{_ Edit _}"></i>
          {% wire id="edit_entries_"++queue[1]["id"]
                  action={dialog_open title=_"Edit"++" "++queue[1]["name"]
                                      template="_edit_queue_lazy.tpl"
                                      queue_id=queue[1]["id"]
                                      width="auto"
                         }
          %}
        </td>
        <td style="text-align: center;">
          <i id="info_{{ queue[1]["id"] }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++queue[1]["id"]
                  action={dialog_open title=_"Queue details"
                                      template="_details_queue.tpl"
                                      queue_id=queue[1]["id"]
                                      width="auto"
                         }
          %}
        </td>
        <td style="text-align: center;">
          <i id="delete_{{ queue[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++queue[1]["id"]
                action={confirm text=_"Do you really want to delete queue "++queue[1]["name"]++"?"
                                action={postback postback={delete_queue queue_id=queue[1]["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_queues_table').dataTable({
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
  ]
});
{% endjavascript %}
{% endif %}
