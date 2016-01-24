{% if q.triggervalue=="specified" or ( not q.triggervalue and recipient_type == "specified" ) %}
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Email addresses _}
            <input type="text" class="form-control margin-bottom-xs" id="input_{{ field_type }}" name="input_{{ field_type }}" 
                                                                     placeholder="{_ Comma separated emails _}"
                                                                     value="{% for email in input_value %}{{ email }}{% if not forloop.last %}, {% endif %}{% endfor %}">
          </label>
        </div>
{% endif %}
