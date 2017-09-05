{% if m.kazoo[{ui_element_opened element="ap_resources_widget_opened"}] %}
<table id="admin_portal_resources_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center1;">{_ Resource name _}</th>
      <th style="text-align: center;">{_ Weight cost _}</th>
      <th style="text-align: center;">{_ Enabled _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for resource in m.kazoo.kz_list_account_resources %}
      <tr>
        <td style="text-align: center1;">{{ resource[1]["name"] }}</td>
        {% wire id="toggle_resource_"++resource[1]["id"]
                action={confirm text=_"Do you really want to change this setting?"
                                action={postback postback={toggle_resource resource_id=resource[1]["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
        <td style="text-align: center;">{{ resource[1]["weight_cost"] }}</td>
        <td style="text-align: center;">
          {% if resource[1]["enabled"] %}
            <i id="toggle_resource_{{ resource[1]["id"] }}"
                class="fa fa-check zprimary pointer"
                title="Active"></i>
          {% else %}
            <i id="toggle_resource_{{ resource[1]["id"] }}"
               class="fa fa-remove zalarm pointer"
               title="Deactivated"></i>
          {% endif %}
        </td>
        <td style="text-align: center;">
          <i id="edit_{{ resource[1]["id"] }}"
             class="fa fa-edit pointer"
             title="{_ Edit _}"></i>
        </td>
        {% wire id="edit_"++resource[1]["id"]
                action={dialog_open title=_"Edit route"++" "++resource[1]["name"]
                                    template="_edit_resource_lazy.tpl"
                                    resource_id=resource[1]["id"]
                                    width="auto"
                       }
        %}
        <td style="text-align: center;">
          <i id="delete_{{ resource[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++resource[1]["id"]
                action={confirm text=_"Do you really want to delete route"
                                        ++" "
                                        ++resource[1]["name"]
                                        ++"?"
                                action={postback postback={delete_resource resource_id=resource[1]["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
        <td style="text-align: center;">
          <i id="info_{{ resource[1]["id"] }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++resource[1]["id"]
                  action={dialog_open title=_"Registration details"
                                      template="_resource_details.tpl"
                                      resource_id=resource[1]["id"]
                         }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_resources_table').dataTable({
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
