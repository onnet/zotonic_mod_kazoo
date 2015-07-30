{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="incoming_faxes_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="incoming_faxes_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="incoming_faxes_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="incoming_faxes_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="incoming_faxes_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="incoming_faxes_widget_opened"}] %}display: none;{% endif %}">
<table id="user_portal_faxes_incoming_table" class="table display table-striped table-condensed">
   <thead>
        <tr>
            <th style="text-align: center;">{_ Date _}</th>
            <th style="text-align: center; white-space: nowrap;">{_ Fax number _}</th>
            <th style="text-align: center;">{_ Status _}</th>
            <th style="text-align: center;">{_ D/L _}</th>
            <th style="text-align: center;" class="visible-lg">{_ Details _}</th>
            <th style="text-align: center;">{_ Delete _}</th>
        </tr>
    </thead>
    <tbody>
        {% for attempt in m.kazoo.kz_list_incoming_faxes %}
          {% if attempt["timestamp"] %}
            <tr>
                <td style="text-align: center; white-space: nowrap;">{{ attempt["timestamp"]|inno_timestamp_to_date:[4] }}</td>
                <td style="text-align: center;">{{ attempt["from_number"]|pretty_phonenumber }}</td>
                <td style="text-align: center;">{% if attempt["rx_result"][1]["success"] %}{_ Success _}{% else %}{_ Failed _}{% endif %}</td>
                <td style="text-align: center;"><a href="/getinfaxdoc/id/{{ attempt["id"] }}"><i class="fa fa-download" title="{_ Download _}"></i></a></td>
                <td style="text-align: center;"><i id={{ attempt["id"] }} style="cursor: pointer;" class="fa fa-info-circle" title="{_ Details _}"></i></td>
                <td style="text-align: center;"><i id="fax_delete_{{ attempt["id"] }}" style="cursor: pointer;" class="fa fa-trash-o" title="{_ Delete _}"></i></td>
            </tr>
            {% wire id=attempt["id"] action={ dialog_open title=_"Fax details" template="_details.tpl" arg=attempt } %}
            {% wire id="fax_delete_"++attempt["id"]
                    action={confirm text=_"Do you really want to delete incoming fax from "++attempt["from_number"]|pretty_phonenumber++"?"
                                action={postback postback={delete_incoming_fax fax_id=attempt["id"] } delegate="mod_kazoo"}
                           }
            %}
          {% endif %}
    {% endfor %}
    </tbody>
</table>
</div>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#user_portal_faxes_incoming_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
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

});
{% endjavascript %}

{% endblock %}
