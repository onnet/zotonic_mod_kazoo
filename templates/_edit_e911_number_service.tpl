{% with m.kazoo[{number_info number=number}],
        m.onbill[{e911_addresses_confirmed account_id=account_id}]
   as   
        number_info,
        confirmed_addresses
%}
{% wire id="set_e911_address_form"
        type="submit"
        postback={set_e911_address account_id=account_id}
        delegate="mod_onbill"
%}
<form id="set_e911_address_form" method="post" action="postback">
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
          <span id="configured_address_span" class="zalarm">
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
          {% if number_info[1]["e911"] %}
            <div class="funkyradio-zalarm">
              <input id="remove_address_radio"
                     type="radio"
                     name="confirmed_address"
                     value="remove_address_radio"
                     title="Remove configured address">
              <label for="remove_address_radio">
                {_ Remove configured address _}
                {% wire id="remove_address_radio"
                        type="click"
                        action={slide_down target="confirm_and_cancel_btn"}
                        action={slide_up target="cancel_only_btn"}
                %}
              </label>
            </div>
          {% endif %}
          {% for e911_address in confirmed_addresses %}
            <div class="funkyradio-zalarm">
              <input id="{{ e911_address['id'] }}"
                     type="radio"
                     name="confirmed_address"
                     value="{{ e911_address['id'] }}"
                     title="Confirmed address">
              <label for="{{ e911_address['id'] }}">
                {{ e911_address["street_address"] }}
                {{ e911_address["extended_address"] }},
                {{ e911_address["locality"] }},
                {{ e911_address["region"] }}
                {{ e911_address["postal_code"] }}
                {# print e911_address #}
                {% wire id=e911_address['id']
                        type="click"
                        action={slide_up target="new_address_span"}
                        action={slide_down target="confirm_and_cancel_btn"}
                        action={slide_up target="cancel_only_btn"}
                %}
              </label>
            </div>
          {% endfor %}
          {% if number_info[1]["e911"] or confirmed_addresses[1] %}
            <div class="funkyradio-zalarm">
              <input id="new_address_radio"
                     type="radio"
                     name="confirmed_address"
                     value="new_address_radio"
                     title="New address">
              <label for="new_address_radio">
                {_ Assign new address _}
                {% wire id="new_address_radio"
                        type="click"
                        action={slide_down target="new_address_span"}
                        action={slide_down target="confirm_and_cancel_btn"}
                        action={slide_up target="cancel_only_btn"}
                %}
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
  <div id="confirm_and_cancel_btn" class="form-group display_none">
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
  <div id="cancel_only_btn" class="form-group">
    <div class="row">
      <div class="col-sm-12">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Close" action={dialog_close} %}
      </div>
    </div>
  </div>
</form>
{% endwith %}
