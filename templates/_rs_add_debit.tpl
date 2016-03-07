{% wire id="form_add_debit" type="submit" postback="add_debit" delegate="mod_kazoo" %}
<form id="form_add_debit" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <input type="text" class="form-control margin-bottom-xs" id="debit_amount" name="debit_amount" placeholder="{_ Enter amount here _}">
        </div>
        <div class="col-sm-4">
          <input id="debit_date" type="text" class="form-control margin-bottom-xs bg_color_white"
                                              name="debit_date"
                                              value="{{ now|date: 'd/m/Y' }}"
                                              data-date="{{ now|date: 'd/m/Y' }}"
                                              data-date-format="dd/mm/yyyy"
                                              data-date-autoclose="true"
                                              data-date-language={{ z_language }}
                                              data-date-start-date="-6m"
                                              data-date-end-date="+0d"
                                              readonly/>
         {% javascript %}
             $('#debit_date').datepicker();
         {% endjavascript %}
        </div>
        <div class="col-sm-4">
            <select id="debit_reason" name="debit_reason" class="form-control margin-bottom-xs" style="text-align:center;">
               <option value="balance_correction">Balance correction</option>
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <input type="text" class="form-control margin-bottom-xs" id="debit_description" name="debit_description" placeholder="{_ Enter transaction description here _}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Debit acccount _}</button>
        </div>
      </div>
    </div>
    <input type="hidden" name="account_id" value="{{ account_id }}">
</form>
