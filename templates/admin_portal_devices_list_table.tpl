{% if m.kazoo[{ui_element_opened element="ap_devices_widget_opened"}] %}
<table id="admin_portal_devices_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;"></th>
      <th style="text-align: center;">{_ Type _}</th>
      <th style="text-align: center;">{_ Name _}</th>
      <th style="text-align: center;">{_ Owner _}</th>
      <th style="text-align: center;">{_ CID Number _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for device in m.kazoo.kz_list_account_devices %}
      {% with
           m.kazoo[{kz_check_device_registration device_id=device[1]["id"]}]
         as
           device_registered
      %}
      {% with m.kazoo[{kz_device_doc device_id=device[1]["id"]}] as device_doc %}
      {% with
           device_doc[1]["caller_id"][1]["internal"][1]["number"],
           device_doc[1]["caller_id"][1]["external"][1]["number"]
         as
           internal_cid,
           external_cid
      %}
        <tr>
          <td style="text-align: center;">
            {% if device[1]["enabled"] %}
              <i id="toggle_device_enabled_{{ device[1]["id"] }}"
                 class="fa fa-toggle-on pointer"></i>
              {% wire id="toggle_device_enabled_"++device[1]["id"]
                      action={confirm text=_"Do you really want to enable this device"++"?"
                                      action={postback postback={disable_doc type doc_id field_name}
                                                       inject_args type="device"
                                                                   doc_id=device[1]["id"]
                                                                   field_name="enabled"
                                                       delegate="mod_kazoo"
                                             }
                             }
              %}
            {% else %}
              <i id="toggle_device_enabled_{{ device[1]["id"] }}"
                 class="fa fa-toggle-off pointer"></i>
              {% wire id="toggle_device_enabled_"++device[1]["id"]
                      action={confirm text=_"Do you really want to disable this device"++"?"
                                      action={postback postback={enable_doc type doc_id field_name}
                                                       inject_args type="device"
                                                                   doc_id=device[1]["id"]
                                                                   field_name="enabled"
                                                       delegate="mod_kazoo"
                                             }
                             }
              %}
            {% endif %}
          </td>
          <td style="text-align: center;">
            {% if device[1]["device_type"]=="sip_device" %}
              <i class="{% if device[1]["enabled"] %}
                          {% if device_registered %}
                            registered
                          {% else %}
                            unregistered
                          {% endif %}
                        {% endif %}
                        icon-telicon-voip-phone icon-device"></i>
              {% elseif device[1]["device_type"]=="softphone" %}
                  <i class="{% if device[1]["enabled"] %}
                                {% if device_registered %}registered
                                    {% else %}unregistered
                                {% endif %}
                            {% endif %} 
                            icon-telicon-soft-phone icon-device"></i>
              {% elseif device[1]["device_type"]=="cellphone" %}
                  <i class="registered fa fa-mobile"></i>
                {% elseif device[1]["device_type"]=="sip_uri" %}
                  <i class="registered fa fa-mail-forward"></i>
                {% else %}
                  <i class="registered fa fa-phone"></i>
              {% endif %}
            </td>
            <td style="text-align: center;">{{ device[1]["name"]|truncate:13 }}</td>
            <td style="text-align: center;">
              {% if device[1]["owner_id"] %}
                {{ m.kazoo[{kz_user_doc_by_ownerid owner_id=device[1]["owner_id"]}][1]["username"]|truncate:13 }}
              {% else %}-{% endif %}
            </td>
            <td style="text-align: center;">
              {{ internal_cid }}
                {% if internal_cid and external_cid %} | {% endif %}
              {{ external_cid }}
            </td>
            <td style="text-align: center;">
              <i id="edit_{{ device[1]["id"] }}"
                 class="fa fa-edit pointer"
                 title="{_ Edit _}"></i>
            </td>
            {% wire id="edit_"++device[1]["id"]
                    action={dialog_open title=_"Edit device"++" "++device[1]["name"]
                                        template="_edit_device_lazy.tpl"
                                        device_id=device[1]["id"]
                                        width="auto"
                           }
            %}
            <td style="text-align: center;">
              {% if device_registered %}
                <i id="flush_{{ device[1]["id"] }}"
                   class="fa fa-eraser zprimary pointer"
                   title="{_ Flush registration _}"></i>
                {% wire id="flush_"++device[1]["id"]
                        action={confirm text=_"Do you really want to flush registration for device"
                                               ++ " "
                                               ++ device[1]["name"]|truncate:13
                                               ++ "?"
                                        action={postback postback={flush_registration_by_username
                                                                   sip_username=device_doc[1]["sip"][1]["username"]
                                                                  }
                                                         delegate="mod_kazoo"
                                               }
                               }
                %}
              {% else %}
                -
              {% endif %}
            </td>
            <td style="text-align: center;">
              {% if device_registered %}
                 <i id="info_{{ device[1]["id"] }}"
                    class="fa fa-info-circle zprimary pointer"
                    title="{_ Details _}"></i>
                 {% wire id="info_"++device[1]["id"]
                         action={dialog_open title=_"Registration details"
                                             template="_device_registration_details.tpl"
                                             device_id=device[1]["id"]
                                             width="auto"
                                }
                 %}
              {% else %}
                -
              {% endif %}
          </td>
        </tr>
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
    }
  });
{% endjavascript %}
{% endif %}
