{% if m.kazoo[{ui_element_opened element="ap_menus_widget_opened"}] %}
<table id="admin_portal_menus_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center1;">{_ Menu name _}</th>
      <th style="text-align: center;">{_ Retries _}</th>
      <th style="text-align: center;">{_ Timeout _}</th>
      <th style="text-align: center;">{_ Ext. length _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for menu in m.kazoo.kz_list_account_menus %}
      {% with m.kazoo[{kz_get_account_menu menu_id=menu[1]["id"]}] as menu_details %}
        <tr>
          <td style="text-align: center1;">{{ menu[1]["name"] }}</td>
          <td style="text-align: center;">{{ menu_details[1]["retries"] }}</td>
          <td style="text-align: center;">
            {{ (menu_details[1]["timeout"]/1000)|to_integer }}
          </td>
          <td style="text-align: center;">
            {{ menu_details[1]["max_extension_length"] }}
          </td>
          <td style="text-align: center;">
            <i id="edit_{{ menu[1]["id"] }}"
               class="fa fa-edit pointer"
               title="{_ Edit _}"></i>
          </td>
          {% wire id="edit_"++menu[1]["id"]
                  action={dialog_open title=_"Edit menu"++" "++menu[1]["name"]
                                      template="_edit_menu_lazy.tpl"
                                      menu_id=menu[1]["id"]
                                      width="auto"
                         }
          %}
          <td style="text-align: center;">
            <i id="delete_{{ menu[1]["id"] }}"
               class="fa fa-trash-o pointer"
               title="{_ Delete _}"></i>
          </td>
          {% wire id="delete_"++menu[1]["id"]
                  action={confirm text=_"Do you really want to delete menu "++menu[1]["name"]++"?"
                              action={postback postback={delete_menu menu_id=menu[1]["id"]}
                                               delegate="mod_kazoo"
                                     }
                         }
          %}
        </tr>
      {% endwith %}
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_menus_table').dataTable({
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
{% endif %}
