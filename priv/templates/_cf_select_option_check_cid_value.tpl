{% if q.triggervalue=="caller_id" or switch == "caller_id" %}
  <input type="text"
         name="switch"
         class="form-control margin-bottom-xs"
         placeholder="{_ Enter required CID here _}"
         value="{% if switch %}{{ switch }}{% endif %}">
{% else %}
  <input type="hidden"
         name="switch"
         value="{% if switch %}{{ switch }}{% elseif q.triggervalue %}{{ q.triggervalue }}{% else %}nomatch{% endif %}">
{% endif %}
