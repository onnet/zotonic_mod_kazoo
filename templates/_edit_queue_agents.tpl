{% with m.kazoo[{queue_roster queue_id=queue_id account_id=account_id}] as agents %}
  {% wire id="form_queue_agents" type="submit" postback="queue_agents" delegate="mod_kazoo" %}
  <form id="form_queue_agents" method="post" action="postback">
    <div class="form-group" id="grp_users_list">
        <h4>Users:</h4>
        <div class="col-sm-12 columns">
          {% for option in m.kazoo.kz_list_account_users_short %}
          {% if option[1] %}
          <label for="{{ option[1]|truncate:8:"" }}"
                 class="checkbox-inline {% if option[1]|member:agents %}checked{% endif %}">
            <input type="checkbox"
                   value="{{ option[1] }}"
                   id="{{ option[1]|truncate:8:"" }}"
                   name="user"
                   {% if option[1]|member:agents %}checked{% endif %}>
            {{ option[2] }}
          </label>
          {% endif %}
          {% endfor %}
        </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12 pt-1">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save agents _}</button>
        </div>
      </div>
    </div>
    {% if queue_id %}
      <input type="hidden" name="queue_id" value="{{ queue_id }}">
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

