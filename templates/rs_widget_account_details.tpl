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
              text=_"refresh"
              action={update target="reseller_children_area"
                             template="reseller_children.tpl"
                             headline=_"Account details"}
    %}
    {% button class="btn btn-xs btn-onnet pull-right"
              text=_"send message"
              action={dialog_open title=_"Send message to customer"
                                  template="rs_kz_customer_update.tpl"
                                  account_id=account_id}
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
  <span id="rs_widget_account_details_table_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="rs_widget_account_details_table_tpl"
                                template="rs_widget_account_details_table.tpl"
                                account_id=account_id
                        }
        %}
      </div>
  </span>
{% endblock %}
