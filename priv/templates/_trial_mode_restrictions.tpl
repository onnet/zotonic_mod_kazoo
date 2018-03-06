<div class="form-group">
  <div class="row" style="font-size: 1.15em;">
    <div class="col-sm-10 col-sm-offset-1 pt-1">
        <p>
          Trial period is provided for the evaluation of Hosted PBX functionality only.
          PSTN services e.g. phone numbers, outbound/inbound trunks, etc are not included
          and will need to be purchased separately.
        </p>
        <p>
          In order to activate the full subscription, top up your account with an amount of funds
          greater than the estimated total monthly fees of the services you have currently configured.
        </p>
        <p>
          The full subscription will then be activated automatically.
        </p>
    </div>
  </div>
</div>
{% if one_button_only %}
  <div class="row">
      <div class="col-sm-12">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Close"
                  action={dialog_close}
        %}
      </div>
  </div>
{% else %}
  <div class="row">
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs"
                  text=_"Top up account"
                  action={redirect dispatch="finance_details"}
        %}
      </div>
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Close"
                  action={dialog_close}
        %}
      </div>
  </div>
{% endif %}
