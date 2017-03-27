<thead>
  <tr style="height: 2.2em;">
    {% with m.kazoo.limits as limits %}
      <th class="text-center" width="34%">
        {_ Two way _}: 
        <span id="span_id_twoway_trunks">
          {% include "_show_trunks_manager_field.tpl" limits=limits trunks_type="twoway_trunks" %}
        </span>
      </th>
      <th class="text-center" width="33%">
        {_ Outbound _}:
        <span id="span_id_outbound_trunks">
          {% include "_show_trunks_manager_field.tpl" limits=limits trunks_type="outbound_trunks" %}
        </span>
      </th>
      <th class="text-center">
        {_ Inbound _}:
        <span id="span_id_inbound_trunks">
          {% include "_show_trunks_manager_field.tpl" limits=limits trunks_type="inbound_trunks" %}
        </span>
      </th>
    {% endwith %}
  </tr>
</thead>
