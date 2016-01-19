
<script>
    tinyMCE.remove('#html_body');
    tinymce.init({ selector:'#html_body',
                   theme: 'modern',
                   plugins: [
                     'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                     'searchreplace wordcount visualblocks visualchars code fullscreen',
                     'insertdatetime media nonbreaking save table contextmenu directionality',
                     'emoticons template paste textcolor colorpicker textpattern imagetools'
                   ],
                   toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | code',
                   toolbar2: 'print preview media | forecolor backcolor emoticons',
                   image_advtab: true,
                });
</script>

{% wire id="edit-notification-html-form" type="submit" postback="edit_notification_html" delegate="mod_kazoo" %}
<form id="edit-notification-html-form" method="post" action="postback">
  <div class="form-group">
    <textarea id="html_body" name="html_body" style="height: 300px; width: 100%">{{ m.kazoo[{kz_notification_template notification_id=notification_id context_type="text/html"}] }}</textarea>
    <input id="notification_id" type="hidden" name="notification_id" value={{ notification_id }} />
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <button id="button_edit_html" class="col-xs-12 btn btn-zalarm margin-bottom-xs" type="submit">{_ Save template _}</button>
      </div>
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
      </div>
    </div>
  </div>
</form>
