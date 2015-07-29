{% if q.triggervalue=="every" or rule[1]["ordinal"] == "every" %}
          <select id="specific_day" name="days" class="form-control margin-bottom-xs">
            <option value="1" {% if rule[1]["days"][1] == "1" %}selected{% endif %}> 1 </option>
            <option value="2" {% if rule[1]["days"][1] == "2" %}selected{% endif %}> 2 </option>
            <option value="3" {% if rule[1]["days"][1] == "3" %}selected{% endif %}> 3 </option>
            <option value="4" {% if rule[1]["days"][1] == "4" %}selected{% endif %}> 4 </option>
            <option value="5" {% if rule[1]["days"][1] == "5" %}selected{% endif %}> 5 </option>
            <option value="6" {% if rule[1]["days"][1] == "6" %}selected{% endif %}> 6 </option>
            <option value="7" {% if rule[1]["days"][1] == "7" %}selected{% endif %}> 7 </option>
            <option value="8" {% if rule[1]["days"][1] == "8" %}selected{% endif %}> 8 </option>
            <option value="9" {% if rule[1]["days"][1] == "9" %}selected{% endif %}> 9 </option>
            <option value="10" {% if rule[1]["days"][1] == "10" %}selected{% endif %}> 10 </option>
            <option value="11" {% if rule[1]["days"][1] == "11" %}selected{% endif %}> 11 </option>
            <option value="12" {% if rule[1]["days"][1] == "12" %}selected{% endif %}> 12 </option>
            <option value="13" {% if rule[1]["days"][1] == "13" %}selected{% endif %}> 13 </option>
            <option value="14" {% if rule[1]["days"][1] == "14" %}selected{% endif %}> 14 </option>
            <option value="15" {% if rule[1]["days"][1] == "15" %}selected{% endif %}> 15 </option>
            <option value="16" {% if rule[1]["days"][1] == "16" %}selected{% endif %}> 16 </option>
            <option value="17" {% if rule[1]["days"][1] == "17" %}selected{% endif %}> 17 </option>
            <option value="18" {% if rule[1]["days"][1] == "18" %}selected{% endif %}> 18 </option>
            <option value="19" {% if rule[1]["days"][1] == "19" %}selected{% endif %}> 19 </option>
            <option value="20" {% if rule[1]["days"][1] == "20" %}selected{% endif %}> 20 </option>
            <option value="21" {% if rule[1]["days"][1] == "21" %}selected{% endif %}> 21 </option>
            <option value="22" {% if rule[1]["days"][1] == "22" %}selected{% endif %}> 22 </option>
            <option value="23" {% if rule[1]["days"][1] == "23" %}selected{% endif %}> 23 </option>
            <option value="24" {% if rule[1]["days"][1] == "24" %}selected{% endif %}> 24 </option>
            <option value="25" {% if rule[1]["days"][1] == "25" %}selected{% endif %}> 25 </option>
            <option value="26" {% if rule[1]["days"][1] == "26" %}selected{% endif %}> 26 </option>
            <option value="27" {% if rule[1]["days"][1] == "27" %}selected{% endif %}> 27 </option>
            <option value="28" {% if rule[1]["days"][1] == "28" %}selected{% endif %}> 28 </option>
            <option value="29" {% if rule[1]["days"][1] == "29" %}selected{% endif %}> 29 </option>
            <option value="30" {% if rule[1]["days"][1] == "30" %}selected{% endif %}> 30 </option>
            <option value="31" {% if rule[1]["days"][1] == "31" %}selected{% endif %}> 31 </option>
          </select>
{% else %} 
            <select id="wday" name="wdays" class="form-control margin-bottom-xs">
              <option value="sunday" {% if rule[1]["wdays"][1] == "sunday" %}selected{% endif %}>Sunday</option>
              <option value="monday" {% if rule[1]["wdays"][1] == "monday" %}selected{% endif %}>Monday</option>
              <option value="tuesday" {% if rule[1]["wdays"][1] == "tuesday" %}selected{% endif %}>Tuesday</option>
              <option value="wednesday" {% if rule[1]["wdays"][1] == "wednesday" %}selected{% endif %}>Wednesday</option>
              <option value="thursday" {% if rule[1]["wdays"][1] == "thursday" %}selected{% endif %}>Thursday</option>
              <option value="friday" {% if rule[1]["wdays"][1] == "friday" %}selected{% endif %}>Friday</option>
              <option value="saturday" {% if rule[1]["wdays"][1] == "saturday" %}selected{% endif %}>Saturday</option>
            </select>
{% endif %}
