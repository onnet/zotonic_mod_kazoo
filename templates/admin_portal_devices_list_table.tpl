{% if m.kazoo[{ui_element_opened element="ap_devices_widget_opened"}] %}
<table id="admin_portal_devices_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center;">{_ Type _}</th>
            <th style="text-align: center;">{_ Name _}</th>
            <th style="text-align: center;">{_ Owner _}</th>
            <th style="text-align: center;">{_ CID Number _}</th>
            <th style="text-align: center;">{_ Edit _}</th>
            <th style="text-align: center;">{_ Info _}</th>
        </tr>
    </thead>
    <tbody>
        {% for device in m.kazoo.kz_list_account_devices %}
        {% with m.kazoo[{kz_get_device_registration_details device_id=device["id"]}] as device_details %}
        {% with m.kazoo[{kz_check_device_registration device_id=device["id"]}] as device_registered %}
        {% with m.kazoo[{kz_device_doc device_id=device["id"]}] as device_doc %}
        {% with device_doc[1]["caller_id"][1][1][2][1][2][2], device_doc[1]["caller_id"][1][2][2][1][2][2] as internal_cid, external_cid %}
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
            <td style="text-align: center;">{{ device["name"]|truncate:13 }}</td>
            <td style="text-align: center;">{% if device["owner_id"] %}{{ m.kazoo[{kz_user_doc_by_ownerid owner_id=device["owner_id"]}][1]["username"]|truncate:13 }}{% else %}-{% endif %}</td>
            <td style="text-align: center;">
                {{ internal_cid }}
                {% if internal_cid and external_cid %} | {% endif %}
                {{ external_cid }}
            </td>
            <td style="text-align: center;"><i id="edit_{{ device["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i></td>
            {% wire id="edit_"++device["id"] action={ dialog_open title=_"Edit device "++device["name"] template="_edit_device_lazy.tpl" device_id=device["id"] } %}
            <td style="text-align: center;">{% if device_registered %}<i id="info_{{ device["id"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>{% else %}-{% endif %}</td>
            {% wire id="info_"++device["id"] action={ dialog_open title=_"Registration details" template="_details.tpl" arg=device_details } %}
        </tr>
        {% endwith %}
        {% endwith %}
        {% endwith %}
        {% endwith %}
        {% endfor %}
    </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_devices_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 5, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},

});
{% endjavascript %}
{% else %}
{% endif %}
