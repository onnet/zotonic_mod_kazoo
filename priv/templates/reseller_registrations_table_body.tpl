<table id="reseller_registrations_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="text-center">{_ User _}</th>
      <th class="text-center">{_ User agent _}</th>
      <th class="text-center">{_ Contact IP _}</th>
      <th class="text-center">{_ Details _}</th>
    </tr>
  </thead>
  <tbody>
    {% for device in m.kazoo.get_reseller_registrations %}
      <tr>
       <td class="text-center1">
         <a id="realm_{{ device[1]["call_id"]|cleanout }}" href="#">{{ device[1]["username"] }}@{{ device[1]["realm"] }}</a>
         {% wire id="realm_"++device[1]["call_id"]|cleanout
                 action={postback postback={redirect_to_reseller_portal realm=device[1]["realm"]}
                                   delegate="mod_kazoo"}
         %}
       </td>
       <td class="text-center1">{{ device[1]["user_agent"]|truncate:19 }}</td>
       <td class="text-center"><a target="_blank" href='https://{{ device[1]["contact_ip"] }}'>{{ device[1]["contact_ip"] }}</a></td>
       <td style="text-align: center;">
              <i id="info_{{ device[1]["username"] }}" class="fa fa-info-circle zprimary pointer" title="{_ Details _}"></i>
              {% wire id="info_"++device[1]["username"]
                      action={dialog_open title=_"Registration details" template="_details.tpl" arg=device width="auto"}
              %}
       </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#reseller_registrations_table').dataTable({
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

