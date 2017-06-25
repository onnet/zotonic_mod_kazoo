{% with m.kazoo[{kz_device_doc device_id=device_id}][1] as device_doc %}
{% wire id="form_device_media_settings"
        type="submit"
        postback="device_media_settings"
        delegate="mod_kazoo"
%}
<form id="form_device_media_settings" method="post" action="postback">
  <div class="form-group">
    <div class="row">
        <div class="col-sm-2">
          <label for="PCMA"
                 class="checkbox-inline
                        {% if "PCMA"|member:device_doc["media"][1]["audio"][1]["codecs"] %}
                          checked
                        {% endif %}"
                 style="width: 100%">
            <input type="checkbox"
                   id="PCMA"
                   name="codecs"
                   value="PCMA"
                   {% if "PCMA"|member:device_doc["media"][1]["audio"][1]["codecs"] %}
                     checked
                   {% endif %}>
            {_ PCMA _}
          </label>
        </div>
        <div class="col-sm-2">
          <label for="PCMU"
                 class="checkbox-inline
                        {% if "PCMU"|member:device_doc["media"][1]["audio"][1]["codecs"] %}
                          checked
                        {% endif %}"
                 style="width: 100%">
            <input type="checkbox"
                   id="PCMU"
                   name="codecs"
                   value="PCMU"
                   {% if "PCMU"|member:device_doc["media"][1]["audio"][1]["codecs"] %}
                     checked
                   {% endif %}>
            {_ PCMU _}
          </label>
        </div>

    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Save codecs _}
        </button>
      </div>
    </div>
  </div>
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
