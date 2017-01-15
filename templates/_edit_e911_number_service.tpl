{% with m.kazoo[{number_info number=number}],
        m.onbill[{e911_addresses_confirmed account_id=account_id}]
   as   
        number_info,
        confirmed_addresses
%}
{% wire id="edit_e911_address_form" type="submit" postback={edit_e911_address doc_id=doc_id account_id=account_id} delegate="mod_onbill" %}
<form id="edit_e911_address_form" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12 text-center zalarm">
        <h3>{_ Emergency services _}</h3>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      {% if number_info[1]["e911"] %}
        <div class="col-sm-12 text-center" style="font-size: 1.2em;">
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
      {% else %}
        <div class="col-sm-10 col-sm-offset-1" style="font-size: 1.1em;">
          <span class="zalarm">
            In order to comply to FCC E911 regulations, prior to service activation,
            physical address of this phone number use should be provided and confirmed:
          </span>
        </div>
      {% endif %}
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-10 col-sm-offset-1">
        <div class="funkyradio">
          {% for e911_address in confirmed_addresses %}
            <div class="funkyradio-zalarm">
              <input id="{{ e911_address['id'] }}" type="radio" name="confirmed_address" value="{{ e911_address['id'] }}" title="Confirmed address">
              <label for="{{ e911_address['id'] }}">
                {{ e911_address["street_address"] }}
                {{ e911_address["extended_address"] }},
                {{ e911_address["locality"] }},
                {{ e911_address["region"] }}
                {{ e911_address["postal_code"] }}
                {# print e911_address #}
                {% wire id=e911_address['id'] type="click" action={slide_up target="new_address_span"} %}
              </label>
            </div>
          {% endfor %}
          {% if number_info[1]["e911"] or confirmed_addresses[1] %}
            <div class="funkyradio-zalarm">
              <input id="new_address_radio" type="radio" name="confirmed_address" value="new_address_radio" title="New address">
              <label for="new_address_radio">
                {_ Assign new address _}
                {% wire id="new_address_radio" type="click" action={slide_down target="new_address_span"} %}
              </label>
            </div>
          {% endif %}
        </div>
      </div>
    </div>
  </div>
  <div id="new_address_span" class="{% if number_info[1]["e911"] or confirmed_addresses[1] %}display_none{% endif %}">
    {% include "_e911_address_fields.tpl" %}
  </div>
  <input type="hidden" name="number" value="{{ number }}">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        {% button id="confirm_e911_address_edit_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Confirm" %}
        {% wire id="confirm_e911_address_edit_btn"
                type="click"
                action={submit}
                action={update target="number_services_div"
                               template="_edit_e911_number_service.tpl"
                               number=number
                               account_id=account_id}

        %}
      </div>
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
      </div>
    </div>
  </div>
</form>
{% endwith %}
