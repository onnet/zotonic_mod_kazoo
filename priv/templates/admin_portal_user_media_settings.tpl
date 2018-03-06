{% with m.kazoo[{kz_user_doc_by_ownerid owner_id=user_id}][1] as user_doc %}
{% wire id="form_user_media_settings"
        type="submit"
        postback="user_media_settings"
        delegate="mod_kazoo"
%}
<form id="form_user_media_settings" method="post" action="postback">
  {% include "media_codecs_select.tpl" doc=user_doc %}
  <input type="hidden" name="user_id" value="{{ user_id }}" />
</form>
{% endwith %}
<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>
