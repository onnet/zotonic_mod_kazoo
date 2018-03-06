{% wire id="allocate_number_form" type="submit" postback={allocate_numbers numbers=numbers_to_purchase} delegate="mod_kazoo" %}
<form id="allocate_number_form" method="post" action="postback">
<div class="form-group">
  <div class="row" style="font-size: 1.15em;">
    <div class="col-sm-10 col-sm-offset-1">
      <p style="font-size: 1.4em; margin-top: 1em; text-align: center;">
        Please confirm you would like to add number(s):
      </p>
      {% for number_to_purchase in numbers_to_purchase %}
        <p class="zalarm" style="font-size: 1.3em; margin-bottom1: 2em; text-align: center;">
          <strong>{{ number_to_purchase|pretty_phonenumber }}</strong>
        </p>
      {% endfor %}
      <br />
      <div class="form-group">
        <div class="row">
          <div class="col-sm-12">
            <p>
               You are about to purchase
               <strong class="zalarm">{{ basket[1]["order_quantity"] }}</strong>
               <strong class="zalarm">{{ basket[1]["friendly_name"] }}</strong> number(s).
            </p>
            <p>Activation charge:</p>
            <p>
              <strong>
                {{ basket[1]["order_quantity"] }} x {{ basket[1]["activation_charge"]|currency_sign }}
                =
                <span class="zalarm">
                 {{ (basket[1]["order_quantity"] * basket[1]["activation_charge"])|currency_sign }}
                </span>
              </strong>
            </p>
            <p>Your monthly expenses will be increased by:</p>
            <p>
              <strong>
                {{ basket[1]["order_quantity"] }} x {{ basket[1]["rate"]|currency_sign }}
                =
                <span class="zalarm">{{ (basket[1]["order_quantity"] * basket[1]["rate"])|currency_sign }}</span>
              </strong>
            </p>
            <p>Your {{ basket[1]["friendly_name"] }} monthly charges after this purchase will be:</p>
            <p>
              <strong>
                {{ basket[1]["expected_quantity"] }} x {{ basket[1]["rate"]|currency_sign }}
                 -
                {{ (basket[1]["single_discount"] - basket[1]["cumulative_discount"])|currency_sign  }}
                 =
                <span class="zalarm"> 
                  {{ basket[1]["expected_mrc"]|currency_sign }}
                </span>
              </strong>
            </p>
            <p style="margin-bottom: 2em;">
              Your account will be charged immediately after this purchase..
              <br />
              Charges will be pro-rated for your billing cycle.
            </p>
          </div>
        </div>
      </div>
      <input type="hidden" id="accept_charges" name="accept_charges" value="true">
      <div class="form-group">
        <div class="row">
          <div class="col-sm-6">
            {% button id="confirm_numbers_purchase_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Confirm" %}
            {% wire id="confirm_numbers_purchase_btn"
                    type="click"
                    action={mask target="mytbodyid" message=_"Processing number purchase..."}
                    action={submit}
            %}
          </div>
          <div class="col-sm-6">
            {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</form>
