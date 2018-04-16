<tr>
  <td style="text-align: center;">{{ recording["start"]|gregsec_to_date|date:"Y-m-d H:i T":timezone }}</td>
  <td style="text-align: center;">{{ recording["caller_id_number"] }}</td>
  <td style="text-align: center;">{{ recording["callee_id_number"] }}</td>
  <td style="text-align: center;">{{ recording["duration"] }}</td>
  <td style="text-align: center;">
    {# print recording #}
    {% include "_recording_audio_controls.tpl" call=recording %}
  </td>
</tr>
