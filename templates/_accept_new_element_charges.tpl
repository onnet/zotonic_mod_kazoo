<div class="form-group">
  <div class="row" style="font-size: 1.15em;">
    <div class="col-sm-10 col-sm-offset-1">
      <p style="font-size: 1.5em; margin-bottom: 0.5em;"><strong>Dear customer,</strong></p>
      <p>
         You are about to add <strong class="zalarm">{{ item[1]["name"] }}</strong>.
      </p>
      <p>Activation charge:
        <strong>
          <span class="zalarm">{{ item[1]["activation_charge"]|currency_sign }}</span>
        </strong>
      </p>
      <p>Your monthly expenses will be increased by:
        <strong>
          <span class="zalarm">{{ item[1]["rate"]|currency_sign }}</span>
        </strong>
      </p>
      <p>Your {{ item[1]["name"] }}(s) monthly charges after this purchase will be:</p>
      <p>
        <strong>
          {{ item[1]["quantity"] }} x {{ item[1]["rate"]|currency_sign }}
           -
          {{
            (item[1]["single_discount_rate"] + item[1]["cumulative_discount"]
              * item[1]["cumulative_discount_rate"])
            |currency_sign
          }}
           =
          <span class="zalarm"> 
            {{
              (item[1]["quantity"] * item[1]["rate"]
               - (item[1]["single_discount_rate"]
                   + item[1]["cumulative_discount"] * item[1]["cumulative_discount_rate"])
              )|currency_sign
            }}
          </span>
        </strong>
      </p>
      <p>Your account will be charged immediately after this purchase.</p>
      <p>Charges will be pro-rated for your billing cycle.</p>
      <br />
      <input type="hidden" id="accept_charges" name="accept_charges" value="true">
      <div class="form-group">
        <div class="row">
          <div class="col-sm-6">
            {% button id="confirm_trunks_payment"
                      class="col-xs-12 btn btn-zalarm margin-bottom-xs"
                      text=_"Confirm"
            %}
            {% wire id="confirm_trunks_payment"
                    type="click"
                    action={postback postback={add_new_device databag=databag}
                                     delegate="mod_kazoo"
                           }
                    action={dialog_close}
            %}

          </div>
          <div class="col-sm-6">
            {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                      text=_"Cancel"
                      action={dialog_close}
            %}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

