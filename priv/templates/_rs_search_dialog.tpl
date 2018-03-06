{% wire id="form_rs_account_lookup" type="submit" postback="rs_account_lookup" delegate="mod_kazoo" %}
<form id="form_rs_account_lookup" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <select id="search_option"
                name="search_option"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="phone_number">{_ Search by phone number _}</option>
          <option value="onbill_data">{_ Search by agreement data _}</option>
        </select>
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control margin-bottom-xs" id="name" name="name" value="">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Search _}</button>
      </div>
    </div>
  </div>
</form>
