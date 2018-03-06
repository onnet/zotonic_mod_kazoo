{% if m.kazoo[{ui_element_opened element="conference_participants_widget_opened"}] %}
<table id="conference_current_participants_table"
       class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center;">{_ Join time _}</th>
      <th style="text-align: center;">{_ Participant _}</th>
      <th style="text-align: center;">{_ Talking _}</th>
      <th style="text-align: center;">{_ Microphone _}</th>
      <th style="text-align: center;">{_ Speaker _}</th>
      <th style="text-align: center;">{_ Kick off _}</th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody id="conference_current_participants_table_tbody">
    {% for participant in m.kazoo[{kz_conference_participants conference_id=conference_id}] %}
      {% include "_conference_participants_table_line.tpl"
                 conference_id=conference_id
                 participant_id=participant[1]["participant_id"]
      %}
    {% endfor %}
  </tbody>
</table>
{% else %}
{% endif %}
