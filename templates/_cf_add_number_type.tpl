{% if q.triggervalue=="number_type_3" %} 
    <input type="text" class="form-control margin-bottom-xs" name="new_pattern" placeholder="Regex pattern: ^\*24([0-9]*)$">
{% elseif q.triggervalue=="number_type_2" %} 
    <input type="text" class="form-control margin-bottom-xs" name="new_number" placeholder="Enter extension number here">
{% else %}
    <select name="new_number" class="form-control margin-bottom-xs" style="text-align:center;">
    {% for number in m.kazoo.kz_spare_numbers %}
        <option value="{{ number }}">{{ number }}</option>
    {% endfor %}
    </select>
{% endif %}
