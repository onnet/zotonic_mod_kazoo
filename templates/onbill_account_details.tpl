{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% wire id="rs_account_details_info" 
            action={dialog_open title=_"Account details" 
                                template="_account_details.tpl" 
                                account_id=account_id 
                                class="iamclass" 
                                width="auto"
                   } 
    %}
    <i id="rs_account_details_info"
       class="fa fa-info-circle zprimary pointer"
       style="margin-left: 0.3em;"></i>
    {% button class="btn btn-xs btn-onnet pull-right"
              text=_"send message"
              action={dialog_open title=_"Send message to customer"
                                  template="rs_kz_customer_update.tpl"
                                  account_id=account_id
                     }
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
{% with m.kazoo[{kz_get_acc_doc_by_account_id account_id=account_id}] as account_doc %}
<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <th width="40%">{_ Account name _}</th>
      <th>
        <span id="name">
          {% include "_show_field.tpl" type="account"
                                       doc_id="_no_need_"
                                       field_name=["name"] 
                                       account_id=account_id
          %}
        </span>

         <span id="general_timezone" class="pull-right" style="padding-right: 1em;">
            {% include "_show_field_select.tpl" type="account"
                                                doc_id="_no_need_"
                                                field_name="timezone"
                                                account_id=account_id
                                                options=m.kazoo.tz_list
                                                prefix="general_"
                                                postfix="_bootsearch"
            %}
         </span>



      </th>
    </tr>
    <tr>
      <th>{_ Account status _}</th>
      <th>
        {% if account_doc[1]["enabled"] %}
          <span class="zprimary">{_ Active _}</span>
        {% else %}
          <span class="zalarm">{_ Blocked _}</span>
        {% endif %}
        <span class="pull-right" style="padding-right: 1em;">
          {% include "_current_child_account_credit.tpl" %}
        </span>
      </th>
    </tr>
    {% if account_doc[1]["trial_time_left"] %}
      <tr>
        <th>
          {_ Trial status _}
        </th>
        <th>
          {% if account_doc[1]["trial_time_left"] > 0 %}
            <span class="zprimary">
              {_ In Progress _}.
              {{ (account_doc[1]["trial_time_left"]/60/60/24)|to_integer }}
              {_ days left _}
            </span>
          {% else %}
            <span class="zalarm">
              {_ Expired _}
              {{ (account_doc[1]["trial_time_left"]/60/60/24 * (-1))|to_integer }}
              {_ days ago _}
            </span>
          {% endif %}
          <span class="pull-right" style="padding-right: 1em;">
            <i id="{{ #edit_account_trial_state }}"
                style="cursor: pointer;"
                class="fa fa-edit pointer"
                title="{_ Edit _}"></i>
          </span>
          {% wire id=#edit_account_trial_state
                  action={dialog_open title=_"Trial status manager"
                                      template="_rs_trial_status_manager.tpl"
                                      account_id=account_id
                                      trial_time_left=account_doc[1]["trial_time_left"]
                         }
          %}
        </th>
      </tr>
    {% else %}
      {% with m.onbill[{current_billing_period account_id=account_id}],
              m.onbill[{onbill_pvt_limits account_id=account_id}]
              as
              current_billing_period,
              onbill_pvt_limits
      %}
      <tr>
        <th>{_ Account type _}</th>
        <th>
          {% if onbill_pvt_limits[1]["allow_postpay"] %}
            <span class="zprimary">
              {_ Postpaid _}
            </span>
            <span id="pvt_limits_max_postpay_amount" class="pull-right" style="padding-right: 1em;">
              {{ onbill_pvt_limits[1]["max_postpay_amount"]|currency_sign }}
              <i id="edit_pvt_limits_max_postpay_amount"
                 style="cursor: pointer;"
                 class="fa fa-edit pointer"
                 title="{_ Edit _}"></i>
              {% wire id="edit_pvt_limits_max_postpay_amount"
                      type="click"
                      action={update target="pvt_limits_max_postpay_amount"
                                     template="_edit_pvt_limits_field.tpl"
                                     account_id=account_id
                                     field_name="max_postpay_amount"
                             }
              %}
            </span>
          {% else %}
            <span class="zprimary">
            {_ Prepaid _}
            </span>
            <span class="pull-right" style="padding-right: 1em;">
            {{ current_billing_period[1]["period_start"][1]["day"] }}
            {{ current_billing_period[1]["period_start"][1]["month_short"] }}
            {{ current_billing_period[1]["period_start"][1]["year"] }}
            -
            {{ current_billing_period[1]["period_end"][1]["day"] }}
            {{ current_billing_period[1]["period_end"][1]["month_short"] }}
            {{ current_billing_period[1]["period_end"][1]["year"] }}
            </span>
          {% endif %}
        </th>
      </tr>
      {% endwith %}
    {% endif %}
    <tr>
      <th>
        {_ Billing status _}
        {% if m.kazoo[{kz_current_service_plans account_id=account_id}][1]["billing_id"] != account_id %}
          <small class="zalarm">
            ({_ billing_id mismatch _})
          </small>
        {% endif %}
      </th>
      <th>
        {% if m.kazoo[{services_status account_id=account_id}][1]["in_good_standing"] %}
          <span class="zprimary">{_ Good standing _}</span>
          {% if m.kazoo.kz_current_context_superadmin %}
            <i id="services_status_toggler"
               class="fa fa-toggle-on pointer pr-1"
               style="float: right;"
               title="{_ Click to toggle _}"></i>
          {% endif %}
        {% else %}
          <span class="zalarm">{_ Delinquent _}</span>
          {% if m.kazoo.kz_current_context_superadmin %}
            <i id="services_status_toggler"
               class="fa fa-toggle-off pointer pr-1"
               style="float: right;"
               title="{_ Click to toggle _}"></i>
          {% endif %}
        {% endif %}
      </th>
      {% if m.kazoo.kz_current_context_superadmin %}
        {% wire id="services_status_toggler"
                type="click"
                action={confirm text=_"Do you really want to toggle billing status?"
                                action={postback postback={toggle_services_status account_id=account_id}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
      {% endif %}
    </tr>
    <tr>
      <th>{_ Reseller status _}</th>
      <th>
        {% if account_doc[1]["is_reseller"] %}
          <span class="zprimary">{_ Activated _}</span>
          {% if m.kazoo.kz_current_context_superadmin %}
            <i id="reseller_status_toggler"
               class="fa fa-toggle-on pointer pr-1"
               style="float: right;"
               title="{_ Click to demote _}"></i>
          {% endif %}
        {% else %}
          <span class="zalarm">{_ Not provided _}</span>
          {% if m.kazoo.kz_current_context_superadmin %}
            <i id="reseller_status_toggler"
               class="fa fa-toggle-off pointer pr-1"
               style="float: right;"
               title="{_ Click to promote _}"></i>
          {% endif %}
        {% endif %}
      </th>
      {% if m.kazoo.kz_current_context_superadmin %}
        {% wire id="reseller_status_toggler"
                type="click"
                action={confirm text=_"Do you really want to toggle reseller status?"
                                action={postback postback={toggle_reseller_status account_id=account_id}
                                                 delegate="mod_kazoo"
                                       }
                       }
        %}
      {% endif %}
    </tr>
    <tr>
      <th>{_ Numbers management _}</th>
      <th>
        {% if account_doc[1]["wnm_allow_additions"] %}
          <span class="zprimary">{_ Activated _}</span>
        {% else %}
          <span class="zalarm">{_ Not activated _}</span>
        {% endif %}
      </th>
    </tr>

  </thead>
</table>
{% rs_service_plans_manager %}
<span id="set_notify_level_tpl">
  {% set_balance_level_notify %}
</span>
{% include "rs_account_details_subwidget.tpl" %}
{% endwith %}
{% endblock %}
