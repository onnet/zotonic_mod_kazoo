<div id="TableSpinner" class="text-center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>

<table id="free_numbers_table" class="table display_none table-striped table-condensed">
  <thead>
    <tr>
      <th class="td-center" width="30%">{_ Type _}</th>
      <th class="td-center">{_ Number _}</th>
      <th class="td-center">{_ Activation charge _}</th>
      <th class="td-center">{_ Monthly fee _}</th>
      <th class="td-center" style="width: 0.3em;"></th>
    </tr>
  </thead>
  <tbody id="mytbodyid">
    {% for number in free_numbers %}
      <tr>
        <td class="td-center">{{ number[1]["friendly_name"] }}</td>
        <td class="td-center">{{ number[1]["number"] }}</td>
        <td class="td-center">{{ number[1]["activation_charge"]|currency_sign }}</td>
        <td class="td-center">{{ number[1]["rate"]|currency_sign }}</td>
        <td class="td-center">
          <i id="select_number_{{ number[1]["number"]|cleanout }}"
             class="fa fa-square-o pointer"></i>
          {% wire id="select_number_"++number[1]["number"]|cleanout
                  action={hide target="select_number_"++number[1]["number"]|cleanout }
                  action={show target="deselect_number_"++number[1]["number"]|cleanout }
                  action={show target="buy_selected_numbers_button" }
                  action={insert_bottom
                          target="selected_numbers_array"
                          text="<input id='selected_number_hidden_input_"
                                          ++number[1]["number"]|cleanout
                                          ++"' type='hidden' name='numbers_about_to_purchase' value='"
                                          ++number[1]["number"]
                                          ++"' >" }

          %}
          <i id="deselect_number_{{ number[1]["number"]|cleanout }}"
             class="fa fa-check-square-o pointer"
             style="display: none;"></i>
          {% wire id="deselect_number_"++number[1]["number"]|cleanout
                  action={hide target="deselect_number_"++number[1]["number"]|cleanout }
                  action={show target="select_number_"++number[1]["number"]|cleanout }
                  action={remove target="selected_number_hidden_input_"++number[1]["number"]|cleanout }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% wire id="numbers_to_purchase_array_form"
        type="submit"
        postback="selected_numbers_array_form"
        delegate="mod_kazoo"
%}
<form id="numbers_to_purchase_array_form" method="post" action="postback">
  <span id="selected_numbers_array"></span>
</form>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#free_numbers_table').dataTable({
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
});
$('#TableSpinner').hide();
$('#free_numbers_table').show();


{% endjavascript %}


