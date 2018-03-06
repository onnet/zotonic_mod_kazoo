{% with m.kazoo[{kz_device_doc device_id=device_id}][1] as device_doc %}
{% wire id="form_device_media_settings"
        type="submit"
        postback="device_media_settings"
        delegate="mod_kazoo"
%}
<form id="form_device_media_settings" method="post" action="postback">
  {% include "media_codecs_select.tpl" doc=device_doc %}
  <input type="hidden" name="device_id" value="{{ device_id }}" />
</form>
{% endwith %}
<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>
