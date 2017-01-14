{% with m.onbill[{get_e911_address_doc doc_id=doc_id account_id=account_id}] as e911_address_doc %}
{% wire id="edit_e911_address_form" type="submit" postback={edit_e911_address doc_id=doc_id account_id=account_id} delegate="mod_onbill" %}
<form id="edit_e911_address_form" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="postal_code"
                 name="postal_code"
                 value="{{ e911_address_doc[1]["postal_code"] }}"
                 placeholder="{_ Zip Code _} {_ (mandatory) _}">
        </div>
        <div class="col-sm-6">
          <input type="text"
                 class="form-control"
                 id="street_address"
                 name="street_address"
                 value="{{ e911_address_doc[1]["street_address"] }}"
                 placeholder="{_ Address Line 1 _} {_ (mandatory) _}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="locality"
                 name="locality"
                 value="{{ e911_address_doc[1]["locality"] }}"
                 placeholder="{_ City _} {_ (mandatory) _}">
        </div>
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="extended_address"
                 name="extended_address"
                 value="{{ e911_address_doc[1]["extended_address"] }}"
                 placeholder="{_ Address Line 2 _} {_ (optional) _}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control"
                 id="region"
                 name="region"
                 value="{{ e911_address_doc[1]["region"] }}"
                 placeholder="{_ State _} {_ (mandatory) _}">
        </div>
      </div>
    </div>

    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% button id="confirm_e911_address_edit_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Confirm" %}
          {% wire id="confirm_e911_address_edit_btn"
                  type="click"
                  action={submit}
                  action={dialog_close}
          %}
        </div>
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
        </div>
      </div>
    </div>
</form>
{% endwith %}
