{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right"
              text=_"refresh results"
              action={postback postback="refresh_onbill_docs"
                               delegate="mod_onbill"
                               qarg="docsmonthInput"
                     }
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table class="table table-condensed table-hover table-centered">
<tbody>
  <tr>
      <td>
        {_ Choose month1 _}
      </td>
      <td class="text-right" colspan="2">
         <div class="date"
              id="documentsMonth"
              data-date="{{ now|sub_month|date: 'm/Y' }}"
              data-date-format="mm/yyyy"
              data-date-min-view-mode="months"
              data-date-autoclose="true"
              data-date-language={{ z_language }}
              data-date-language={{ lang_code }}
              data-date-start-date="-6m"
              data-date-end-date="0m">{_ Month: _}&nbsp;&nbsp;&nbsp;&nbsp;
           <input id="docsmonthInput"
                  type="text"
                  class="input-small-onnet"
                  name="docsmonthInput"
                  value="{{ now|sub_month|date: 'm/Y' }}"
                  readonly/>
           <span class="add-on" style="padding-left: 1em;">
             <i class="fa fa-calendar"></i>
           </span>
         </div>
         {% javascript %}
            $('#documentsMonth').datepicker();
         {% endjavascript %}
      </td>
  </tr>
</tbody>
</table>
{% endblock %}
