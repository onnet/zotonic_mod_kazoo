<table id="proforma_invoices_list_table" class="table display table-striped table-condensed">

  <thead>
    <tr>
      <th>{_ Type _}</th>
      <th class="td-center">{_ # _}</th>
      <th class="td-center">{_ Date _}</th>
      <th class="td-center">{_ Sum _}</th>
      <th class="td-center">{_ VAT _}</th>
      <th class="td-center">{_ Total _}</th>
      <th class="td-center"></th>
      <th class="td-center"></th>
    </tr>
  </thead>
  <tbody>
    {% for proforma_invoice in m.onbill.proforma_invoices %}
      <tr>
        <td>
          {_ Pro-forma invoice _}
        </td>
        <td class="td-center">
          {{ proforma_invoice["doc_number"] }} 
        </td>
        <td class="td-center">
          {{ proforma_invoice["doc_date_tuple"][1]["day"] }}
          {{ proforma_invoice["doc_date_tuple"][1]["month_short"] }}
          {{ proforma_invoice["doc_date_tuple"][1]["year"] }}
        </td>
        <td class="td-center">
          {{ proforma_invoice["total_netto"]|currency_sign }}
        </td>
        <td class="td-center">
          {{ proforma_invoice["total_vat"]|currency_sign }}
        </td>
        <td class="td-center">
          {{ proforma_invoice["total_brutto"]|currency_sign }}
        </td>
        <td class="td-center">
          <a href="{{ m.onbill[{attachment_download_link account_id=account_id
                                                         doc_id=proforma_invoice["id"]
                                                         doc_type="onbill_modb" }] }}">
            <i id="{{ proforma_invoice["id"]|cleanout }}"
               class="fa fa-download zprimary"
               title="{_ Download _}"></i></a>
        </td>
        <td class="text-center">
          <i id="delete_proforma_invoice_{{ proforma_invoice["id"]|cleanout }}" class="fa fa-trash-o pointer"></i>
          {% wire id="delete_proforma_invoice_"++proforma_invoice["id"]|cleanout
                  action={confirm text=_"Do you really want to delete this proforma invoice?"++" <br />"
                                  action={postback postback={mark_proforma_invoice_deleted doc_id=proforma_invoice["id"]}
                                                   delegate="mod_kazoo"
                                         }
                         }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#proforma_invoices_list_table').dataTable({
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
