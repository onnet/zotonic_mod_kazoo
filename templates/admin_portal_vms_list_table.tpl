{% if m.kazoo[{ui_element_opened element="ap_vms_widget_opened"}] %}
<table id="admin_portal_vms_table" class="table display table-striped table-condensed">
  <thead>
      <tr>
        <th style="text-align: center;">{_ Box _}</th>
        <th style="text-align: center;">{_ Owner _}</th>
        <th style="text-align: center;">{_ Number _}</th>
        <th style="text-align: center;">{_ Msg. amount _}</th>
        <th style="text-align: center;"></th>
        <th style="text-align: center;"></th>
      </tr>
  </thead>
  <tbody>
    {% for vmbox in m.kazoo.kz_list_account_vmboxes %}
      {% with m.kazoo[{kz_list_user_vmbox_details vmbox_id=vmbox[1]["id"]}] as vmbox_details %}
      <tr>
        <td style="text-align: center;">{{ vmbox[1]["name"] }}</td>
        <td style="text-align: center;">
            {% if vmbox_details[1]["owner_id"] %}
                {{ m.kazoo[{kz_user_doc_by_ownerid
                            owner_id=vmbox_details[1]["owner_id"]}][1]["username"]
                            |truncate:13 }}
            {% else %}
                -
            {% endif %}
        </td>
        <td style="text-align: center;">{{ vmbox[1]["mailbox"] }}</td>
        <td style="text-align: center;">
            {% if vmbox[1]["messages"] == "0" %}
                {{ vmbox[1]["messages"] }}
            {% else %}
                {% wire id="purge_"++vmbox[1]["id"]
                        action={dialog_open title=_"Clean up Voicemail Box"++" "++vmbox[1]["name"]
                                            template="_cleanup_vmboxes.tpl"
                                            vmboxes=[vmbox]
                                            width="auto"
                               }
                %}
                <span id="purge_{{ vmbox[1]["id"] }}" class="pointer">
                  {{ vmbox[1]["messages"] }}
                </span>
            {% endif %}
        </td>
        <td style="text-align: center;">
          <i id="edit_{{ vmbox[1]["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i>
        </td>
        {% wire id="edit_"++vmbox[1]["id"]
                action={dialog_open title=_"Edit voicemail box"++" "++vmbox[1]["name"]
                                    template="_add_vm_dialog.tpl"
                                    vmbox_id=vmbox[1]["id"]
                                    width="auto"
                       }
        %}
        <td style="text-align: center;">
          <i id="delete_{{ vmbox[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++vmbox[1]["id"]
                action={confirm text=_"Do you really want to delete vmbox "++vmbox[1]["name"]++"?"
                                action={postback postback={delete_vmbox vmbox_id=vmbox[1]["id"]}
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
var oTable = $('#admin_portal_vms_table').dataTable({
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
{% endif %}

