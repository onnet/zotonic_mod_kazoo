<!--script>
    tinymce.remove('#html_body');
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
</script-->

{% wire id="edit-carrier-template-form" type="submit" postback="edit_carrier_template" delegate="mod_onbill" %}
<form id="edit-carrier-template-form" method="post" action="postback">
  <div class="form-group">
    <textarea id="html_body" name="html_body" style="height: 300px; width: 100%">{{ m.onbill[{carrier_template carrier_id=q.carrier_id template_id=q.template_id}] }}</textarea>
    <input id="carrier_id" type="hidden" name="carrier_id" value={{ q.carrier_id }} />
    <input id="template_id" type="hidden" name="template_id" value={{ q.template_id }} />
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
