<table id="rs_tasks_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th class="text-center">{_ Date _}</th>
      <th class="text-center">{_ Category _}</th>
      <th class="text-center">{_ Action _}</th>
      <th class="text-center">{_ Status _}</th>
      <th class="text-center">{_ Details _}</th>
    </tr>
  </thead>
  <tbody>
    {% for task in m.kazoo.account_tasks %}
      <tr>
        <td class="text-center">
          {{ task[1]["created"]|gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}
        </td>
        <td class="text-center">{{ task[1]["category"]|truncate:13 }}</td>
        <td class="text-center">{{ task[1]["action"]|truncate:13 }}</td>
        <td class="text-center">{{ task[1]["status"] }}</td>
        <td style="text-align: center;">
          {% if task[1]["status"] == "pending" %}
            <i id="process_task_{{ task[1]["id"]|cleanout }}"
               class="fa fa-play zprimary pointer"
               title="{_ Play _}"></i>
            {% wire id="process_task_"++task[1]["id"]|cleanout
                    action={confirm text=_"Do you really want to start this job?"
                                     action={postback postback={start_task_processing account_id=account_id
                                                                                      task_id=task[1]["id"]
                                                               }
                                                      delegate="mod_kazoo"
                                            } 
                            } 
            %}
          {% endif %}
          {% if task[1]["csvs"] %}
            {% for task_filename in task[1]["csvs"] %}
            <a href="{{ m.onbill[{attachment_download_link account_id=account_id
                                                           doc_id=task[1]["id"]
                                                           attachment_name=task_filename
                                                           doc_type="tasks_csv"}] }}">
              <i id="download_uploaded_doc_{{ task[1]["id"]|cleanout }}_{{ task_filename|cleanout }}"
                 class="fa fa-download"
                 title="{{ task_filename }}"></i>
            </a>
            {% endfor %}
          {% else %}
          {% endif %}
          <i id="info_{{ task[1]["id"]|cleanout }}"
             class="fa fa-info-circle zprimary pointer"
             title="{_ Details _}"></i>
          {% wire id="info_"++task[1]["id"]|cleanout
                  action={dialog_open title=_"Task details"
                                      template="_details.tpl"
                                      arg=task
                         }
          %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#rs_tasks_table').dataTable({
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
