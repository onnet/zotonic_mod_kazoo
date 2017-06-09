{% if m.kazoo[{ui_element_opened element="ap_lists_widget_opened"}] %}
{% with m.kazoo[{kz_doc_field type="account" doc_id=" " field="lists"}] as lists %}
<table id="admin_portal_lists_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center1;">{_ List name _}</th>
      <th style="text-align: center;">{_ Description _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for list in m.kazoo.kz_list_account_lists %}
      <tr>
        <td style="text-align: center1;">
          {{ list[1]["name"] }}
          <i id="edit_{{ list[1]["id"] }}"
             class="fa fa-edit pointer"
             title="{_ Edit _}"></i>
          {% wire id="edit_"++list[1]["id"]
                  action={dialog_open title=_"Edit list"++" "++list[1]["name"]
                                      template="_edit_list_lazy.tpl"
                                      list_id=list[1]["id"]
                                      width="auto"
                         }
          %}
        </td>
        <td style="text-align: center1;">
          {{ list[1]["description"] }}
        </td>
        <td style="text-align: center;">
          <i id="edit_entries_{{ list[1]["id"] }}"
             class="fa fa-edit pointer"
             title="{_ Edit entries _}"></i></td>
          {% wire id="edit_entries_"++list[1]["id"]
                  action={dialog_open title=_"Edit entries"++" "++list[1]["name"]
                                      template="_edit_list_entries_lazy.tpl"
                                      list_id=list[1]["id"]
                                      list_type=list[1]["list_type"]
                                      width="auto"
                         }
          %}
        <td style="text-align: center;">
          <i id="delete_{{ list[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++list[1]["id"]
                action={confirm text=_"Do you really want to delete list "++list[1]["name"]++"?"
                                action={postback postback={delete_list list_id=list[1]["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
      </tr>
    {% endfor %}
  </tbody>
</table>
{% endwith %}

{% javascript %}
var oTable = $('#admin_portal_lists_table').dataTable({
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
