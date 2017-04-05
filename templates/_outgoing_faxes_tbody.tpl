<table class="table table-condensed table-hover table-centered" style="table-layout: fixed;">
  <tbody id="send-fax-tbody">
    {% for attempt in m.kazoo.kz_list_outgoing_faxes|sort:'desc'|slice:[5] %}
      <tr>
        <td style="text-align: center;">
          {{ attempt["a"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}
        </td>
        <td style="text-align: center;">{{ attempt["from"] }}</td>
        <td style="text-align: center;">{{ attempt["to"] }}</td>
        <td style="text-align: center;">{{ attempt["status"] }}</td>
      </tr>
    {% endfor %}
  </tbody>
</table>
