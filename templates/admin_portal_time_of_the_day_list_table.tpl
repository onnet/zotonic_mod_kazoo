{% if m.kazoo[{ui_element_opened element="ap_time_of_the_day_widget_opened"}] %}
<table id="admin_portal_time_of_the_day_widget_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center1;">{_ Group Name _}</th>
      <th style="text-align: center;">{_ Enabled _}</th>
      <th style="text-align: center;">{_ Type _}</th>
      <th style="text-align: center;">{_ Time _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for rule_summary in m.kazoo.kz_list_account_temporal_rules %}
      {% with m.kazoo[{kz_get_temporal_rule rule_id=rule_summary[1]["id"]}] as rule %}
      <tr>
        <td style="text-align: center;">{{ rule_summary[1]["name"] }}</td>
        <td style="text-align: center;">
          {% if rule[1]["enabled"] == undefined %}{_ Based on time _}{% endif %} 
          {% if rule[1]["enabled"] == "true" %}{_ Forced On _}{% endif %}
          {% if rule[1]["enabled"] == "false" %}{_ Forced Off _}{% endif %}
        </td>
        <td style="text-align: center;">
          {% if rule[1]["cycle"] == "weekly" %}
            {_ Weekly _}
          {% elseif rule[1]["cycle"] == "monthly" %}
            {_ Monthly _}
          {% else %}
            {_ Yearly _}
          {% endif %}
        </td>
        <td style="text-align: center;">
          {{ rule[1]["time_window_start"]|inno_seconds_to_time }}
            -
          {{ rule[1]["time_window_stop"]|inno_seconds_to_time }}
        </td>
        <td style="text-align: center;">
          <i id="edit_{{ rule_summary[1]["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i>
        </td>
        {% wire id="edit_"++rule_summary[1]["id"]
                action={dialog_open title=_"Edit rule"++" "++rule_summary[1]["name"]
                                    template="_edit_time_of_the_day_lazy.tpl"
                                    rule_id=rule_summary[1]["id"]
                                    width="auto"
                       }
        %}
        <td style="text-align: center;">
          <i id="delete_{{ rule_summary[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++rule_summary[1]["id"]
                action={confirm text=_"Do you really want to delete rule "++rule_summary[1]["name"]++"?"
                                action={postback postback={delete_time_of_the_day_rule rule_id=rule_summary[1]["id"]}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
      </tr>
      {% endwith %}
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_time_of_the_day_widget_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "{_ All _}"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},
"columnDefs": [
],

});
{% endjavascript %}
{% endif %}
