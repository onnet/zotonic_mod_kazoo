{% wire id="form_issue_invoice_for_transaction" type="submit" postback="issue_invoice_for_transaction" delegate="mod_kazoo" %}
<form id="form_issue_invoice_for_transaction" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-8">
        <select id="credit_reason"
                name="credit_reason"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
           <option value="rental_prepayment">{_ Switched minutes / rental prepayment _}</option>
           <option value="other_description">{_ Other description _}</option>
        </select>
        {% wire id="credit_reason"
                type="change"
                action={script script="CreditReason = $('#credit_reason option:selected').val();
                                       if (CreditReason == 'other_description') {
                                            $('#transaction_description').val('');
                                            $('#transaction_description_form_group').show();
                                       } else {
                                            $('#transaction_description_form_group').hide();
                                            $('#transaction_description').val($('#credit_reason option:selected').text());
                                       }"
                       }
        %}
      </div>
      <div class="col-sm-4">
        <input id="invoice_date"
               type="text"
               class="form-control margin-bottom-xs bg_color_white"
               name="invoice_date"
               value="{{ transaction["created"]|gregsec_to_date|date: 'd/m/Y' }}"
               data-date="{{ transaction["created"]|gregsec_to_date|date: 'd/m/Y' }}"
               data-date-format="dd/mm/yyyy"
               data-date-autoclose="true"
               data-date-language={{ z_language }}
               data-date-start-date="{% if selected_billing_period
                                      %}{{ selected_billing_period|split:","|first
                                           |gregsec_to_date|date: 'd/m/Y' }}{%
                                        else %}-2m{% endif %}"
               data-date-end-date="{% if selected_billing_period
                                    %}{{ selected_billing_period|split:","|last
                                         |gregsec_to_date|date: 'd/m/Y' }}{%
                                      else %}+0d{% endif %}"
               readonly/>
       {% javascript %}
           $('#invoice_date').datepicker();
       {% endjavascript %}
      </div>
    </div>
  </div>
  <div id="transaction_description_form_group" class="form-group display_none">
    <div class="row">
      <div class="col-sm-12">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="transaction_description"
               name="transaction_description"
               value="{_ Switched minutes / rental prepayment _}"
               placeholder="{_ Enter transaction description here _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Generate invoice document"
                  action={submit target="form_issue_invoice_for_transaction"}
                  action={update target="billing_children_area"
                                 template="billing_children.tpl"
                         }
        %}
      </div>
    </div>
  </div>
  <input type="hidden" name="account_id" value="{{ account_id }}">
  <input type="hidden" name="transaction_id" value="{{ transaction["id"] }}">
  <input type="hidden" name="selected_billing_period" value="{{ selected_billing_period }}">
</form>
{% print transaction %}
{% print selected_billing_period %}
{% print selected_billing_period|split:","|first|gregsec_to_date %}
{% print selected_billing_period|split:","|last|gregsec_to_date %}
