{% with m.kazoo[{kz_get_trunk_server trunk_id=trunk_id server_index=server_index}] as server %}
{% wire id="form_trunkstore_media_settings"
        type="submit"
        postback="trunkstore_media_settings"
        delegate="mod_kazoo"
%}
<form id="form_trunkstore_media_settings" method="post" action="postback">
  {% include "_trunkstore_codecs_select.tpl" codecs=server[1]["options"][1]["codecs"] %}
  {% if trunk_id %}
    <input type="hidden" name="trunk_id" value="{{ trunk_id }}">
  {% endif %}
  {% if server_index %}
    <input type="hidden" name="server_index" value="{{ server_index }}">
  {% endif %}
</form>
{% endwith %}
<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>
