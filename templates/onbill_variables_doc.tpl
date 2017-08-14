{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={toggle target="onbill_variables_"++account_id++"_widget_opened"}
        action={toggle target="arrow_right_"++#dtid}
        action={toggle target="arrow_down_"++#dtid}
        action={toggle target="save_json_"++account_id}
        action={toggle target="restore_json_"++account_id}
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}"
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}"
       style="display: none;"
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right display_none"
              text=_"save" id="save_json_"++account_id
              action={postback postback={onbill_set_variables_json account_id=account_id}
                               qarg="json_storage_"++account_id
                               delegate="mod_kazoo"
                     }
    %}
    {% button class="btn btn-xs btn-onnet pull-right display_none"
              text=_"restore"
              id="restore_json_"++account_id
    %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="onbill_variables_{{ account_id }}_widget_opened"
     style="display: none;">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="onbill_variables_"++account_id++"_widget_opened"
                            template="onbill_variables_table.tpl"
                            account_id=account_id
                    }
    %}
  </div>
</div>
{% endblock %}
