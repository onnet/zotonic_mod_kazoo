{% wire id="manage_trial_form"
        type="submit"
        postback={manage_trial_status account_id=account_id}
        delegate="mod_kazoo"
%}
<form id="manage_trial_form" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-10 col-sm-offset-1">
        <div class="funkyradio">
          <div class="funkyradio-zalarm">
            <input id="remove_trial_status"
                   type="radio"
                   name="manage_trial_status"
                   value="remove_trial_status"
                   title="Remove trial status">
            <label for="remove_trial_status">
              {_ Remove trial status _}
              {% wire id="remove_trial_status"
                      type="click"
                      action={slide_up target="new_expiration_span"}
                      action={slide_up target="set_account_type_span"}
                      action={slide_down target="confirm_and_cancel_btn"}
                      action={slide_up target="cancel_only_btn"}
              %}
            </label>
          </div>
          <div class="funkyradio-zalarm">
            <input id="new_expiration_date"
                   type="radio"
                   name="manage_trial_status"
                   value="new_expiration_date"
                   title="New expiration date">
            <label for="new_expiration_date">
              {_ Assign new expiration date _}
              {% wire id="new_expiration_date"
                      type="click"
                      action={slide_up target="set_account_type_span"}
                      action={slide_down target="new_expiration_span"}
                      action={slide_down target="confirm_and_cancel_btn"}
                      action={slide_up target="cancel_only_btn"}
              %}
            </label>
          </div>
          <div class="funkyradio-zalarm">
            <input id="set_account_type"
                   type="radio"
                   name="manage_trial_status"
                   value="set_account_type"
                   title="Set account type">
            <label for="set_account_type">
              {_ Set account type _}
              {% wire id="set_account_type"
                      type="click"
                      action={slide_up target="new_expiration_span"}
                      action={slide_down target="set_account_type_span"}
                      action={slide_down target="confirm_and_cancel_btn"}
                      action={slide_up target="cancel_only_btn"}
              %}
            </label>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="new_expiration_span" class="form-group display_none pt-1 pb-2">
    <div class="row">
      <div class="col-sm-12" style="font-size: 1.1em; width:100%">
        <div id="datepicker"
             data-date="{{ trial_time_left
                           |inno_timestamp_seconds_from_now
                           |gregsec_to_date
                           |date:"m/d/Y":m.kazoo.get_user_timezone
                        }}"
             style="margin: 0 auto; display: table;">
        </div>
        <input type="hidden"
               name="new_expiration_date"
               id="my_hidden_input"
               value="{{ trial_time_left
                         |inno_timestamp_seconds_from_now
                         |gregsec_to_date
                         |date:"m/d/Y":m.kazoo.get_user_timezone
                      }}">
        <script>
          $('#datepicker').datepicker();
          $('#datepicker').on('changeDate', function() {
              $('#my_hidden_input').val(
                  $('#datepicker').datepicker('getFormattedDate')
              );
          });
        </script>
      </div>
    </div>
  </div>
  {% with m.onbill[{onbill_pvt_limits account_id=account_id}] as onbill_pvt_limits %}
  <div id="set_account_type_span" class="form-group display_none pt-1 pb-2">
    <div class="row">
      <div class="col-sm-4 col-sm-offset-2">
        {% wire id="account_type"
                type="change"
                action={script
                        script="Type = $('#account_type').val();
                                if (Type == 'postpaid')
                                    {$('#max_postpay_amount').prop('placeholder', 'input max credit');
                                     $('#max_postpay_amount').val('"++ onbill_pvt_limits[1]["max_postpay_amount"] ++"');
                                     $('#max_postpay_amount').show()}
                                else
                                    {$('#max_postpay_amount').hide()};"
                       }
                action={slide_down target="button_failover_number_service"}
        %}
        <select name="account_type" id="account_type" class="form-control margin-bottom-xs">
          <option id="prepaid"
                  value="prepaid"
                  {% if not onbill_pvt_limits[1]["allow_postpay"] %}selected{% endif %}>
            {_ Prepaid _}
          </option>
          <option id="postpaid"
                  value="postpaid"
                  {% if onbill_pvt_limits[1]["allow_postpay"] %}selected{% endif %}>
            {_ Postpaid _}
          </option>
        </select>
      </div>
      <div class="col-sm-4">
        <input id="max_postpay_amount"
               name="max_postpay_amount"
               type="text"
               class="form-control margin-bottom-xs text-center
                      {% if not onbill_pvt_limits[1]["allow_postpay"] %}
                        display_none
                      {% endif %}"
               placeholder="max prostpay amount"
               value="{{ onbill_pvt_limits[1]["max_postpay_amount"] }}">
      </div>
    </div>
  </div>
  {% endwith %}
  <div id="confirm_and_cancel_btn" class="form-group display_none">
    <div class="row">
      <div class="col-sm-6">
        {% button id="confirm_trial_status_btn"
                  class="col-xs-12 btn btn-zalarm margin-bottom-xs"
                  text=_"Confirm"
        %}
        {% wire id="confirm_trial_status_btn"
                type="click"
                action={submit}
        %}
      </div>
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Close"
                  action={dialog_close}
        %}
      </div>
    </div>
  </div>
  <div id="cancel_only_btn" class="form-group">
    <div class="row">
      <div class="col-sm-12">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Close"
                  action={dialog_close}
        %}
      </div>
    </div>
  </div>
</form>
