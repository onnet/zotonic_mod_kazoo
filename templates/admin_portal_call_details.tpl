{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_calls_details_widget" type="click"
        action={ toggle target="ap_calls_details_widget_opened" }
        action={ toggle target="arrow_right_calls_details_widget" }
        action={ toggle target="arrow_down_calls_details_widget" }
%}
  <span id="arrows_calls_details_widget" style="cursor: pointer;">
    <i id="arrow_right_calls_details_widget" {% if cdr_id %}style="display: none;"{% endif %} class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_calls_details_widget" {% if not cdr_id %}style="display: none;"{% endif %} class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="ap_calls_details_widget_opened" {% if not cdr_id %}style="display: none;"{% endif %}>
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="ap_calls_details_widget_opened"
                                                                    template="admin_portal_call_details_table.tpl"
                                                                    calls=m.kazoo[{kz_cdr_legs cdr_id=cdr_id}]
                                                            }
        %}
    </div>
</div>
{% endblock %}
