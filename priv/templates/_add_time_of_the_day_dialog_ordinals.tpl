            <select name="ordinal" id="ordinal" class="form-control margin-bottom-xs">
              <option value="first" {% if rule[1]["ordinal"] == "first" %}selected{% endif %}>{_ First _}</option>
              <option value="second" {% if rule[1]["ordinal"] == "second" %}selected{% endif %}>{_ Second _}</option>
              <option value="third" {% if rule[1]["ordinal"] == "third" %}selected{% endif %}>{_ Third _}</option>
              <option value="fourth" {% if rule[1]["ordinal"] == "fourth" %}selected{% endif %}>{_ Fourth _}</option>
              <option value="fifth" {% if rule[1]["ordinal"] == "fifth" %}selected{% endif %}>{_ Fifth _}</option>
              <option value="last" {% if rule[1]["ordinal"] == "last" %}selected{% endif %}>{_ Last _}</option>
              <option value="every" {% if rule[1]["ordinal"] == "every" %}selected{% endif %}>{_ Day _}</option>
            </select>

