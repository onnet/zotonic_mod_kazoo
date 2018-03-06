<div id="admin_user_devices">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="admin_user_devices"
                            template="admin_portal_user_devices.tpl"
                            user_id=user_id
                    }
    %}
  </div>
</div>
