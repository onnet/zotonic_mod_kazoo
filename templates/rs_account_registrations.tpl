{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="rs_account_registrations_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="rs_account_registrations_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="rs_account_registrations_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="rs_account_registrations_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}: {{ m.kazoo[{get_registrations_count_by_accountid account_id=account_id}] }}
  {% button class="btn btn-xs btn-onnet pull-right" text=_"current calls" id="currentcallsbtn"
            action={ dialog_open title=_"Current account calls" template="admin_portal_current_calls_table.tpl" class="iamclass" account_id=account_id width="auto" }
  %}


{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_account_registrations_widget_opened" style='{% if not m.kazoo[{ui_element_opened element="rs_account_registrations_widget_opened"}] %}display: none;{% endif %}'>
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="rs_account_registrations_widget_opened"
                                                                    template="rs_account_registrations_table_body.tpl" account_id=account_id}
        %}
   </div>
</div>
{% endblock %}
