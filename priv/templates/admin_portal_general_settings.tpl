{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="ap_general_settings_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="ap_general_settings_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       style="{% if m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}display: none;{% endif %}"
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="{% if not m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}display: none;{% endif %}"
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% if m.session.kazoo_reseller_account_id %}
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
    {% endif %}
    {% button class="btn btn-xs btn-onnet pull-right"
              text=_"controls"
              action={dialog_open title=_"Access/features controls"
                                  template="_edit_account_access_restrictions.tpl"
                     }
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="ap_general_settings_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={update target="ap_general_settings_widget_opened"
                                template="admin_portal_general_settings_list_table.tpl"}
        %}
    </div>
</div>

{% endblock %}
