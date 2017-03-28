{% wire id="form_periodic_fee" type="submit" postback="periodic_fee" delegate="mod_kazoo" %}
{% with m.onbill[{periodic_fees account_id=account_id fee_id=fee_id}] as fee_data %}
<form id="form_periodic_fee" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        {% if fee_id %}
           {{ m.kazoo[{kz_current_service_plans
                       account_id=account_id}][1]["items"][1]["periodic_fees"][1][fee_data[1]["service_id"]][1]["name"] }},
           {{ m.kazoo[{kz_current_service_plans
                       account_id=account_id}][1]["items"][1]["periodic_fees"][1][fee_data[1]["service_id"]][1]["activation_charge"] }},
           {{ m.kazoo[{kz_current_service_plans
                       account_id=account_id}][1]["items"][1]["periodic_fees"][1][fee_data[1]["service_id"]][1]["rate"] }},
           <input type="hidden" name="fee_id" value="{{ fee_id }}">
           <input type="hidden" name="service_id" value="{{ fee_data[1]["service_id"] }}">
        {% else %}
        {% wire id="service_id"
                type="change"
                action={slide_down target="confirm_and_cancel_btn"}
                action={slide_up target="cancel_only_btn"}
        %}
        <select id="service_id" name="service_id" class="form-control margin-bottom-xs" style="text-align:center;">
          <option selected disabled hidden>-- {_ Select service _} --</option>
          {% for fee_item in m.kazoo[{kz_current_service_plans account_id=account_id}][1]["items"][1]["periodic_fees"][1] %}
             <option value="{{ fee_item[2][1]["item"] }}">
               {{ fee_item[2][1]["name"] }},
               {{ fee_item[2][1]["activation_charge"] }},
               {{ fee_item[2][1]["rate"] }}
             </option>
          {% endfor %}
        </select>
        {% endif %}
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-3">
        <input id="quantity"
               name="quantity"
               class="form-control margin-bottom-xs"
               placeholder="{_ Quantity _}"
               value="{{ fee_data[1]["quantity"] }}"
               style="padding: 0 0 0 40px;"
               {% if fee_data[1]["service_ends"]|inno_timestamp_expired == "expired" %}
                 disabled
               {% endif %} />
      </div>
      <div class="col-sm-3">
        <input id="service_starts"
               type="text"
               class="form-control margin-bottom-xs bg_color_white"
               name="service_starts"
               value="{% if fee_id %}{{ fee_data[1]["service_starts"]|inno_timestamp_to_date|date: 'd/m/Y' }}{% else %}{{ now|date:"d/m/Y" }}{% endif %}"
               data-date="{% if fee_id %}{{ fee_data[1]["service_starts"]|inno_timestamp_to_date|date: 'd/m/Y' }}{% else %}{{ now|date:"d/m/Y" }}{% endif %}"
               data-date-format="dd/mm/yyyy"
               data-date-autoclose="true"
               data-date-language={{ z_language }}
               data-date-start-date="01/{{ now|date:"m/Y" }}"
               data-date-end-date="+6m"
               {% if fee_id and fee_data[1]["service_starts"]|inno_timestamp_expired == "expired" %}
                 disabled
               {% endif %} />
       {% javascript %}
           $('#service_starts').datepicker();
       {% endjavascript %}
      </div>
      <div class="col-sm-3">
        <label for="enddate_defined"
               class="checkbox-inline {% if fee_data[1]["service_ends"] %}checked{% endif %}"
               style="width: 100%">
          <input type="checkbox" id="enddate_defined" name="enddate_defined"
               {% if fee_data[1]["service_ends"]|inno_timestamp_expired == "expired" %}
                 disabled
               {% endif %}
               {% if fee_data[1]["service_ends"] %}
                 checked
               {% endif %}
               value="1" />
          {_ End date _}
        </label>
      </div>
      <div class="col-sm-3">
        <input id="service_ends"
               type="text"
               class="form-control margin-bottom-xs bg_color_white {% if not fee_data[1]["service_ends"] %}hidden{% endif %}"
               name="service_ends"
               value="{% if fee_id %}{{ fee_data[1]["service_ends"]|inno_timestamp_to_date|date: 'd/m/Y' }}{% else %}{{ now|date:"d/m/Y" }}{% endif %}"
               data-date="{% if fee_id %}{{ fee_data[1]["service_ends"]|inno_timestamp_to_date|date: 'd/m/Y' }}{% else %}{{ now|date:"d/m/Y" }}{% endif %}"
               data-date-format="dd/mm/yyyy"
               data-date-autoclose="true"
               data-date-language={{ z_language }}
               data-date-start-date="{{ now|date:"d/m/Y" }}"
               data-date-end-date="+12m"
               {% if fee_data[1]["service_ends"]|inno_timestamp_expired == "expired" %}
                 disabled
               {% endif %} />
       {% javascript %}
           $('#service_ends').datepicker();
       {% endjavascript %}
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="comment"
               name="comment"
               placeholder="{_ Enter service comment here _}"
               value="{{ fee_data[1]['comment'] }}"
               {% if fee_data[1]["service_ends"]|inno_timestamp_expired == "expired" %}
                 disabled
               {% endif %} />
      </div>
    </div>
  </div>
  <input type="hidden" name="account_id" value="{{ account_id }}">
  <div id="confirm_and_cancel_btn"
       class="form-group
              {% if fee_data[1]["service_ends"]|inno_timestamp_expired == "expired" %}
                display_none
              {% elseif not fee_id %}
                display_none
              {% endif %}">
    <div class="row">
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Save service"
                  action={submit target="form_periodic_fee"}
                  action={mask target="rs_periodic_services_table"}
                  action={emit signal={update_onbill_periodic_services_lazy_tpl signal_filter=m.kazoo.signal_filter}}
        %}
      </div>
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
      </div>
    </div>
  </div>
  <div id="cancel_only_btn"
       class="form-group
              {% if fee_id and fee_data[1]["service_ends"]|inno_timestamp_expired == "active" %}
                display_none
              {% elseif fee_id and not fee_data[1]["service_ends"] %}
                display_none
              {% endif %}">
    <div class="row">
      <div class="col-sm-12">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Close" action={dialog_close} %}
      </div>
    </div>
  </div>
</form>
{% endwith %}

<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
              $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
              $('#service_ends').toggleClass('hidden');
        });
});
</script>
