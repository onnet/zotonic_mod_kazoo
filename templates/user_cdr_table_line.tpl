<tr>
  <td style="text-align: center;">
    {{ call["timestamp"]|gregsec_to_date|date:"Y-m-d H:i T":timezone }}
  </td>
  <td style="text-align: center;">{{ call["calling_from"] }}</td>
  <td style="text-align: center;">{{ call["dialed_number"] }}</td>
  <td style="text-align: center;">
    {{ call["duration_seconds"] }}/{{ call["billing_seconds"] }}
  </td>
  <td style="text-align: center;">
    {% include "_cdr_audio_controls.tpl" call=call %}
  </td>
</tr>
