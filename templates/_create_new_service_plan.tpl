<div class="form-group">
  <div class="row">
    <div class="col-sm-6" style="text-align: center; margin-top: 0.5em;">
        Please input new service plan id:
    </div>
    <div class="col-sm-6">
        <input type="text" class="form-control margin-bottom-xs" id="new_service_plan_id" name="new_service_plan_id" value="">
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
              onclick="z_event('service_plan_edit_event', { service_plan_id: $('#new_service_plan_id').val() }); z_dialog_close();">
        {_ Create _}
      </button>
    </div>
  </div>
</div>
