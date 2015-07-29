            <select name="ordinal" id="ordinal" class="form-control margin-bottom-xs">
              <option value="first" {% if rule[1]["ordinal"] == "first" %}selected{% endif %}>First</option>
              <option value="second" {% if rule[1]["ordinal"] == "second" %}selected{% endif %}>Second</option>
              <option value="third" {% if rule[1]["ordinal"] == "third" %}selected{% endif %}>Third</option>
              <option value="fourth" {% if rule[1]["ordinal"] == "fourth" %}selected{% endif %}>Fourth</option>
              <option value="fifth" {% if rule[1]["ordinal"] == "fifth" %}selected{% endif %}>Fifth</option>
              <option value="last" {% if rule[1]["ordinal"] == "last" %}selected{% endif %}>Last</option>
              <option value="every" {% if rule[1]["ordinal"] == "every" %}selected{% endif %}>Day</option>
            </select>

