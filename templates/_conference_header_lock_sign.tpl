{% with m.kazoo[{kz_get_account_conference conference_id=conference_id}] as conference_details %}
<span id="conference_header_lock_sign_id">
    {% if conference_details[1]["_read_only"][1]["is_locked"] %}
      <i id="locked_conference_icon" class="fa fa-lock zalarm" style="margin: 0.1em 0 0 8em" title="Locked"></i>
      <i id="unlock_conference_icon" class="fa fa-toggle-on zalarm pointer" style="margin: 0.1em 0 0 0" title="Unlock"></i>
      {% wire id="unlock_conference_icon"
              action={confirm text=_"Do you really want to unlock conference?"
                              action={postback postback={do_conference_action action="unlock" conference_id=conference_id} delegate="mod_kazoo"}
                              action={replace target="conference_header_lock_sign_id"
                                              template="_conference_header_lock_sign.tpl"
                                              conference_id=conference_id
                                     }
                     }
       %}
    {% else %}
      <i id="unlocked_conference_icon" class="fa fa-unlock zprimary" style="margin: 0.1em 0 0 8em" title="Unlocked"></i>
      <i id="lock_conference_icon" class="fa fa-toggle-off zprimary pointer" style="margin: 0.1em 0 0 0" title="Lock"></i>
      {% wire id="lock_conference_icon"
              action={confirm text=_"Do you really want to lock conference?"
                              action={postback postback={do_conference_action action="lock" conference_id=conference_id} delegate="mod_kazoo"}
                              action={replace target="conference_header_lock_sign_id"
                                              template="_conference_header_lock_sign.tpl"
                                              conference_id=conference_id
                                     }
                     }
       %}
    {% endif %}
</span>
{% endwith %}
