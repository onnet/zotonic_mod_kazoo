{%  with m.lb[{rs_user_balance_notify uid=uid}] as notify %}
<table width="100%">
  <thead>
    <tr>
      <th>
        {% wire id="arrows_"++#topup type="click"
                action={toggle target="top_up_settings"}
                action={toggle target="arrow_right_"++#topup}
                action={toggle target="arrow_down_"++#topup}
        %}
        <span id="arrows_{{ #topup }}"
              style="cursor: pointer; padding-left: 0.7em;">
          <i id="arrow_right_{{ #topup }}"
             style="padding-right: 0.5em;"
             class="fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #topup }}"
             style="padding-right: 0.5em; display: none;"
             class="fa fa-arrow-circle-down"></i>
        </span>
        {_ Low balance notify level _}
        {% if notify %}
          <span class="pull-right" style="padding-right: 1em;">
            {{ notify }} {_ rub _}.
          </span>
        {% else %}
          {% wire id="topup_toggle_off" type="click"
                  action={toggle target="top_up_settings"}
                  action={toggle target="arrow_right_"++#topup}
                  action={toggle target="arrow_down_"++#topup}
          %}
          <span id="topup_toggle_off"
                class="pull-right"
                style="padding-right: 2em; cursor: pointer;">
            <i class="fa fa-toggle-off"></i>
          </span>
        {% endif %}
      </th>
    </tr>
  </thead>    
  <tbody id="top_up_settings" style="display: none;">
    <tr>
      <td>
        {_ Notify when balance falls below _}
        <input class="input input-xsmall-onnet"
               type="text"
               id="balance"
               name="balance"
               maxlength="5"
               size="5"
               value="{{ notify }}" />
        {_ rub _}.
        {% button id="notify_disable_btn"
                  class="btn btn-xs btn-onnet pull-right"
                  text=_"disable alert"
                  action={postback postback={rs_notify_disable_btn uid=uid}
                                   delegate="mod_lb"
                         }
        %}
        {% button id="notify_submit_btn"
                  class="btn btn-xs btn-onnet pull-right"
                  text=_"save"
                  action={postback postback={rs_notify_submit_btn uid=uid}
                                   delegate="mod_lb"
                                   qarg="balance"
                         }
        %}
      </td>
    </tr>
  </tbody>
</table>
{% endwith %}
