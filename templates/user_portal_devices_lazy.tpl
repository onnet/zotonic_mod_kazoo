{% if m.kazoo[{ui_element_opened element="user_devices_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}

<table id="user_portal_devices_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center;">{_ Type _}</th>
            <th style="text-align: center;">{_ Name _}</th>
            <th style="text-align: center;">{_ IP address _}</th>
            <th style="text-align: center;">{_ Agent _}</th>
            <th style="text-align: center;">{_ Info _}</th>
        </tr>
    </thead>
    <tbody>
        {% for device in m.kazoo.kz_list_user_devices %}
        {% with m.kazoo[{kz_get_device_registration_details device_id=device["id"]}] as device_details %}
        {% with m.kazoo[{kz_check_device_registration device_id=device["id"]}] as device_registered %}
        <tr>
            <td style="text-align: center;">
                {% if device["device_type"]=="sip_device" %}
                  <i class="{% if device["enabled"] %}
                                {% if device_registered %}registered
                                    {% else %}unregistered
                                {% endif %}
                            {% endif %}
                            icon-telicon-voip-phone icon-device"></i>
                {% elseif device["device_type"]=="softphone" %}
                  <i class="{% if device["enabled"] %}
                                {% if m.kazoo[{kz_check_device_registration device_id=device["id"]}] %}registered
                                    {% else %}unregistered
                                {% endif %}
                            {% endif %} 
                            icon-telicon-soft-phone icon-device"></i>
                {% elseif device["device_type"]=="cellphone" %}
                  <i class="registered fa fa-mobile"></i>
                {% else %}
                  <i class="registered fa fa-phone"></i>
                {% endif %}
            </td>
            <td style="text-align: center;">{{ device["name"] }}</td>
            <td style="text-align: center;">{% if device_registered %}{{ device_details[1]["contact_ip"] }}{% else %}-{% endif %}</td>
            <td style="text-align: center;">{% if device_registered %}{{ device_details[1]["user_agent"] }}{% else %}-{% endif %}</td>
            {% wire id="info_"++device["id"] action={ dialog_open title=_"Registration details" template="_details.tpl" arg=device_details } %}
            <td style="text-align: center;">{% if device_registered %}<i id="info_{{ device["id"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>{% else %}-{% endif %}</td>
        </tr>
        {% endwith %}
        {% endwith %}
        {% endfor %}
    </tbody>
</table>
</div> 
{% endwith %}
{% else %}
{% endif %}