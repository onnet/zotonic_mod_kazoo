<tbody>
 {% with m.notifier.first[{account_balance numbers=m.kazoo[{get_acc_numbers account_id=account_id}] }] as account_data %}
   {% if account_data[2] and not account_doc[1]["is_reseller"] %}
     <tr style="height: 10px; color: white!important; background-color: white!important;">
       <td colspan="2"></td>
     </tr>
     <tr>
       <td colspan=2>
         <span id="rs_set_lb_notify_level_tpl">
           {% include "rs_set_lb_notify_level.tpl" uid=account_data[2] %}
         </span>
       </td>
     </tr>
   {% endif %}
 {% endwith %}
</tbody>
