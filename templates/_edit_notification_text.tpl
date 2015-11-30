{% wire id="edit-notification-text-form" type="submit" postback={edit_notification_text} delegate="mod_kazoo" %}
<form id="edit-notification-text-form" method="post" action="postback" style="padding-bottom: 35px;">

  <textarea name="text_body" style="height: 300px; width: 100%">{{ m.kazoo[{kz_notification_template notification_id=notification_id context_type="text/plain"}] }}</textarea>

  <button class="btn btn-primary btn-large pull-right" style="margin-right: 10px; margin-top: 5px;" type="submit">{_ Send _}</button>
</form>

