<tr>
    <td style="text-align: center;">{{ call["filtered_call_date"] }} </td>
    <td style="text-align: center;">{{ call["calling_from"] }}</td>
    <td style="text-align: center;">{{ call["dialed_number"] }}</td>
    <td style="text-align: center;">
      {{ call["duration_seconds"] }}/{{ call["billing_seconds"] }}
    </td>
    <td style="text-align: center;">
      {% include "_cdr_audio_controls.tpl" call=call %}
    </td>
</tr>
