{% if ts_number %}
<li id="li_{{ ts_number|cleanout }}" class="list-group-item text-center">
  {{ ts_number }}
  <input type="hidden" name="ts_number" value="{{ ts_number }}" />
  {% wire id="delete_"++ts_number|cleanout action={remove target="li_"++ts_number|cleanout}
                                           action={show target="option_"++ts_number|cleanout}
  %}
  <i id="delete_{{ ts_number|cleanout }}" class="fa fa-trash-o pointer" title="Delete" style="float: right;"></i>
</li>
{% else %}
{% with q.triggervalue as ts_number %}
<li id="li_{{ ts_number|cleanout }}" class="list-group-item text-center">
  {{ ts_number }}
  <input type="hidden" name="ts_number" value="{{ ts_number }}" />
  {% wire id="delete_"++ts_number|cleanout action={remove target="li_"++ts_number|cleanout}
                                           action={show target="option_"++ts_number|cleanout}
  %}
  <i id="delete_{{ ts_number|cleanout }}" class="fa fa-trash-o pointer" title="Delete" style="float: right;"></i>
</li>
{% endwith %}
{% endif %}
