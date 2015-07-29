{% if q.triggervalue=="number_type_3" %} 
    <input type="text" class="form-control margin-bottom-xs" name="new_pattern" placeholder="Regex pattern: ^\*24([0-9]*)$">
{% elseif q.triggervalue=="number_type_2" %} 
    <input type="text" class="form-control margin-bottom-xs" name="new_number" placeholder="Enter extension number here">
{% else %}
    <select name="new_number" class="form-control margin-bottom-xs" style="text-align:center;">
    {% for number in m.inno.get_acc_numbers_info %}
      {% if not number[2][1]["used_by"] %}
      <option value="{{ number[1] }}">{{ number[1] }}</option>
      {% endif %}
    {% endfor %}
    </select>
{% endif %}
