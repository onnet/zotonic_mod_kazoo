{% with m.kazoo[{kz_webhook_info webhook_id=webhook_id}] as webhook %}
{% wire id="form_kz_webhook" type="submit" postback="kz_webhook" delegate="mod_kazoo" %}
<form id="form_kz_webhook" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Webhook name _}
            <input type="text" class="form-control margin-bottom-xs" id="name" name="name" placeholder="{_ Enter webhook name here _}" value="{{ webhook[1]["name"] }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Hook _}
          <select id="hook" name="hook" class="form-control margin-bottom-xs" style="text-align:center;">
                  <option value="channel_create" {% if "channel_create" == webhook[1]["hook"] %}selected{% endif %}>{_ CHANNEL_CREATE _}</option>
                  <option value="channel_answer" {% if "channel_answer" == webhook[1]["hook"] %}selected{% endif %}>{_ CHANNEL_ANSWER _}</option>
                  <option value="channel_destroy" {% if "channel_destroy" == webhook[1]["hook"] %}selected{% endif %}>{_ CHANNEL_DESTROY _}</option>
          </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">{_ Enabled _}
          <select id="enabled" name="enabled" class="form-control margin-bottom-xs" style="text-align:center;">
                  <option value="true" {% if webhook[1]["enabled"] %}selected{% endif %}>{_ Enabled _}</option>
                  <option value="false" {% if not webhook[1]["enabled"] %}selected{% endif %}>{_ Disabled _}</option>
          </select>
          </label>
        </div>
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">{_ Verb _}
          <select id="http_verb" name="http_verb" class="form-control margin-bottom-xs" style="text-align:center;">
                  <option value="post" {% if "post" == webhook[1]["http_verb"] %}selected{% endif %}>POST</option>
                  <option value="get" {% if "get" == webhook[1]["http_verb"] %}selected{% endif %}>GET</option>
          </select>
          </label>
        </div>
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">{_ Retries _}
          <select id="retries" name="retries" class="form-control margin-bottom-xs" style="text-align:center;">
                  <option value="1" {% if "1" == webhook[1]["retries"] %}selected{% endif %}>1</option>
                  <option value="2" {% if "2" == webhook[1]["retries"] %}selected{% endif %}>2</option>
                  <option value="3" {% if "3" == webhook[1]["retries"] %}selected{% endif %}>3</option>
          </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <label class="form-control-onnet margin-bottom-xs">{_ URI _}
            <input type="text" class="form-control margin-bottom-xs" id="uri" name="uri" placeholder="{_ The HTTP URI of the third-party webserver (required) _}" value="{{ webhook[1]["uri"] }}">
          </label>
        </div>
      </div>
    </div>
    <span id="custom_data_span">
      {% for custom_pair in webhook[1]["custom_data"][1] %}
          {% include "_custom_data.tpl" custom_pair=custom_pair %}
      {% endfor %}
      {% if webhook[1]["id"] %}
        <input type="hidden" name="webhook_id" value="{{ webhook[1]["id"] }}">
      {% endif %}
    </span>
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      {% wire id="add_custom_data_field" action={insert_bottom target="custom_data_span" template="_custom_data.tpl"} %}
      <button id="add_custom_data_field" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Add custom data _}</button>
    </div>
  </div>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      {% wire id="save_webhook_btn" action={submit target="form_kz_webhook"} %}
      <button id="save_webhook_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save webhook _}</button>
    </div>
  </div>
</div>
{% endwith %}
