<table id="rs_per_minute_calls_lists_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="td-center">{_ Date _}</th>
      <th class="td-center">{_ From _}</th>
      <th class="td-center">{_ To _}</th>
      <th class="td-center">{_ Duration _}</th>
      <th class="td-center">{_ Sum _}</th>
      <th class="td-center"></th>
    </tr>
  </thead>
  <tbody>
    {% for ledger in m.kazoo[{kz_list_ledgers account_id=account_id
                                              selected_billing_period=selected_billing_period
                                              ledger_id="per-minute-voip"
                            }]
    %}
      <tr id={{ ledger[1]["id"] }}
          {% if ledger[1]["subscription_id"] %}
            style="cursor: pointer;"
          {% endif %}>
        <td class="td-center">
          {{ ledger[1]["period"][1]["start"]|gregsec_to_date|date:"Y-m-d H:i T":timezone }}
        </td>
        <td class="td-center">{{ ledger[1]["metadata"][1]["caller_id_number"] }}</td>
        <td class="td-center">{{ ledger[1]["metadata"][1]["callee_id_number"] }}</td>
        <td class="td-center">{{ (ledger[1]["usage"][1]["quantity"]/60)|to_integer }} {_ min _}</td>
        <td class="td-center">
          {{ m.config.mod_kazoo.local_currency_sign.value }}{{ ledger[1]["amount"]|format_price:[".",""] }}
        </td>
        <td style="text-align: center;">
          <i id="info_{{ ledger[1]["id"] }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++ledger[1]["id"]
                  action={dialog_open title=ledger[1]["metadata"][1]["caller_id_number"]
                                            ++" <i class='fa fa-long-arrow-right'></i> "
                                            ++ledger[1]["metadata"][1]["callee_id_number"]
                                            ++" "
                                            ++ledger[1]["metadata"][1]["rate"][1]["description"]
                                      template="_details.tpl"
                                      arg=ledger
                         }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_per_minute_calls_lists_table').dataTable({
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
