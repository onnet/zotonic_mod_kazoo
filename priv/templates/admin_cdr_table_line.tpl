<tr>
  <td style="text-align: center;">{{ call["timestamp"]|gregsec_to_date|date:"Y-m-d H:i T":timezone }}</td>
  <td style="text-align: center;">{{ call["calling_from"] }}</td>
  <td style="text-align: center;">{{ call["dialed_number"] }}</td>
  <td style="text-align: center;">{{ call["duration_seconds"] }}/{{ call["billing_seconds"] }}</td>
  <td style="text-align: center;">
    {% include "_cdr_audio_controls.tpl" call=call %}
  </td>
  <td style="text-align: center;">
  {% if not m.session.show_cdr_legs %}
  <i id="{{ #this_call_info }}" class="fa fa-object-ungroup zprimary pointer" title="{_ Details _}"></i>
  {% wire id=#this_call_info
          action={update target="admin_portal_call_details_tpl"
                         title=_"Call details"
                         template="admin_portal_call_details.tpl"
                         cdr_id=call["id"]
                         headline=_"Call details"
                 }
          action={script script="$('i.zalarm').addClass('zprimary'); $('i.zalarm').removeClass('zalarm');"}
          action={remove_class target=#this_call_info class="zprimary"}
          action={add_class target=#this_call_info class="zalarm"}
  %}
  {% else %}
  <i id="{{ #this_call_info2 }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>
  {% wire id=#this_call_info2
          action={dialog_open title=_"Call details"
                              template="_call_details.tpl"
                              cdr_id=call["id"]
                              width="auto"
                 }
  %}
  {% endif %}
  </td>
</tr>
