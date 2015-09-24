{% if m.kazoo[{ui_element_opened element="user_settings_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}

{% wire id="user_settings_form_form" type="submit" postback={kazoo_user_settings} delegate="mod_kazoo" %}
<form  id="user_settings_form_form" method="post" action="postback">
    <div style="padding-top: 1.5em; padding-left: 1em;">
      {% with m.kazoo.get_user_timezone as user_timezone %}
      <label for="user_timezone">{_ User's timezone _}</label>
      <select class="selectpicker" id="user_timezone" name="user_timezone" data-live-search="true">
      {% for zone in m.kazoo.tz_list %}
        <option value="{{ zone }}" {% if zone == user_timezone %}selected{% endif %}>{{ zone }}</option>
      {% endfor %}
      </select>
      {% endwith %}
    </div>
    <div class="form-inline" style="padding: 1em;">
      <label>{_ Enable Call Forward _}:</label>
          {% wire id="call-forward-enabled" type="click" action={ toggle target="call-forward-data" } %}
          <input class="checkbox" id="call-forward-enabled" name="call_forward_enabled" 
                 type="checkbox" {% if m.kazoo[{kz_user_doc_field field1="call_forward" field2="enabled"}] %}checked="checked"{% endif %} />
    </div>
    <div id="call-forward-data" style="{% if m.kazoo[{kz_user_doc_field field1="call_forward" field2="enabled"}] %}
                                           display: block;
                                       {% else %}
                                           display: none;
                                       {% endif %}">
        <div class="form-inline">
             <label>{_ Forward Calls To _}:</label>
                <input id="ring-number-txt" name="ring-number-txt" type="text" 
                                            style="text-align: center; border: 1px solid rgb(153, 153, 153); border-radius: 3px; width: 10em;"
                                            value="{{ m.kazoo[{kz_user_doc_field field1="call_forward" field2="number"}] }}"/>
        </div>
        <div class="form-inline">
            <label>{_ Also Ring My VoIP Phone _}:</label>
            {% if m.kazoo[{kz_user_doc_field field1="call_forward" field2="substitute"}] %}
                <input class="checkbox" id="ring-device-checkbox" name="ring-device-checkbox" type="checkbox"/>
            {% else %}
                <input class="checkbox" id="ring-device-checkbox" name="ring-device-checkbox" type="checkbox" checked="checked"/>
            {% endif %}
        </div>
        <div class="form-inline">
            <label>{_ Keep Caller ID _}:</label>
            {% if m.kazoo[{kz_user_doc_field field1="call_forward" field2="keep_caller_id"}] %}
                 <input id="call_forward_keep_caller_id" class="checkbox" name="call_forward_keep_caller_id" type="checkbox" checked="checked"/>
            {% else %}
                 <input id="call_forward_keep_caller_id" class="checkbox" name="call_forward_keep_caller_id" type="checkbox"/>
            {% endif %}
        </div>
    </div>
    <div class="form-inline" style="padding-left: 1em; padding-top: 1em;">
        <label>{_ Send Voicemail to Email _}:</label>
        {% wire id="vm-to-email-checkbox" type="click" action={ toggle target="vm-to-email-input" } %}
        <input id="vm-to-email-checkbox" class="checkbox" name="vm-to-email-checkbox" type="checkbox" {% if m.kazoo[{kz_user_doc_field field1="vm_to_email_enabled"}] %}checked="checked"{% endif %} />
    </div>
    <div id="vm-to-email-input" class="form-inline" style="padding-left: 3em; padding-top: 1em; padding-bottom: 1em;
                                   {% if m.kazoo[{kz_user_doc_field field1="vm_to_email_enabled"}] %}
                                       display: block;
                                   {% else %}
                                       display: none;
                                   {% endif %}">
        <label>{_ Email Address _}:</label>
        <input id="vm-to-email-txt" name="vm-to-email-txt" type="text"
                                    style="text-align: center; border: 1px solid rgb(153, 153, 153); border-radius: 3px;"  
                                    value="{{ m.kazoo[{kz_user_doc_field field1="email"}] }}"/>
    </div>
</form>

{% endwith %}
 
{% javascript %}
  $('#user_timezone').selectpicker({
    style: 'btn-xs btn-onnet',
    size: 7
  });
{% endjavascript %}

{% else %}
{% endif %}
