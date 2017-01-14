<div class="form-group">
  <div class="row">
    <div class="col-sm-12 text-center zalarm">
      <h3>{_ Emergency services _}</h3>
    </div>
  </div>
</div>

{% with m.kazoo[{number_info number=number}] as number_info %}
{% wire id="edit_e911_address_form" type="submit" postback={edit_e911_address doc_id=doc_id account_id=account_id} delegate="mod_onbill" %}

  {% print number_info[1]["e911"] %}

  <br />
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12 zalarm">
          In order to comply to FCC E911 regulations, prior to service activation,
          physical address of this phone number use should be provided and confirmed:
        </div>
      </div>
    </div>
  {% if number_info[1]["e911"] %}
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <span class="zprimary">
            Configured address:
          </span>
          <span class="zalarm">
            <strong>
            {{ number_info[1]["e911"][1]["street_address"] }}
            {{ number_info[1]["e911"][1]["extended_address"] }},
            {{ number_info[1]["e911"][1]["locality"] }},
            {{ number_info[1]["e911"][1]["region"] }}
            {{ number_info[1]["e911"][1]["postal_code"] }}
            </strong>
          </span>
        </div>
      </div>
    </div>
  {% endif %}
  {% for e911_address in m.onbill[{e911_addresses account_id=account_id}] %}
    {% print e911_address %}
  {% endfor %}

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
                 value="{{ e911_address_doc[1]["locality"] }}"
                 name="locality" placeholder="{_ City _} {_ (mandatory) _}">
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
        <div class="col-sm-6">
          <input id="{{ #file }}" type="file" name="address_confirmation_file" style="visibility: hidden; position: absolute;">
          <div class="input-group">
            <input id="{{ #proofinput }}" type="text" class="form-control" placeholder="{_ Proof of address ( utility bill / govt letter ) _}">
            <span class="input-group-btn">
              <button id="{{ #browse }}" class="browse btn btn-zprimary margin-bottom-xs" type="button"><i class="glyphicon glyphicon-search"></i> {_ Browse _}</button>
            </span>
          </div>
        </div>
      </div>
    </div>
  {% if not doc_id %}
    <div class="form-group">
      <div class="row">
      </div>
    </div>
    <div class="form-group" style="margin-bottom: 2em;">
      <div class="row">
        <div class="col-sm-12">
          <div class="controls">
            <textarea rows="4" cols="10" id="comments" name="comments" placeholder=" {_ Comments _}"></textarea>
          </div>
        </div>
      </div>
    </div>
  
    <script type="text/javascript">
      $(document).on('click', '#{{ #browse }}', function(){
        $('#{{ #file }}').trigger('click');
      });
      $(document).on('change', '#{{ #file }}', function(){
        $('#{{ #proofinput }}').val($(this).val().replace(/C:\\fakepath\\/i, ''));
      });
    </script>
  {% endif %}

    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% button id="confirm_e911_address_edit_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Confirm" %}
          {% wire id="confirm_e911_address_edit_btn"
                  type="click"
                  action={submit}
          %}
        </div>
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
        </div>
      </div>
    </div>
</form>
{% endwith %}
