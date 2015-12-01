{% wire id="edit-notification-html-form" type="submit" postback="edit_notification_html" delegate="mod_kazoo" %}
<form id="edit-notification-html-form" method="post" action="postback" style="padding-bottom: 35px;">

  <textarea name="html_body" class="tinymce-init" style="height: 300px; width: 100%">{{ m.kazoo[{kz_notification_template notification_id=notification_id context_type="text/html"}] }}</textarea>

{% button text="add editor" action={editor_add} %}
  <input id="notification_id" type="hidden" name="notification_id" value={{ notification_id }} />
  <button class="btn btn-primary btn-large pull-right" style="margin-right: 10px; margin-top: 5px;" type="submit">{_ Send _}</button>
</form>

{% javascript %}
    z_tinymce_init();
{% endjavascript %}
