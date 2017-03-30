{% if q.triggervalue %}
  <input type="text"
         id="metaflows_capture_type_input"
         {% if q.triggervalue == "numbers" %}
           placeholder="{_ Input number _}"
         {% elseif q.triggervalue == "patterns" %}
           placeholder="{_ Input regex _}"
         {% endif %}
         class="form-control margin-bottom-xs"
         name="metaflows_capture_type_input" />
{% else %}
  {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
            text=_"Cancel"
            action={update target="metaflows_capture_add_span"
                           template="_metaflows_capture_add.tpl"
                   }
  %}
{% endif %}
