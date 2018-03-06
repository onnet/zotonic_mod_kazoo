{% if q.triggervalue=="device" or quasitriggervalue=="device" %}
  <select id="group_user_device_selector"
          name="{% if selector_name %}{{ selector_name }}{% else %}selected{% endif %}"
          class="form-control margin-bottom-xs"
          style="text-align:center;">
    {% for option in m.kazoo.kz_list_account_devices_short %}
      {% if option[1] %}
        <option value='{"id":"{{ option[1] }}","name":"{{ option[2] }}" }'
                {% if selected_element==option[1]  %}
                  selected
                {% endif %}>
          {{ option[2] }}
        </option>
      {% endif %}
    {% endfor %}
  </select>
{% elseif q.triggervalue=="user" or quasitriggervalue=="user" %}
  <select id="group_user_device_selector"
          name="{% if selector_name %}{{ selector_name }}{% else %}selected{% endif %}"
          class="form-control margin-bottom-xs"
          style="text-align:center;">
    {% for option in m.kazoo.kz_list_account_users_short %}
      {% if option[1] %}
        <option value='{"id":"{{ option[1] }}","name":"{{ option[2] }}" }'
                {% if selected_element==option[1]  %}
                  selected
                {% endif %}>
          {{ option[2] }}
        </option>
      {% endif %}
    {% endfor %}
  </select>
{% else %}
  <select id="group_user_device_selector"
          name="{% if selector_name %}{{ selector_name }}{% else %}selected{% endif %}"
          class="form-control margin-bottom-xs"
          style="text-align:center;">
    {% for group in m.kazoo.kz_list_account_groups %}
      <option value='{"id":"{{ group[1]["id"] }}","name":"{{ group[1]["name"] }}" }'
              {% if selected_element==group[1]["id"]  %}
                selected
              {% endif %}>
        {{ group[1]["name"] }}
      </option>
    {% endfor %}
  </select>
{% endif %}
