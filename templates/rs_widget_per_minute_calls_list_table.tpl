<table id="rs_per_minute_calls_lists_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="td-center">{_ Date _}</th>
      <th class="td-center">{_ From _}</th>
      <th class="td-center">{_ To _}</th>
      <th class="td-center">{_ Duration _}</th>
      <th class="td-center">{_ Sum _}</th>
    </tr>
  </thead>
  <tbody>
    {% for ledger in m.kazoo[{kz_list_ledgers account_id=account_id payments_month_chosen=payments_month_chosen ledger_id="per-minute-voip"}] %}
      <tr id={{ ledger["id"] }} {% if ledger["subscription_id"] %}style="cursor: pointer;"{% endif %}>
        <td class="td-center">
          {{ ledger["period"][1]["start"]|inno_timestamp_to_date }}
          {{ ledger["period"][1]["start"]|inno_timestamp_to_date:"show_tz_name" }}
        </td>
        <td class="td-center">{{ ledger["metadata"][1]["caller_id_number"] }}</td>
        <td class="td-center">{{ ledger["metadata"][1]["callee_id_number"] }}</td>
        <td class="td-center">{{ (ledger["usage"][1]["quantity"]/60)|to_integer }} {_ min _}</td>
        <td class="td-center">
          {{ m.config.mod_kazoo.local_currency_sign.value }}{{ ledger["amount"]|format_price:[".",""] }}
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

});

{% endjavascript %}

