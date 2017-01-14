{% with m.onbill[{get_e911_address_doc doc_id=doc_id account_id=account_id}] as e911_address_doc %}
{% wire id="edit_e911_address_form" type="submit" postback={edit_e911_address doc_id=doc_id account_id=account_id} delegate="mod_onbill" %}
<form id="edit_e911_address_form" method="post" action="postback">
  {% if not doc_id %}
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12 zalarm">
          In order to comply to FCC E911 regulations, prior to service activation,
          physical address of this phone number use should be provided and confirmed:
        </div>
      </div>
    </div>
  {% endif %}
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="zipcode"
                 name="zipcode"
                 value="{{ e911_address_doc[1]["zip"] }}"
                 placeholder="{_ Zip Code _} {_ (mandatory) _}">
        </div>
        <div class="col-sm-6">
          <input type="text"
                 class="form-control"
                 id="address_line1"
                 name="address_line1"
                 value="{{ e911_address_doc[1]["address_line1"] }}"
                 placeholder="{_ Address Line 1 _} {_ (mandatory) _}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="city"
                 value="{{ e911_address_doc[1]["city"] }}"
                 name="city" placeholder="{_ City _} {_ (mandatory) _}">
        </div>
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="address_line2"
                 name="address_line2"
                 value="{{ e911_address_doc[1]["address_line2"] }}"
                 placeholder="{_ Address Line 2 _} {_ (mandatory) _}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control"
                 id="state"
                 name="state"
                 value="{{ e911_address_doc[1]["state"] }}"
                 placeholder="{_ State _} {_ (mandatory) _}">
        </div>
        <div class="col-sm-6">
          <input type="text"
                 class="form-control"
                 id="address_line3"
                 name="address_line3"
                 value="{{ e911_address_doc[1]["address_line3"] }}"
                 placeholder="{_ Address Line 3 _} {_ (optional) _}">
        </div>
      </div>
    </div>
  {% if not doc_id %}
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <input id="{{ #file }}" type="file" name="address_confirmation_file" style="visibility: hidden; position: absolute;">
          <div class="input-group">
            <input id="{{ #proofinput }}" type="text" class="form-control" placeholder="{_ Proof of address ( utility bill / government letter ) _}">
            <span class="input-group-btn">
              <button id="{{ #browse }}" class="browse btn btn-zprimary margin-bottom-xs" type="button"><i class="glyphicon glyphicon-search"></i> {_ Browse _}</button>
            </span>
          </div>
        </div>
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
