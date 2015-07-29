<div id="{{ #device_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#device_edit template="_edit_device.tpl" device_id=device_id} %}
  </div>
</div>
