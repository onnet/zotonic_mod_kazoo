<div class="row">
  <div class="col-sm-10 pt-1 pb-1">

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">calls</label></div>
        <div id="pvt_limits_calls" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="calls" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">resource_consuming_calls</label></div>
        <div id="pvt_limits_resource_consuming_calls" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="resource_consuming_calls" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">inbound_trunks</label></div>
        <div id="pvt_limits_inbound_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="inbound_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">outbound_trunks</label></div>
        <div id="pvt_limits_outbound_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="outbound_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">twoway_trunks</label></div>
        <div id="pvt_limits_twoway_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="twoway_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">bundled_inbound_trunks</label></div>
        <div id="pvt_limits_bundled_inbound_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="bundled_inbound_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">bundled_outbound_trunks</label></div>
        <div id="pvt_limits_bundled_outbound_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="bundled_outbound_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">bundled_twoway_trunks</label></div>
        <div id="pvt_limits_bundled_twoway_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="bundled_twoway_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">burst_trunks</label></div>
        <div id="pvt_limits_burst_trunks" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="burst_trunks" account_id=account_id %}
        </div>
    </div>

    <div class="row">
        <div class="col-xs-6 col-xs-offset-1"><label class="edit_user_label">max_postpay_amount</label></div>
        <div id="pvt_limits_max_postpay_amount" class="col-xs-3">
          {% include "_show_pvt_limits_field.tpl" field_name="max_postpay_amount" account_id=account_id %}
        </div>
    </div>


  </div>
</div>

