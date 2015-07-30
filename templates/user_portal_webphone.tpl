{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="user_webphone_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="user_webphone_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="user_webphone_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="user_webphone_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  <span id="status_registration"></span>
  <span id="headline_webphone">{{ headline }}</span>
  <span id="deregister_cross" class="display_none"><i class="fa fa-close fa-1" title="{_ Deregister _}" style="cursor: pointer; font-size: 0.7em;"></i></span>
  {% wire id="deregister_cross" action={session_set key="webrtc_dev_sip_username" value=""} 
                                action={script script="phone_deregister()"} 
                                action={update target="user_portal_webphone_lazy_tpl" template="user_portal_webphone_lazy.tpl" headline=_"Webphone"} 
  %}
  <span id="status_line"></span>

{% if m.session.webrtc_dev_sip_username %}
  {% button id="webrtc_register_button" class="btn btn-xs btn-onnet pull-right display_none" text=_"register" action={submit target="start-webphone-form"} %}
  <select id="webrtc_device_select" name="webrtc_device" class="pull-right display_none" style="height: 1.5em;">
  {% for device in m.kazoo.kz_list_user_devices %}
      <option value="{{ device["id"] }}">{{ device["name"]|escape }}</option>
  {% endfor %}
  </select>
  {% button id="webrtc_xfer_cancel" class="btn btn-xs btn-onnet pull-right display_none" text=_"cancel" action={script script="xfer_cancel()"} %}
  {% button id="webrtc_xfer_send" class="btn btn-xs btn-onnet pull-right display_none" text=_"send" action={script script="xfer_send()"} %}
  {% button id="webrtc_call_reject" class="btn btn-xs btn-onnet pull-right display_none" text=_"reject" action={script script="call_reject()"} %}
  {% button id="webrtc_call_accept" class="btn btn-xs btn-onnet pull-right display_none" text=_"accept" action={script script="call_accept()"} %}
  {% button id="webrtc_hangup_button" class="btn btn-xs btn-onnet pull-right display_none" text=_"hang up" action={script script="endSession()"} %}
  {% button id="webrtc_call_button" class="btn btn-xs btn-onnet pull-right" text=_"call" action={script script="dial()"} %}
  <input type="text" id="webrtc_destination" class="pull-right" placeholder="Enter a Phone number" value="" autofocus>
{% endif %}

{% if not m.session.webrtc_dev_sip_username %}
  {% button id="webrtc_register_button" class="btn btn-xs btn-onnet pull-right" text=_"register" action={submit target="start-webphone-form"} %}
  <select id="webrtc_device_select" name="webrtc_device" class="pull-right" style="height: 1.5em;">
  {% for device in m.kazoo.kz_list_user_devices %}
    <option value="{{ device["id"] }}">{{ device["name"]|escape }}</option>
  {% endfor %}
  </select>
  {% button id="webrtc_xfer_cancel" class="btn btn-xs btn-onnet pull-right display_none" text=_"cancel" action={script script="xfer_cancel()"} %}
  {% button id="webrtc_xfer_send" class="btn btn-xs btn-onnet pull-right display_none" text=_"send" action={script script="xfer_send()"} %}
  {% button id="webrtc_call_reject" class="btn btn-xs btn-onnet pull-right display_none" text=_"reject" action={script script="call_reject()"} %}
  {% button id="webrtc_call_accept" class="btn btn-xs btn-onnet pull-right display_none" text=_"accept" action={script script="call_accept()"} %}
  {% button id="webrtc_hangup_button" class="btn btn-xs btn-onnet pull-right display_none" text=_"hang up" action={script script="endSession()"} %}
  {% button id="webrtc_call_button" class="btn btn-xs btn-onnet pull-right display_none" text=_"call" action={script script="dial()"} %}
  <input type="text" id="webrtc_destination" class="pull-right display_none" placeholder="Enter a Phone number" value="" autofocus>
{% endif %}

{% endblock %}


{% block widget_content %}
<div id="user_webphone_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="user_webphone_widget_opened"}] %}display: none;{% endif %}">
  <div id="webphone_widget">
    {% include "user_portal_phone.tpl" %}
  </div>
</div>
{% endblock %}

