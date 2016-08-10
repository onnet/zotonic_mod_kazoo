
<div class="form-group">
  <label>
    {_ WebRTC Agent _}:
    <input type="text" name="user_agent_string" id="user_agent_string" value="{{ m.config.mod_kazoo.user_agent_string.value }}" placeholder="OnNet WebRTC Agent" />
  </label>
  {% wire id="user_agent_string" type="blur" action={config_toggle module="mod_kazoo" key="user_agent_string"} %}
</div>

<div class="form-group">
  <label>
    {_ WSS Port _}:
    <input type="text" name="wss_port" id="wss_port" value="{{ m.config.mod_kazoo.wss_port.value }}" placeholder="5065" />
  </label>
  {% wire id="wss_port" type="blur" action={config_toggle module="mod_kazoo" key="wss_port"} %}
</div>

<div class="form-group">
  <label>
    {_ SIP registrar _}:
    <input type="text" name="sip_registrar" id="sip_registrar" value="{{ m.config.mod_kazoo.sip_registrar.value }}" placeholder="sip.onnet.su" />
  </label>
  {% wire id="sip_registrar" type="blur" action={config_toggle module="mod_kazoo" key="sip_registrar"} %}
</div>

<div class="form-group">
  <label>
    {_ Signup service plan _}:
    <input type="text" name="signup_service_plan" id="signup_service_plan" value="{{ m.config.mod_kazoo.signup_service_plan.value }}" placeholder="signup_plan" />
  </label>
  {% wire id="signup_service_plan" type="blur" action={config_toggle module="mod_kazoo" key="signup_service_plan"} %}
</div>

<div class="form-group">
  <label>
    {_ Sender name _}:
    <input type="text" name="sender_name" id="sender_name" value="{{ m.config.mod_kazoo.sender_name.value }}" placeholder="OnNet Innovations Limited" />
  </label>
  {% wire id="sender_name" type="blur" action={config_toggle module="mod_kazoo" key="sender_name"} %}
</div>

<div class="form-group">
  <label>
    {_ Sales email _}:
    <input type="text" name="sales_email" id="sales_email" value="{{ m.config.mod_kazoo.sales_email.value }}" placeholder="info@onnet.info" />
  </label>
  {% wire id="sales_email" type="blur" action={config_toggle module="mod_kazoo" key="sales_email"} %}
</div>

<div class="form-group">
  <label>
    {_ CRM email _}:
    <input type="text" name="crm_email" id="crm_email" value="{{ m.config.mod_kazoo.crm_email.value }}" placeholder="info@onnet.info" />
  </label>
  {% wire id="crm_email" type="blur" action={config_toggle module="mod_kazoo" key="crm_email"} %}
</div>

<div class="form-group">
  <label>
    {_ Rates file _}:
    <input type="text" name="rates_file" id="rates_file" value="{{ m.config.mod_kazoo.rates_file.value }}"
           placeholder="/home/zotonic/zotonic/user/modules/mod_kazoo/files/unhandled/rates.txt" />
  </label>
  {% wire id="rates_file" type="blur" action={config_toggle module="mod_kazoo" key="rates_file"} %}
</div>

<div class="form-group">
  <label>
    {_ Page header _}:
    <input type="text" name="page_header" id="page_header" value="{{ m.config.mod_kazoo.page_header.value }}" placeholder="OnNet Innovations Limited" />
  </label>
  {% wire id="page_header" type="blur" action={config_toggle module="mod_kazoo" key="page_header"} %}
</div>

<div class="form-group">
  <label>
    {_ Local currency sign _}:
    <input type="text" name="local_currency_sign" id="local_currency_sign" value="{{ m.config.mod_kazoo.local_currency_sign.value }}" placeholder="£" />
  </label>
  {% wire id="local_currency_sign" type="blur" action={config_toggle module="mod_kazoo" key="local_currency_sign"} %}
</div>

<div class="form-group">
  <label>
    {_ Super_duper API key _}:
    <input type="text" name="kazoo_super_duper_api_key" id="kazoo_super_duper_api_key" value="{{ m.config.mod_kazoo.kazoo_super_duper_api_key.value }}"
           placeholder="7be0c26282db096e3706as660adb0ae5e25ad86gdzgx362b2cc425b971b61" />
  </label>
  {% wire id="kazoo_super_duper_api_key" type="blur" action={config_toggle module="mod_kazoo" key="kazoo_super_duper_api_key"} %}
</div>

<div class="form-group">
  <label>
    {_ Kazoo portal url _}:
    <input type="text" name="kazoo_portal_url" id="kazoo_portal_url" value="{{ m.config.mod_kazoo.kazoo_portal_url.value }}" placeholder="https://onnet.info" />
  </label>
  {% wire id="kazoo_portal_url" type="blur" action={config_toggle module="mod_kazoo" key="kazoo_portal_url"} %}
</div>

<div class="form-group">
  <label>
    {_ Kazoo default realm _}:
    <input type="text" name="kazoo_default_realm" id="kazoo_default_realm" value="{{ m.config.mod_kazoo.kazoo_default_realm.value }}" placeholder=".sip.onnet.info" />
  </label>
  {% wire id="kazoo_default_realm" type="blur" action={config_toggle module="mod_kazoo" key="kazoo_default_realm"} %}
</div>

<div class="form-group">
  <label>
    {_ Kazoo crossbar url _}:
    <input type="text" name="kazoo_crossbar_url" id="kazoo_crossbar_url" value="{{ m.config.mod_kazoo.kazoo_crossbar_url.value }}"
           placeholder="https://crossbar.onnet.su:8443" />
  </label>
  {% wire id="kazoo_crossbar_url" type="blur" action={config_toggle module="mod_kazoo" key="kazoo_crossbar_url"} %}
</div>

<div class="form-group">
  <label>
    {_ Kazoo blackhole url _}:
    <input type="text" name="kazoo_blackhole_url" id="kazoo_blackhole_url" value="{{ m.config.mod_kazoo.kazoo_blackhole_url.value }}"
           placeholder="wss://blckhole.onnet.su:7777" />
  </label>
  {% wire id="kazoo_blackhole_url" type="blur" action={config_toggle module="mod_kazoo" key="kazoo_blackhole_url"} %}
</div>

<div class="form-group">
  <label>
    {_ g_capture site key _}:
    <input type="text" name="g_capture_site_key" id="g_capture_site_key" value="{{ m.config.mod_kazoo.g_capture_site_key.value }}"
           placeholder="QKgITAAAAAMW9-6UhJSYpnWtY_J2" />
  </label>
  {% wire id="g_capture_site_key" type="blur" action={config_toggle module="mod_kazoo" key="g_capture_site_key"} %}
</div>

<div class="form-group">
  <label>
    {_ g_capture secret _}:
    <input type="text" name="g_capture_secret" id="g_capture_secret" value="{{ m.config.mod_kazoo.g_capture_secret.value }}"
           placeholder="dQKgITAAAAAJrju2Bw1StR9Y_srd" />
  </label>
  {% wire id="g_capture_secret" type="blur" action={config_toggle module="mod_kazoo" key="g_capture_secret"} %}
</div>

<div class="form-group">
  <label>
    {_ Default kazoo timezone _}:
    <input type="text" name="default_kazoo_timezone" id="default_kazoo_timezone" value="{{ m.config.mod_kazoo.default_kazoo_timezone.value }}"
           placeholder="Europe/London" />
  </label>
  {% wire id="default_kazoo_timezone" type="blur" action={config_toggle module="mod_kazoo" key="default_kazoo_timezone"} %}
</div>

<div class="form-group">
  <label>
    {_ Default kazoo language _}:
    <input type="text" name="default_kazoo_language" id="default_kazoo_language" value="{{ m.config.mod_kazoo.default_kazoo_language.value }}"
           placeholder="en-us" />
  </label>
  {% wire id="default_kazoo_language" type="blur" action={config_toggle module="mod_kazoo" key="default_kazoo_language"} %}
</div>

<div class="form-group">
  <label>
    {_ Color1 _}:
    <input type="text" name="color1" id="color1" value="{{ m.config.mod_kazoo.color1.value }}" placeholder="#3E7A8C" />
  </label>
  {% wire id="color1" type="blur" action={config_toggle module="mod_kazoo" key="color1"} %}
</div>

<div class="form-group">
  <label>
    {_ Color2 _}:
    <input type="text" name="color2" id="color2" value="{{ m.config.mod_kazoo.color2.value }}" placeholder="#E86110" />
  </label>
  {% wire id="color2" type="blur" action={config_toggle module="mod_kazoo" key="color2"} %}
</div>

<div class="form-group">
  <label>
    {_ Color3 _}:
    <input type="text" name="color3" id="color3" value="{{ m.config.mod_kazoo.color3.value }}" placeholder="#ffffff" />
  </label>
  {% wire id="color3" type="blur" action={config_toggle module="mod_kazoo" key="color3"} %}
</div>

<div class="form-group">
  <label>
    {_ Color4 _}:
    <input type="text" name="color4" id="color4" value="{{ m.config.mod_kazoo.color4.value }}" placeholder="#C3C2C2" />
  </label>
  {% wire id="color4" type="blur" action={config_toggle module="mod_kazoo" key="color4"} %}
</div>

<div class="form-group">
  <label>
    {_ show_finance_info _}:
    <input type="checkbox" id="show_finance_info" value="true" {% if m.config.mod_kazoo.show_finance_info.value %}checked="checked"{% endif %} />
  </label>
  {% wire id="show_finance_info" action={config_toggle module="mod_kazoo" key="show_finance_info"} %}
</div>

<div class="modal-footer">
  {% button class="btn btn-default" text=_"Close" action={dialog_close} %}
</div>

