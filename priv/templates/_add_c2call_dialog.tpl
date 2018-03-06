{% with m.kazoo[{kz_get_account_c2call c2call_id=c2call_id}] as c2call %}
{% wire id="form_kz_c2call" type="submit" postback="kz_c2call" delegate="mod_kazoo" %}
<form id="form_kz_c2call" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Click-to-Call _}
            <input type="text" class="form-control margin-bottom-xs" id="name" name="name" placeholder="{_ Enter Click-to-Call name here _}" value="{{ c2call[1]["name"] }}">
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Auth required _}
          <select id="auth_required" name="auth_required" class="form-control margin-bottom-xs" style="text-align:center;">
                  <option value="true" {% if c2call[1]["auth_required"] %}selected{% endif %}>Auth</option>
                  <option value="false" {% if not c2call[1]["auth_required"] %}selected{% endif %}>No auth</option>
          </select>
          </label>
        </div>
        <div class="col-sm-3">
          <label class="form-control-onnet margin-bottom-xs">{_ Dial first _}
          <select id="dial_first" name="dial_first" class="form-control margin-bottom-xs" style="text-align:center;">
                  <option value="contact" {% if c2call[1]["dial_first"] == "contact" %}selected{% endif %}>contact</option>
                  <option value="extension" {% if c2call[1]["dial_first"] == "extension" %}selected{% endif %}>extension</option>
          </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Extension _}
            <select id="extension" name="extension" class="form-control margin-bottom-xs selectpicker" style="text-align:center;" data-live-search="true">
              {% for option in m.kazoo.kz_list_account_callflows %}
                {% if not option["featurecode"] and option["numbers"][1]|match:"^\\+?\\d+$" %}
                  <option value="{{ option["numbers"][1] }}" {% if c2call[1]["extension"] == option["numbers"][1] %}selected{% endif %}>{{ option["numbers"][1] }}</option>
                {% endif %}
              {% endfor %}
            </select>
            {% javascript %}
                $('#extension').selectpicker({
                  size: 7
                });
            {% endjavascript %}
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ CID Number _}
            <select id="caller_id_number" name="caller_id_number" class="form-control margin-bottom-xs selectpicker" style="text-align:center;" data-live-search="true">
              {% for number in m.kazoo.get_acc_numbers %}
                  <option value="{{ number }}" {% if c2call[1]["caller_id_number"] == number %}selected{% endif %}>{{ number }}</option>
              {% endfor %}
            </select>
            {% javascript %}
                $('#caller_id_number').selectpicker({
                  size: 7
                });
            {% endjavascript %}
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save Click-to-Call _}</button>
        </div>
      </div>
    </div>
    {% if c2call[1]["id"] %}
      <input type="hidden" name="c2call_id" value="{{ c2call[1]["id"] }}">
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
