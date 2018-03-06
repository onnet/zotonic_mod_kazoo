{% if q.triggervalue=="monthly" or rule[1]["cycle"] == "monthly" %}
        <div class="col-sm-6">
          <div class="col-xs-3 form-control-text">{_ Every _}:</div>
          <div class="col-xs-3"><input id="interval_week" class="form-control margin-bottom-xs" name="interval" type="text" placeholder="1"
                                       value="{% if rule[1]["interval"] %}{{ rule[1]["interval"] }}{% else %}1{% endif %}"></div>
          <div class="col-xs-3 form-control-text">{_ month _}</div>
        </div>
        <div class="col-sm-6">
          <div class="col-sm-6" style="padding-left:0;">
            {% wire id="ordinal" type="change" action={ update target="ordinal_type" template="_add_time_of_the_day_dialog_ordinal_types.tpl" } %}
            {% include "_add_time_of_the_day_dialog_ordinals.tpl" %}
          </div>
          <div id="ordinal_type" class="col-sm-6" style="padding-right:0;">
            {% include "_add_time_of_the_day_dialog_ordinal_types.tpl" %}
          </div>
        </div>
{% elseif q.triggervalue=="yearly" or rule[1]["cycle"] == "yearly" %}
        <div class="col-sm-6">
          <select name="month" id="month" class="form-control margin-bottom-xs">
            <option value="1" {% if rule[1]["month"] == "1" %}selected{% endif %}>{_ January _}</option>
            <option value="2" {% if rule[1]["month"] == "2" %}selected{% endif %}>{_ February _}</option>
            <option value="3" {% if rule[1]["month"] == "3" %}selected{% endif %}>{_ March _}</option>
            <option value="4" {% if rule[1]["month"] == "4" %}selected{% endif %}>{_ April _}</option>
            <option value="5" {% if rule[1]["month"] == "5" %}selected{% endif %}>{_ May _}</option>
            <option value="6" {% if rule[1]["month"] == "6" %}selected{% endif %}>{_ June _}</option>
            <option value="7" {% if rule[1]["month"] == "7" %}selected{% endif %}>{_ July _}</option>
            <option value="8" {% if rule[1]["month"] == "8" %}selected{% endif %}>{_ August _}</option>
            <option value="9" {% if rule[1]["month"] == "9" %}selected{% endif %}>{_ September _}</option>
            <option value="10" {% if rule[1]["month"] == "10" %}selected{% endif %}>{_ October _}</option>
            <option value="11" {% if rule[1]["month"] == "11" %}selected{% endif %}>{_ November _}</option>
            <option value="12" {% if rule[1]["month"] == "12" %}selected{% endif %}>{_ December _}</option>
          </select>
        </div>
        <div class="col-sm-6">
          <div class="col-sm-6" style="padding-left:0;">
            {% wire id="ordinal" type="change" action={ update target="ordinal_type" template="_add_time_of_the_day_dialog_ordinal_types.tpl" } %}
            {% include "_add_time_of_the_day_dialog_ordinals.tpl" %}
          </div>
          <div id="ordinal_type" class="col-sm-6" style="padding-right:0;">
            {% include "_add_time_of_the_day_dialog_ordinal_types.tpl" %}
          </div>
        </div>
{% else %}
        <div class="col-sm-6">
          <div class="col-xs-3 form-control-text">{_ Every _}:</div>
          <div class="col-xs-3"><input id="interval_week" class="form-control margin-bottom-xs" name="interval" type="text" placeholder="1"
                                        value="{% if rule[1]["interval"] %}{{ rule[1]["interval"] }}{% else %}1{% endif %}"></div>
          <div class="col-xs-3 form-control-text">{_ week _}</div>
        </div>
        <div class="col-sm-6">
          <div class="btn-group" data-toggle="buttons">
            <label class="btn btn-zprimary-checkbox {% if "sunday"|member:rule[1]["wdays"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="sunday" autocomplete="off" {% if "sunday"|member:rule[1]["wdays"] %}checked{% endif %}>S
            </label>
            <label class="btn btn-zprimary-checkbox {% if "monday"|member:rule[1]["wdays"] or not rule[1]["id"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="monday" autocomplete="off" {% if "monday"|member:rule[1]["wdays"] or not rule[1]["id"] %}checked{% endif %}>M
            </label>
            <label class="btn btn-zprimary-checkbox {% if "tuesday"|member:rule[1]["wdays"] or not rule[1]["id"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="tuesday" autocomplete="off" {% if "tuesday"|member:rule[1]["wdays"] or not rule[1]["id"] %}checked{% endif %}>T
            </label>
            <label class="btn btn-zprimary-checkbox {% if "wednesday"|member:rule[1]["wdays"] or "wensday"|member:rule[1]["wdays"] or not rule[1]["id"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="wednesday" autocomplete="off" {% if "wednesday"|member:rule[1]["wdays"] or "wensday"|member:rule[1]["wdays"] or not rule[1]["id"] %}checked{% endif %}>W
            </label>
            <label class="btn btn-zprimary-checkbox {% if "thursday"|member:rule[1]["wdays"] or not rule[1]["id"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="thursday" autocomplete="off" {% if "thursday"|member:rule[1]["wdays"] or not rule[1]["id"] %}checked{% endif %}>T
            </label>
            <label class="btn btn-zprimary-checkbox {% if "friday"|member:rule[1]["wdays"] or not rule[1]["id"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="friday" autocomplete="off" {% if "friday"|member:rule[1]["wdays"] or not rule[1]["id"] %}checked{% endif %}>F
            </label>
            <label class="btn btn-zprimary-checkbox {% if "saturday"|member:rule[1]["wdays"] %}active{% endif %}">
              <input type="checkbox" name="wdays" value="saturday" autocomplete="off" {% if "saturday"|member:rule[1]["wdays"] %}checked{% endif %}>S
            </label>
          </div>
        </div>

{% endif %}
