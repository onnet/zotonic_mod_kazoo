{% with m.kazoo[{kz_conference_participant participant_id=participant_id conference_id=conference_id}] as participant %}
  <tr id="participants_table_line_id_{{ participant_id }}">
      <td style="text-align: center;">
        {{ participant[1]["join_time"]|inno_timestamp_to_date }}
      </td>
      <td style="text-align: center;">
        {{ participant[1]["caller_id_number"] }}
        {{ participant[1]["caller_id_name"] }}
      </td>
      <td style="text-align: center;">
        {% if participant[1]["conference_channel_vars"][1]["talking"] %}
          <i id="talking_{{ participant_id }}" class="fa fa-volume-control-phone zalarm" title="Speaking now"></i>
        {% else %}
          <i id="talking_{{ participant_id }}"  class="fa fa-phone zprimary" title="Keeps silence"></i>
        {% endif %}
      </td>
      <td style="text-align: center;">
        {% if participant[1]["conference_channel_vars"][1]["speak"] %}
          <i id="mic_{{ participant_id }}" class="fa fa-microphone zprimary pointer" title="Enabled"></i>
         {% wire id="mic_"++participant_id
                 action={confirm text="Do you really want to switch microphone off?"
                                 action={postback postback={do_conference_participant_action
                                                            action="mute"
                                                            participant_id=participant_id
                                                            conference_id=conference_id 
                                                           }
                                                  delegate="mod_kazoo"
                                        }
                        }
         %} 
        {% else %}
          <i id="mic_{{ participant_id }}"  class="fa fa-microphone-slash zalarm pointer" title="Disabled"></i>
         {% wire id="mic_"++participant_id
                 action={confirm text="Do you really want to switch microphone on?"
                                 action={postback postback={do_conference_participant_action 
                                                            action="unmute"
                                                            participant_id=participant_id
                                                            conference_id=conference_id 
                                                           }
                                                  delegate="mod_kazoo"
                                        }
                        }
         %} 
        {% endif %}
      </td>
      <td style="text-align: center;">
        {% if participant[1]["conference_channel_vars"][1]["hear"] %}
          <i id="speaker_{{ participant_id }}" class="fa fa-volume-up zprimary pointer" title="Enabled"></i>
         {% wire id="speaker_"++participant_id
                 action={confirm text="Do you really want to switch speaker off?"
                                 action={postback postback={do_conference_participant_action
                                                            action="deaf"
                                                            participant_id=participant_id
                                                            conference_id=conference_id 
                                                           }
                                                  delegate="mod_kazoo"
                                        }
                        }
         %} 
        {% else %}
          <i id="speaker_{{ participant_id }}"  class="fa fa-volume-off zalarm pointer" title="Disabled"></i>
         {% wire id="speaker_"++participant_id
                 action={confirm text="Do you really want to switch speaker on?"
                                 action={postback postback={do_conference_participant_action 
                                                            action="undeaf"
                                                            participant_id=participant_id
                                                            conference_id=conference_id 
                                                           }
                                                  delegate="mod_kazoo"
                                        }
                        }
         %} 
        {% endif %}
      </td>
      <td style="text-align: center;">
        <i id="kick_{{ participant_id}}" style="cursor: pointer;" class="fa fa-trash-o" title="Delete"></i>
      </td>
      {% wire id="kick_"++participant_id
              action={confirm text="Do you really want to kick this participant off?"
                              action={postback postback={do_conference_participant_action
                                                         action="kick"
                                                         participant_id=participant_id
                                                         conference_id=conference_id 
                                                        }
                                               delegate="mod_kazoo"
                                     }
                     }
      %} 
      <td style="text-align: center;">
        <i id="pinfo_{{ participant_id }}" class="fa fa-info-circle zprimary pointer" title="{_ Participant information _}" style="margin-right:0.23em;"></i>
      </td>
      {% wire id="pinfo_"++participant_id
              action={ dialog_open title=participant[1]["Custom-Channel-Vars"][1]["Presence-ID"]|split:"@"|first
                                   template="_details_conference_participant.tpl"
                                   conference_id=conference_id
                                   participant_id=participant_id
                                   width="auto"
                     }
      %}
  </tr>
{% endwith %}
