{% with m.kazoo[{queue queue_id=queue_id account_id=account_id}] as queue %}
  {% wire id="form_queue_update" type="submit" postback="queue_update" delegate="mod_kazoo" %}
  <form id="form_queue_update" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="queue_name"
                 name="queue_name"
                 placeholder="Enter queue name here"
                 value="{{ queue[1]["name"] }}">
        </div>
        <div class="col-sm-3">
          <select id="strategy"
                  name="strategy"
                  class="form-control margin-bottom-xs"
                  style="text-align:center;">
            <option value="round_robin"
                    {% if queue[1]["strategy"] == "round_robin" %}
                      selected
                    {% endif %}>
              {_ Round robin _}
            </option>
              <option value="most_idle"
                    {% if queue[1]["strategy"] == "most_idle" %}
                      selected
                    {% endif %}>
              {_ Most idle _}
            </option>
          </select>
        </div>
        <div class="col-sm-3">
          <label for="enter_when_empty"
                 class="checkbox-inline {% if queue[1]["enter_when_empty"] %}checked{% endif %}"
                 style="width: 100%">
            <input type="checkbox"
                   id="enter_when_empty"
                   name="enter_when_empty"
                   {% if queue[1]["enter_when_empty"] %}checked{% endif %}>
            {_ Enter when empty _}
          </label>
        </div>
        <div class="col-sm-3">
          <label for="record_caller"
                 class="checkbox-inline {% if queue[1]["record_caller"] %}checked{% endif %}"
                 style="width: 100%">
            <input type="checkbox"
                   id="record_caller"
                   name="record_caller"
                   {% if queue[1]["record_caller"] %}checked{% endif %}>
            {_ Record caller _}
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Agent ring timeout _}
            <select id="agent_ring_timeout" name="agent_ring_timeout" class="form-control-onnet">
              {% for seconds in 1|range:15 %}
                <option value="{{ seconds }}"
                        {% if queue[1]["agent_ring_timeout"] == seconds %}
                          selected
                        {% elif (not queue[1]["agent_ring_timeout"] ) and seconds == 10 %}
                          selected
                        {% endif %}>
                  {{ seconds }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Agent wrapup time _}
            <select id="agent_wrapup_time" name="agent_wrapup_time" class="form-control-onnet">
              {% for seconds in ["0"] ++ 1|range:30 %}
                <option value="{{ seconds }}"
                        {% if queue[1]["agent_wrapup_time"] == seconds %}
                          selected
                        {% endif %}>
                  {{ seconds }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Caller exit key _}
            <select id="caller_exit_key"
                    name="caller_exit_key"
                    class="form-control-onnet">
              {% for key in 1|range:9 ++ ["0","*","#"] %}
                <option value="{{ key }}"
                        {% if queue[1]["caller_exit_key"] == key %}
                          selected
                        {% elif (not queue[1]["caller_exit_key"] ) and key == "#" %}
                          selected
                        {% endif %}>
                  {{ key }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Connection timeout _}
            <input id="connection_timeout"
                   name="connection_timeout"
                   type="text"
                   class="form-control margin-bottom-xs"
                   placeholder="Connection timeout"
                   {% if queue[1]["connection_timeout"] %}
                     value='{{ queue[1]["connection_timeout"] }}'
                   {% else %}
                     value='3600'
                   {% endif %}
            >
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Max queue size _}
            <select id="max_queue_size" name="max_queue_size" class="form-control-onnet">
              {% for calls in ["0"] ++ 1|range:15 %}
                <option value="{{ calls }}"
                        {% if queue[1]["max_queue_size"] == calls %}
                          selected
                        {% endif %}>
                  {{ calls }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Ring simultaneously _}
            <select id="ring_simultaneously" name="ring_simultaneously" class="form-control-onnet">
              {% for calls in 1|range:15 %}
                <option value="{{ calls }}"
                        {% if queue[1]["ring_simultaneously"] == calls %}
                          selected
                        {% endif %}>
                  {{ calls }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ MOH _}
            <select id="moh"
                    name="moh"
                    class="form-control margin-bottom-xs"
                    style="text-align:center;"
                    data-live-search="true">
              <option value=""
                      {% if not queue[1]["moh"] %}
                        selected
                      {% endif %}>
                {_ Default _}
              </option>
              {% for option in m.kazoo.kz_list_account_media %}
                <option value="{{ option[1]["id"] }}"
                        {% if queue[1]["moh"] == option[1]["id"] %}
                          selected
                        {% endif %}>
                  {{ option[1]["name"] }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">
            {_ Announcement _}
            <select id="announce"
                    name="announce"
                    class="form-control margin-bottom-xs"
                    style="text-align:center;"
                    data-live-search="true">
              <option value=""
                      {% if not queue[1]["announce"] %}
                        selected
                      {% endif %}>
                {_ None _}
              </option>
              {% for option in m.kazoo.kz_list_account_media %}
                <option value="{{ option[1]["id"] }}"
                        {% if queue[1]["announce"] == option[1]["id"] %}
                          selected
                        {% endif %}>
                  {{ option[1]["name"] }}
                </option>
              {% endfor %}
            </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save queue _}</button>
        </div>
      </div>
    </div>
    {% if queue_id %}
      <input type="hidden" name="queue_id" value="{{ queue[1]["id"] }}">
    {% endif %}
  </form>
{% endwith %}

<script type="text/javascript">
$(document).ready(function() {
        $('.form-group').on('click','input[type=checkbox]',function() {
                $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
        });
});
</script>
