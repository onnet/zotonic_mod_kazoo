{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="onbill_operations_docs_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="onbill_operations_docs_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="onbill_operations_docs_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="onbill_operations_docs_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
             <input id="docs_month_chosen" type="text" class="input-small-onnet pull-right" name="docs_month_chosen"
                                                            value="{% if docs_month_chosen %}{{ docs_month_chosen }}{% else %}{{ now|date: 'm/Y' }}{% endif %}"
                                                            data-date="{% if docs_month_chosen %}{{ docs_month_chosen }}{% else %}{{ now|date: 'm/Y' }}{% endif %}"
                                                            data-date-min-view-mode="months"
                                                            data-date-format="mm/yyyy"
                                                            data-date-autoclose="true"
                                                            data-date-language={{ z_language }}
                                                            data-date-start-date="-36m"
                                                            data-date-end-date="+0d"
                                                            readonly/>
            <span class="pull-right pr-05"> {_ Choose month _}: </span>
            {% javascript %}
                $('#docs_month_chosen').datepicker();
            {% endjavascript %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="onbill_operations_docs_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="onbill_operations_docs_widget_opened"}] %}display: none;{% endif %}">
  <table class="table table-condensed table-centered">
    <tbody>
        <tr>
          <td colspan="3">
            {_ Generate documents _}
            {% button class="btn btn-xs btn-onnet pull-right" text=_"generate"
                      action={postback postback="generate_children_docs"
                                       delegate="mod_onbill"
                                       qarg="docs_month_chosen"
                             }
            %}
          </td>
        </tr>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    </tbody>
  </table>
  <table class="table table-condensed table-centered">
    <tbody>
        <tr>
          <td colspan="3">
            {_ Email documents _}
            {% button class="btn btn-xs btn-onnet pull-right" text=_"send"
                      action={postback postback="send_children_docs"
                                       delegate="mod_onbill"
                                       qarg="docs_month_chosen"
                             }
            %}
          </td>
        </tr>
    </tbody>
  </table>
</div>
{% endblock %}
