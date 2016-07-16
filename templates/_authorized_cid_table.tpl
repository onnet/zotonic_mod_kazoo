    <thead>
        <tr>
            <th style="text-align: center;">{_ Authorized CID _}</th>
            <th style="text-align: center;">{_ User _}</th>
            <th style="text-align: center;">{_ Retain CID _}</th>
            <th style="text-align: center;">{_ Delete _}</th>
        </tr>
    </thead>
    <tbody>
      {% for cred in m.kazoo.kz_cccp_creds_list %}
        {% if cred["cid"] %}
          <tr>
            <td style="text-align: center;">{{ cred["cid"] }}</td>
            <td style="text-align: center;">{{ m.kazoo[{kz_user_doc_by_ownerid owner_id=cred["user_id"] }][1]["username"] }}</td>
            <td style="text-align: center;">
              <span id="{{ cred["id"] }}_cccp_retain_cid">
                {% if cred["retain_cid"] %}
                  <i class="fa fa-check-circle" title="Enabled"></i>
                {% else %}
                  <i class="fa fa-ban" title="Disabled"></i>
                {% endif %}
                <i id="toggle_{{ cred["id"] }}_cccp_retain_cid" class="fa fa-refresh pointer" title="Change"></i>
                {% wire id="toggle_" ++ cred["id"] ++ "_cccp_retain_cid"
                        type="click"
                        action={ postback postback={toggle_cccp_retain_cid doc_id=cred["id"] signal_id="update_authorized_cid_table_tpl"}
                                          delegate="mod_kazoo"
                               }
                %}
              </span>
            </td>
            <td style="text-align: center;"><i id={{ cred["id"] }} style="cursor: pointer;" class="fa fa-trash-o" title="{_ Delete _}"></i></td>
          </tr>
          {% wire id=cred["id"] action={confirm text=_"Do you really want to delete this Authorized CID?"
                                                action={postback postback={del_cccp_doc doc_id=cred["id"]} delegate="mod_kazoo"}
                                       }
          %}
        {% endif %}
      {% endfor %}
    </tbody>
