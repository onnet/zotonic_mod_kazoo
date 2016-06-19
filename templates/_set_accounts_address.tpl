{% wire id="set_accounts_address" type="submit" postback="set_accounts_address" delegate="mod_kazoo" %}
<form id="set_accounts_address" action="postback" method="post">

    <div class="form-inline" style="padding: 1em;">
        <label>Type in an address to be shown on your invoice:</label>
    </div>
    <div id="set-customer-address">
        <div class="form-inline padding-card-fields">
             <label>Customer address:</label>
        </div>
        <div class="form-inline padding-card-fields">
             <label>Line 1:</label>
                <input type="text" id="line1" name="line1" maxlength="30" size="29" class="input-address-field" 
                       value="{{ m.kazoo[{kz_account_doc_field field1="account_address" field2="line1"}] }}" required>
        </div>
        <div class="form-inline padding-card-fields">
             <label>Line 2:</label>
                <input type="text" id="line2" name="line2" maxlength="30" size="29" class="input-address-field"
                       value="{{ m.kazoo[{kz_account_doc_field field1="account_address" field2="line2"}] }}" required>
        </div>
        <div class="form-inline padding-card-fields">
             <label>Line 3:</label>
                <input type="text" id="line3" name="line3" maxlength="30" size="29" class="input-address-field"
                       value="{{ m.kazoo[{kz_account_doc_field field1="account_address" field2="line3"}] }}" required>
        </div>
    </div>

</form>
