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
