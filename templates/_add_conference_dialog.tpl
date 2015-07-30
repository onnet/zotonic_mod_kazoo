{% with m.kazoo[{kz_get_account_conference conference_id=conference_id}] as conference %}
{% wire id="form_kz_conference" type="submit" postback="kz_conference" delegate="mod_kazoo" %}
<form id="form_kz_conference" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Conference name _}
            <input type="text" class="form-control margin-bottom-xs" id="name" name="name" placeholder="Enter conference name here" value="{{ conference[1]["name"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Conference owner _}
          <select id="sipphone_owner_id" name="owner_id" class="form-control margin-bottom-xs" style="text-align:center;">
            {% for option in m.kazoo.kz_list_account_users_short %}
                  <option value="{{ option[1] }}" {% if conference[1]["owner_id"] == option[1] or (not option[1] and not conference[1]["owner_id"]) %}selected{% endif %}>{{ option[2] }}</option>
            {% endfor %}
          </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Conference numbers _}
            <input type="text" class="form-control margin-bottom-xs" id="numbers" name="numbers" placeholder="(comma separated)" 
                   value="{% for number in conference[1]["member"][1]["numbers"] %}{{ number }}{% if not forloop.last %}, {% endif %}{% endfor %}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Conference pins _}
            <input type="text" class="form-control margin-bottom-xs" id="pins" name="pins" placeholder="(comma separated)"
                   value="{% for pin in conference[1]["member"][1]["pins"] %}{{ pin }}{% if not forloop.last %}, {% endif %}{% endfor %}">
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label for="join_muted" class="checkbox-inline {% if conference[1]["member"][1]["join_muted"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="join_muted" name="join_muted" {% if conference[1]["member"][1]["join_muted"] %}checked{% endif %}>
            {_ Join muted _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="join_deaf" class="checkbox-inline {% if conference[1]["member"][1]["join_deaf"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="join_deaf" name="join_deaf" {% if conference[1]["member"][1]["join_deaf"] %}checked{% endif %}>
            {_ Join deaf _}
          </label>
        </div>
        <div class="col-sm-4">
          <label for="play_name" class="checkbox-inline {% if conference[1]["play_name"] %}checked{% endif %}" style="width: 100%">
            <input type="checkbox" id="play_name" name="play_name" {% if conference[1]["play_name"] %}checked{% endif %}>
            {_ Play name _}
          </label>
        </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save Conference</button>
        </div>
      </div>
    </div>
    {% if conference[1]["id"] %}
      <input type="hidden" name="conference_id" value="{{ conference[1]["id"] }}">
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
