<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <th colspan="3">
        {% wire id="arrows_"++#rdid type="click"
                action={toggle target="rs_related_documents_table_opened"}
                action={toggle target=#mytr}
                action={toggle target="arrow_right_"++#rdid}
                action={toggle target="arrow_down_"++#rdid}
                action={postback postback={trigger_innoui_widget arg="rs_related_documents_table_opened"} delegate="mod_kazoo"}
        %}
        <span id="arrows_{{ #rdid }}" style="cursor: pointer; padding-left: 0.7em;">
          <i id="arrow_right_{{ #rdid }}"
             class="arrowpad fa fa-arrow-circle-right"></i>
          <i id="arrow_down_{{ #rdid }}"
             style="display: none;" 
             class="arrowpad fa fa-arrow-circle-down"></i>
        </span>
        {_ Related documents _}
        <span style="float:right; padding-right:2em;">
        {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) and m.kazoo.is_kazoo_account_admin %}
          {% button class="btn btn-xs btn-onnet" text=_"create docs"
                    action={mask target="rs_related_documents_table_opened"}
                    action={postback postback={generate_rs_related_documents account_id doc_type}
                                     delegate="mod_kazoo"
                                     qarg="selected_billing_period"
                                     inject_args account_id=account_id doc_type="just_an_empty_field_yet"
                           }
          %}
        {% endif %}
        {% button class="btn btn-xs btn-onnet" text=_"create reports"
                  action={mask target="rs_related_documents_table_opened"}
                  action={postback postback={generate_rs_related_documents account_id doc_type}
                                   delegate="mod_kazoo"
                                   qarg="selected_billing_period"
                                   inject_args account_id=account_id doc_type="calls_reports"
                         }
        %}
        </span>
      </th>
    </tr>
    <tr id="{{ #mytr }}" style="display: none;">
      <th colspan="3"></th>
    </tr>
  </thead>
</table>
<span id="rs_related_documents_table_opened" style="display: none;">
  <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="rs_related_documents_table_opened"
                            template="rs_widget_related_documents_table.tpl"
                            account_id=account_id
                            selected_billing_period=selected_billing_period}
    %}
  </div>
</span>
