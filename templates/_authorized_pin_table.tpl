<thead>
  <tr>
    <th style="text-align: center;">{_ Active _}</th>
    <th style="text-align: center;">{_ Authorized PIN _}</th>
    <th style="text-align: center;">{_ User _}</th>
    <th style="text-align: center;">{_ Comment _}</th>
    <th style="text-align: center;">{_ Retain CID _}</th>
    <th style="text-align: center;">{_ Delete _}</th>
  </tr>
</thead>
<tbody>
  {% for cred in m.kazoo.kz_cccp_creds_list %}
    {% if cred[1]["pin"] %}
      <tr>
        <td style="text-align: center;">
          <i id="{{ cred[1]["id"] }}_cccp_active_state_toggler"
             class="fa
                    fa-toggle-{% if cred[1]["active"] %}on{% else %}off{% endif %}
                    pointer
                    pull-right"
             style="margin: 0.1em 1em 0 0"></i>
          {% wire id=cred[1]["id"] ++ "_cccp_active_state_toggler"
                  type="click"
                  action={postback postback={cccp_field_toggler
                                             doc_id=cred[1]["id"]
                                             field_name="active"
                                             signal_id="update_authorized_pin_table_tpl"
                                            }
                                   delegate="mod_kazoo"
                         }
          %}
        </td>
        <td style="text-align: center;">{{ cred[1]["pin"] }}</td>
        <td style="text-align: center;">
          {{ m.kazoo[{kz_user_doc_by_ownerid owner_id=cred[1]["user_id"] }][1]["username"] }}
        </td>
        <td id="{{ cred[1]["id"] }}comment" style="text-align: center;">
          {% wire id="edit_"++cred[1]["id"]++"comment"
                  type="click"
                  action={update target=cred[1]["id"]++"comment"
                                 template="_edit_field.tpl"
                                 type="cccp_creds"
                                 doc_id=cred[1]["id"]
                                 prefix=cred[1]["id"]
                                 field_name="comment"
                         }
          %}
          {{ cred[1]["comment"] }}
          <i id="edit_{{ cred[1]["id"] }}comment" class="fa fa-edit pointer" title="Edit field"></i>
        </td>
        <td style="text-align: center;">
          <i id="{{ cred[1]["id"] }}_cccp_retain_cid_toggler"
             class="fa
                    fa-toggle-{% if cred[1]["retain_cid"] %}on{% else %}off{% endif %}
                    pointer"></i>
          {% wire id=cred[1]["id"] ++ "_cccp_retain_cid_toggler"
                  type="click"
                  action={postback postback={cccp_field_toggler
                                             doc_id=cred[1]["id"]
                                             field_name="retain_cid"
                                             signal_id="update_authorized_pin_table_tpl"
                                            }
                                   delegate="mod_kazoo"
                         }
          %}
        </td>
        <td style="text-align: center;">
          <i id={{ cred[1]["id"] }}
             style="cursor: pointer;"
             class="fa fa-trash-o"
             title="{_ Delete _}"></i>
        </td>
      </tr>
      {% wire id=cred[1]["id"]
              action={confirm text=_"Do you really want to delete this Pin?"
                              action={postback postback={del_cccp_doc doc_id=cred[1]["id"]}
                                               delegate="mod_kazoo"
                                     }
                     }
      %}
    {% endif %}
  {% endfor %}
</tbody>
