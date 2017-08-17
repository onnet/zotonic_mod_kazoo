<div id="{{ #notification_edit }}">
  <div class="text-center">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
       action={update target=#notification_edit
                      template="_edit_notification.tpl"
                      notification_id=notification_id
              }
    %}
  </div>
</div>
