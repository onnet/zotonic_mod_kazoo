{% wire id="form_add_credit" type="submit" postback="add_credit" delegate="mod_kazoo" %}
<form id="form_add_credit" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="credit_amount"
               name="credit_amount"
               placeholder="{_ Enter amount here _}">
      </div>
      <div class="col-sm-4">
        <input id="credit_date"
               type="text"
               class="form-control margin-bottom-xs bg_color_white"
               name="credit_date"
               value="{{ now|date: 'd/m/Y' }}"
               data-date="{{ now|date: 'd/m/Y' }}"
               data-date-format="dd/mm/yyyy"
               data-date-autoclose="true"
               data-date-language={{ z_language }}
               data-date-start-date="-6m"
               data-date-end-date="+0d"
               readonly/>
       {% javascript %}
         $('#credit_date').datepicker();
       {% endjavascript %}
      </div>
      <div class="col-sm-4">
        <select id="credit_reason"
                name="credit_reason"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
           <option value="wire_transfer">Wire transfer</option>
        </select>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="credit_description"
               name="credit_description"
               placeholder="{_ Enter transaction description here _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Credit account"
                  action={submit target="form_add_credit"}
                  action={update target="billing_children_area"
                                 template="billing_children.tpl"
                         }
        %}
      </div>
    </div>
  </div>
  <input type="hidden" name="account_id" value="{{ account_id }}">
</form>
{% with m.kazoo.get_user_timezone,
        m.kazoo[{kz_list_transactions account_id=account_id
                                      selected_billing_period=selected_billing_period
                                      type="credit"}]
   as timezone,
      transactions
%}
{% if transactions[1] %}
<br />
<table id="rs_add_credit_payments_lists_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="td-center">{_ Date _}</th>
      <th class="td-center1">{_ Description _}</th>
      <th class="td-center">{_ Sum _}</th>
    </tr>
  </thead>
  <tbody>
    {% for transaction in transactions %}
      <tr id={{ transaction[1]["id"] }}
          {% if transaction[1]["subscription_id"] %}
            style="cursor: pointer;"
          {% endif %}>
        <td class="td-center">
          {{ transaction[1]["created"]|gregsec_to_date|date:"Y-m-d H:i T":timezone }}
        </td>
        <td class="td-center1">
          {% if transaction[1]["description"] %}
            {{ transaction[1]["description"] }}
          {% else %}
            {{ transaction[1]["reason"] }}
          {% endif %}
        </td>
        <td class="pri-1 td-right">
          {{ transaction[1]["amount"]|format_price:[".",""]|currency_sign }}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>
{% endif %}
{% endwith %}

{% javascript %}
  var oTable = $('#rs_add_credit_payments_lists_table').dataTable({
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
  }
});
{% endjavascript %}

