      <tr id="{{ running_call[1]["uuid"]|cleanout }}">
        <td style="display: none;">
          {{ running_call[1]["uuid"]|cleanout }}
        </td>
        <td style="text-align: center;">
          {{ running_call[1]["timestamp"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}
        </td>
        <td style="text-align: center;">
          {{ running_call[1]["account_name"] }}
        </td>
        <td style="text-align: center;">
          {% if running_call[1]["caller_id_number"] %}
            {{ running_call[1]["caller_id_number"] }}
          {% elif running_call[1]["from"] %}
            {{ running_call[1]["from"]|split:"@"|first }}
          {% else %}
            {{ running_call[1]["presence_id"]|split:"@"|first }}
          {% endif %}
        </td>
        <td style="text-align: center;">
          {% if running_call[1]["callee_id_number"] %}
            {{ running_call[1]["callee_id_number"] }}
          {% else %}
            {{ running_call[1]["destination"] }}
          {% endif %}
        </td>
        <td style="text-align: center;">
          <a id="realm_{{ running_call[1]["uuid"]|cleanout }}"
             href="#">{{ running_call[1]["presence_id"]|split:"@"|last }}</a>
          {% wire id="realm_"++running_call[1]["uuid"]|cleanout
                  action={postback postback={redirect_to_reseller_portal
                                             realm=running_call[1]["presence_id"]|split:"@"|last
                                            }
                                   delegate="mod_kazoo"}
          %}
        </td>
        <td style="text-align: center;">
          {% if running_call[1]["answered"] %}
            {_ answered _}
          {% elif running_call[1]["event_name"] == "CHANNEL_ANSWER" %}
            {_ answered _}
          {% elif running_call[1]["event_name"] == "CHANNEL_CREATE" %}
            {_ connecting _}
          {% elif running_call[1]["event_name"] %}
            {{ running_call[1]["event_name"] }}
          {% else %}
            {_ connecting _}
          {% endif %}
        </td>
        <td style="text-align: center;">
          <i id="hangup_{{ running_call[1]["uuid"]|cleanout }}"
             class="dark-1 icon-telicon-hangup pointer"></i>
          {% wire id="hangup_"++running_call[1]["uuid"]|cleanout
                  action={postback postback={channel_hangup_confirm channel_id=running_call[1]["uuid"]}
                                   delegate="mod_kazoo"
                         }
          %}
        </td>
        <td style="text-align: center;">
          <i id="info_{{ running_call[1]["uuid"]|cleanout }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++running_call[1]["uuid"]|cleanout
                  action={dialog_open title=_"Call details"
                                      template="reseller_current_call_info_lazy.tpl"
                                      uuid=running_call[1]["uuid"]
                                      account_id=account_id
                                      running_call=running_call
                         }
          %}
        </td>
      </tr>
