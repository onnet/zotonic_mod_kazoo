{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={toggle target="onbill_variables_settings_"++account_id++"_widget_opened"}
        action={toggle target="arrow_right_"++#dtid}
        action={toggle target="arrow_down_"++#dtid}
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="display: none;"
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
{% wire action={connect signal={refresh_onbill_variables_settings_signal signal_filter=m.kazoo.signal_filter}
                        action={update target="onbill_variables_settings_"++account_id++"_widget_opened"
                                       template="onbill_variables_settings.tpl"
                                       account_id=account_id
                               }
               }
%}
<div id="onbill_variables_settings_{{ account_id }}_widget_opened"
     style="display: none;">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="onbill_variables_settings_"++account_id++"_widget_opened"
                            template="onbill_variables_settings.tpl"
                            account_id=account_id
                    }
    %}
  </div>
</div>
{% endblock %}
