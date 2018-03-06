{% with m.kazoo.get_callflow_numbers_and_patterns as numbers %}
{% if not numbers or numbers|length==0 %}
<div class="number_row">
  {% wire id="cf_add_number" action={ dialog_open title=_"Add number" template="_cf_add_number.tpl" } %}
  <div id="cf_add_number" class="number_column empty full">
    {_ Click to add number _}
  </div>
  <div class="clear">
  </div>
</div>
{% else %}
{% for numbers_pair in numbers|chunk:2 %}
<div class="number_row">
  <div class="number_column first" data-number="{{ numbers_pair[1] }}">
    {{ numbers_pair[1] }}
    {% wire id=numbers_pair[1]|cleanout
            action={postback postback={cf_delete_number number=numbers_pair[1]} delegate="mod_kazoo"}
            action={postback postback={cf_note_number action="remove" number=numbers_pair[1]} delegate="mod_kazoo"}
    %}
    <span id="{{ numbers_pair[1]|cleanout }}" class="delete">
    </span>
  </div>
  {% if numbers_pair[2] %}
  <div class="number_column second" data-number="{{ numbers_pair[2] }}">
    {{ numbers_pair[2] }}
    {% wire id=numbers_pair[2]|cleanout
            action={postback postback={cf_delete_number number=numbers_pair[2]} delegate="mod_kazoo"}
            action={postback postback={cf_note_number action="remove" number=numbers_pair[2]} delegate="mod_kazoo"}
    %}
    <span id="{{ numbers_pair[2]|cleanout }}" class="delete">
    </span>
  </div>
  {% else %}
  {% wire id="cf_add_number" action={ dialog_open title=_"Add number" template="_cf_add_number.tpl" } %}
  <div id="cf_add_number" class="number_column empty second">{_ Click to add number _}</div>
  {% endif %}
  <div class="clear">
  </div>
</div>
{% endfor %} 
{% if numbers|length|to_integer|is_even %}
<div class="number_row">
  {% wire id="cf_add_number" action={ dialog_open title=_"Add number" template="_cf_add_number.tpl" } %}
  <div id="cf_add_number" class="number_column empty full">
    {_ Click to add number _}
  </div>
  <div class="clear">
  </div>
</div>
{% endif %}
{% endif %}
{% endwith %}
