    <thead>
        <tr>
            <th style="text-align: center;">{_ Active _}</th>
            <th style="text-align: center;">{_ Authorized PIN _}</th>
            <th style="text-align: center;">{_ User _}</th>
            <th style="text-align: center;">{_ Retain CID _}</th>
            <th style="text-align: center;">{_ Delete _}</th>
        </tr>
    </thead>
    <tbody>
      {% for cred in m.kazoo.kz_cccp_creds_list %}
        {% if cred["pin"] %}
          <tr>
            <td style="text-align: center;">
              <i id="{{ cred["id"] }}_cccp_active_state_toggler"
                 class="fa fa-toggle-{% if cred["active"] %}on{% else %}off{% endif %} pointer pull-right"
                 style="margin: 0.1em 1em 0 0"></i>
              {% wire id=cred["id"] ++ "_cccp_active_state_toggler"
                      type="click"
                      action={ postback postback={cccp_field_toggler doc_id=cred["id"] field_name="active" signal_id="update_authorized_pin_table_tpl"}
                                        delegate="mod_kazoo"
                             }
              %}
            </td>
            <td style="text-align: center;">{{ cred["pin"] }}</td>
            <td style="text-align: center;">{{ m.kazoo[{kz_user_doc_by_ownerid owner_id=cred["user_id"] }][1]["username"] }}</td>
            <td style="text-align: center;">
              <i id="{{ cred["id"] }}_cccp_retain_cid_toggler"
                 class="fa fa-toggle-{% if cred["retain_cid"] %}on{% else %}off{% endif %} pointer"></i>
              {% wire id=cred["id"] ++ "_cccp_retain_cid_toggler"
                      type="click"
                      action={ postback postback={cccp_field_toggler doc_id=cred["id"] field_name="retain_cid" signal_id="update_authorized_pin_table_tpl"}
                                        delegate="mod_kazoo"
                             }
              %}
            </td>
            <td style="text-align: center;"><i id={{ cred["id"] }} style="cursor: pointer;" class="fa fa-trash-o" title="{_ Delete _}"></i></td>
          </tr>
          {% wire id=cred["id"] action={confirm text=_"Do you really want to delete this Pin?" action={postback postback={del_cccp_doc doc_id=cred["id"]} delegate="mod_kazoo"}} %}
        {% endif %}
      {% endfor %}
    </tbody>

