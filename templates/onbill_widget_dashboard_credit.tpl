{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }} 
    {% if m.session.kazoo_reseller_account_id
          and
          (m.session.kazoo_account_id != m.session.kazoo_reseller_account_id)
          and
          pr_pt[1]["armed"]
    %}
        {% button id="disarm_credit_btn" class="btn btn-xs btn-onnet pull-right" text=_"cancel credit"%}
        {% wire id="disarm_credit_btn" action={postback postback="disarm_credit" delegate="mod_onbill"} %}
    {% endif %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
  {% if pr_pt[1]["armed"] %}
    {% include "_onbill_widget_dashboard_credit_armed.tpl" pr_pt=pr_pt %}
  {% else %}
    {% include "_onbill_widget_dashboard_credit_disarmed.tpl" pr_pt=pr_pt %}
  {% endif %}

  {% print m.onbill.promised_payment[1] %}

{% endblock %}
