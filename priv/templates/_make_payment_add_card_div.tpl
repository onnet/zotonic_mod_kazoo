{% wire id="add_card_form" type="submit" postback="add_card" delegate="mod_kazoo" %}
<form id="add_card_form" action="postback" method="post">

    <div class="form-inline" style="padding: 1em;">
        <label>Add new card:</label>
    </div>
    <div id="add-credit-card">
        <div class="form-inline padding-card-fields">
             <label>Card holder:</label>
                <input data-braintree-name="cardholder_name" type="text" maxlength="30" size="20" class="input-card-field" required>
        </div>
        <div class="form-inline padding-card-fields">
             <label>Card number:</label>
                <input data-braintree-name="number" type="text" maxlength="17" size="17" class="input-card-field" required>
        </div>
        <div class="form-inline padding-card-fields">
            <label>Expiration date:</label>
                <input data-braintree-name="expiration_month" type="text" maxlength="2" size="2" placeholder="MM" class="input-card-field" required> /
                <input data-braintree-name="expiration_year" type="text" maxlength="2" size="2" placeholder="YY" class="input-card-field" required>
        </div>
        <div class="form-inline padding-card-fields">
            <label>CVV:</label>
                 <input data-braintree-name="cvv" type="text" maxlength="4" size="4" class="input-card-field" required>
                 <input class="pull-right" type="submit" id="submit" value="Add Card">
        </div>
    </div>

</form>

{% javascript %}
braintree.setup(
    '{{ m.kazoo.bt_client_token }}'
    ,'custom'
    ,{id: 'add_card_form'}
);
{% endjavascript %}

