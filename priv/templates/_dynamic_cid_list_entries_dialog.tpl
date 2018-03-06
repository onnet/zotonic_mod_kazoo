{% with m.kazoo[{kz_list_account_list_entries list_id=list_id}] as entries %}
<ul "list_entries_ul" class="list-group">
  {% for entry in entries %}
    <li class="list-group-item text-center">
      <table style="width: 100%;">
        <tr>
          <td style="width: 10%; text-align: left;">
            {{ entry[1]["value"][1]["cid_key"] }}
          </td>
          <td style="width: 10%; text-align: left;">
            {{ entry[1]["value"][1]["cid_number"] }}
          </td>
          {% wire id="delete_"++entry[1]["id"]
                  action={postback
                          postback={delete_account_list_entry
                                    list_id=list_id
                                    entry_id=entry[1]["id"]
                                    template_name="_dynamic_cid_list_entries_dialog.tpl"
                                   }
                          delegate="mod_kazoo"
                         }
          %}
          <td>
            {{ entry[1]["value"][1]["cid_name"] }}
          </td>
          <td>
            <i id='delete_{{ entry[1]["id"] }}'
               class="fa fa-trash-o pointer"
               title="Delete"
               style="float: right;"></i>
          </td>
        </tr>
      </table>
    </li>
  {% endfor %}
</ul>
{% endwith %}
