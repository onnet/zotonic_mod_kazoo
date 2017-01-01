{% with m.session.rs_selected_account_id as account_id %}
{%  with m.kazoo[{kz_doc_field type="account" doc_id=" " field=["notifications", "low_balance", "threshold"] account_id=account_id}]
        ,m.kazoo[{kz_doc_field type="account" doc_id=" " field=["notifications", "low_balance", "enabled"] account_id=account_id}]
    as notify, notify_enabled
%}
<table class="table table-hover table-centered table-condensed">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="5"></td></tr>
    <tr>
      <th>
        <span id="arrows_{{ #topup }}" style="cursor: pointer; {% if account_id %}padding-left: 0.7em;{% endif %}">
          {% wire id="arrows_"++#topup type="click"
                  action={ toggle target="top_up_settings" }
                  action={ toggle target="arrow_right_"++#topup }
                  action={ toggle target="arrow_down_"++#topup }
          %}
          <i id="arrow_right_{{ #topup }}" style="padding-right: 0.5em;" class="fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #topup }}" style="padding-right: 0.5em; display: none;" class="fa fa-arrow-circle-down"></i>
        </span>
        <span style="color: FF9002;">
          {_ Low balance notify level _}
        </span>
      </th>
      {% if notify_enabled %}
      <th>
        <span class="pull-right" style="padding-right: 1em;">
          {{ notify|currency_sign }}
        </span>
      </th>
      {% else %}
      <th>
        {% wire id="topup_toggle_off" type="click"
                action={ toggle target="top_up_settings" }
                action={ toggle target="arrow_right_"++#topup }
                action={ toggle target="arrow_down_"++#topup }
        %}
        <span id="topup_toggle_off" class="pull-right" style="padding-right: 2em; cursor: pointer;"><i class="fa fa-toggle-off"></i></span>
      </th>
      {% endif %}
    </tr>
  </thead>
  <tbody id="top_up_settings" style="display: none;">
    <tr>
      <td class="td-center" colspan="2">
         {_ Notify when balance falls below _}: 
         {{ m.session.currency_sign }}
         <input class="input input-xsmall-onnet"
                type="text"
                id="balance"
                name="balance"
                maxlength="5"
                size="5"
                style="text-align:center;"
                value="{{ notify }}" />
         {% if notify_enabled %}
           {% button id="notify_disable_btn" class="btn btn-xs btn-onnet pull-right" text=_"disable alert"
               action={postback postback=[{notify_disable_btn account_id=account_id}] delegate="mod_kazoo"}
           %}
         {% endif %}
         {% button id="notify_submit_btn" class="btn btn-xs btn-onnet pull-right" text=_"save"
             action={postback postback=[{notify_submit_btn account_id=account_id}] delegate="mod_kazoo" qarg="balance" }
         %}
      </td>
    </tr>
  </tbody>
</table>
{% endwith %}
{% endwith %}
