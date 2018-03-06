{% if q.triggervalue %}
  <input type="text"
         id="capture_number_or_pattern"
         {% if q.triggervalue == "numbers" %}
           placeholder="{_ Input Number _}"
         {% elseif q.triggervalue == "patterns" %}
           placeholder="{_ Regex _}: ^2(\d{2,7})?#$"
         {% endif %}
         class="form-control margin-bottom-xs"
         name="capture_number_or_pattern" />
{% else %}
  {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
            text=_"Cancel"
            action={update target="metaflows_capture_add_span"
                           template="_metaflows_capture_add.tpl"
                   }
  %}
{% endif %}
