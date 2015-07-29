{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="calls_list_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="calls_list_widget_opened" } delegate="inno" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.inno[{ui_element_opened element="calls_list_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.inno[{ui_element_opened element="calls_list_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="calls_list_widget_opened" style="{% if not m.inno[{ui_element_opened element="calls_list_widget_opened"}] %}display: none;{% endif %}">
<table id="user_portal_call_history_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th style="text-align: center;">{_ Date _}</th>
            <th style="text-align: center;">{_ From _}</th>
            <th style="text-align: center;">{_ To _}</th>
            <th style="text-align: center;">{_ Duration _}</th>
            <th style="text-align: center;">{_ play _}</th>
        </tr>
    </thead>
    <tbody>
        {% for call in m.inno.kz_list_user_cdr %}
            {% include "user_cdr_table_line.tpl" %}
        {% endfor %}
    </tbody>
</table>
</div>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#user_portal_call_history_table').dataTable({
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

{# print m.inno.kz_list_user_cdr #}

{% endblock %}
