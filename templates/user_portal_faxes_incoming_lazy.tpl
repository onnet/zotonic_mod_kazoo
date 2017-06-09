{% if m.kazoo[{ui_element_opened element="incoming_faxes_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}
<table id="user_portal_faxes_incoming_table"
       class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;">{_ Date _}</th>
      <th style="text-align: center; white-space: nowrap;">{_ Fax number _}</th>
      <th style="text-align: center;">{_ Status _}</th>
      <th style="text-align: center;">{_ D/L _}</th>
      <th style="text-align: center;" class="visible-lg">{_ Details _}</th>
      <th style="text-align: center;">{_ Delete _}</th>
    </tr>
  </thead>
  <tbody>
    {% for attempt in m.kazoo.kz_list_incoming_faxes %}
      {% if attempt["timestamp"] %}
        <tr>
          <td style="text-align: center; white-space: nowrap;">
            {{ attempt["timestamp"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}
          </td>
          <td style="text-align: center;">
            {{ attempt["from_number"]|pretty_phonenumber }}
          </td>
          <td style="text-align: center;">
            {% if attempt["rx_result"][1]["success"] %}{_ Success _}{% else %}{_ Failed _}{% endif %}
          </td>
          <td style="text-align: center;">
            <a href="/getinfaxdoc/id/{{ attempt["id"] }}"><i class="fa fa-download" title="{_ Download _}"></i></a>
          </td>
          <td style="text-align: center;">
            <i id={{ attempt["id"] }}
               style="cursor: pointer;"
               class="fa fa-info-circle zprimary pointer"
               title="{_ Details _}"></i>
          </td>
          <td style="text-align: center;">
            <i id="fax_delete_{{ attempt["id"] }}"
               style="cursor: pointer;"
               class="fa fa-trash-o"
               title="{_ Delete _}"></i>
          </td>
        </tr>
        {% wire id=attempt["id"]
                action={dialog_open title=_"Fax details" template="_details.tpl" arg=attempt}
        %}
        {% wire id="fax_delete_"++attempt["id"]
                action={confirm text=_"Do you really want to delete incoming fax from "
                                       ++attempt["from_number"]|pretty_phonenumber++"?"
                                action={postback postback={delete_incoming_fax fax_id=attempt["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
      {% endif %}
    {% endfor %}
  </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#user_portal_faxes_incoming_table').dataTable({
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

{% endwith %}
{% else %}
{% endif %}
