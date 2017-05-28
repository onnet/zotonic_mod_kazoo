{% if m.kazoo[{ui_element_opened element="ap_webhooks_widget_opened"}] %}
<table id="admin_portal_webhooks_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;">{_ Name _}</th>
      <th style="text-align: center;">{_ Hook _}</th>
      <th style="text-align: center;">{_ URL _}</th>
      <th style="text-align: center;">{_ Status _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for webhook in m.kazoo.kz_list_account_webhooks %}
      {% with m.kazoo[{kz_webhook_info webhook_id=webhook[1]["id"]}] as webhook_details %}
      <tr>
        <td style="text-align: center;">{{ webhook[1]["name"] }}</td>
        <td style="text-align: center;">{{ webhook[1]["hook"] }}</td>
        <td style="text-align: center;">{{ webhook[1]["uri"] }}</td>
        {% wire id="toggle_webhook_"++webhook[1]["id"]
                action={confirm text=_"Do you really want to change this setting?"
                                action={postback postback={toggle_webhook webhook_id=webhook[1]["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
        <td style="text-align: center;">
          {% if webhook[1]["enabled"] %}
            <i id="toggle_webhook_{{ webhook[1]["id"] }}"
               class="fa fa-check zprimary pointer"
               title="Active"></i>
          {% else %}
            <i id="toggle_webhook_{{ webhook[1]["id"] }}"
               class="fa fa-remove zalarm pointer"
               title="Deactivated"></i>
          {% endif %}
        </td>
        <td style="text-align: center;">
          <i id="edit_{{ webhook[1]["id"] }}"
             class="fa fa-edit pointer"
             title="{_ Edit _}"></i>
        </td>
        {% wire id="edit_"++webhook[1]["id"]
                action={dialog_open title=_"Edit webhook"++" "++webhook[1]["name"]
                                    template="_add_webhook_dialog.tpl"
                                    webhook_id=webhook[1]["id"]
                                    width="auto"
                       }
        %}
        <td style="text-align: center;">
          <i id="delete_{{ webhook[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++webhook[1]["id"]
                action={confirm text=_"Do you really want to delete webhook "++webhook[1]["name"]++"?"
                            action={postback postback={delete_webhook webhook_id=webhook[1]["id"]}
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
var oTable = $('#admin_portal_webhooks_table').dataTable({
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
  "columnDefs": [ ]
});
{% endjavascript %}
{% endif %}
