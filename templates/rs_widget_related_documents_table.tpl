<table id="rs_related_documents_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th>{_ Type _}</th>
      <th class="td-center">{_ Counterparty _}</th>
      <th class="td-center">{_ # _}</th>
      <th class="td-center">{_ Date _}</th>
      <th class="td-center">{_ Sum _}</th>
      <th class="td-center">{_ VAT _}</th>
      <th class="td-center">{_ Total _}</th>
      <th class="td-center"></th>
      {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) %}
        <th class="td-center"></th>
      {% endif %}
        </tr>
  </thead>
  <tbody>
    {% for doc in m.onbill[{docs_listing account_id=account_id selected_billing_period=selected_billing_period}] %}
      <tr>
        <td>{{ doc[1]["type"]|truncate:11 }}</td>
        <td class="td-center">{{ doc[1]["oper_name_short"]|truncate:15 }}</td>
        <td class="td-center">
          {{ doc[1]["doc_number"] }}
        </td>
        <td class="td-center">
          {% if doc[1]["doc_date_json"][1]["day"] %}
            {{ doc[1]["doc_date_json"][1]["day"] }}
            {{ doc[1]["doc_date_json"][1]["month_short"] }}
            {{ doc[1]["doc_date_json"][1]["year"] }}
          {% else %}
            {{ doc[1]["doc_date"] }}
          {% endif %}
        </td>
        <td class="td-center">{{ doc[1]["total_netto"]|currency_sign }}</td>
        <td class="td-center">{{ doc[1]["total_vat"]|currency_sign }}</td>
        <td class="td-center">{{ doc[1]["total_brutto"]|currency_sign }}</td>
        <td>
          <a target="_blank"
             href="{{ m.onbill[{attachment_download_link account_id=account_id doc_id=doc[1]["id"] doc_type="onbill_modb"}] }}">
           <i class="fa fa-download zprimary" title="{_ Download _}"></i></a>
          </a>
        </td>
        {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) %}
          <td>
            {% if doc[1]["type"] == "transaction_based_invoice" %}
              <i id="delete_doc_{{ doc[1]["id"] }}" class="fa fa-trash zalarm pointer"></i>
              {% wire id="delete_doc_"++doc[1]["id"]
                      action={confirm text=_"Do you really want to delete document"
                                             ++
                                           ": "
                                             ++
                                           "<strong class='zalarm'> #"
                                             ++
                                           doc[1]["doc_number"]
                                             ++
                                           "</strong>"
                                             ++ "?"
                                      action={postback
                                              postback={onbill_generated_doc_delete
                                                        account_id=account_id
                                                        doc_id=doc[1]["id"]
                                                       }
                                              delegate="mod_kazoo"
                                             }
                             }
              %}
            {% endif %}
          </td>
        {% endif %}
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_related_documents_table').dataTable({
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
