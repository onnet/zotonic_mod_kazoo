<div class="row pb-1 pt-1">
  <div class="col-sm-6">
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">Default metaflow</label></div>
      <div id="account_metaflowsdefault_metaflow" class="col-xs-5">
        {% include "_show_field_checkbox.tpl" type="account"
                                              doc_id="_no_need_"
                                              field_name=["metaflows","default_metaflow"]
                                              prefix="account_"
                                              account_id=account_id
        %}
      </div>
    </div>
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">Listen on</label></div>
      <div id="metaflowslisten_on" class="col-xs-5">
        {% include "_show_field_select.tpl" type="account"
                                            doc_id="_no_need_"
                                            field_name=["metaflows","listen_on"]
                                            options=["self","peer","both"]
                                            account_id=account_id
        %}
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="row">
      <div class="col-xs-6"><label class="edit_user_label">Digit timeout, ms</label></div>
      <div id="metaflowsdigit_timeout_ms" class="col-xs-6">
        {% include "_show_field.tpl" type="account"
                                     doc_id="_no_need_"
                                     field_name=["metaflows","digit_timeout_ms"]
                                     account_id=account_id
        %}
      </div>
    </div>
    <div class="row">
      <div class="col-xs-6"><label class="edit_user_label">Binding digit</label></div>
      <div id="metaflowsbinding_digit" class="col-xs-6">
        {% include "_show_field.tpl" type="account"
                                     doc_id="_no_need_"
                                     field_name=["metaflows","binding_digit"]
                                     account_id=account_id
        %}
      </div>
    </div>
  </div>
</div>
{% with m.kazoo[{metaflows account_id=account_id}] as metaflows %}
<div class="col-sm-8 col-sm-offset-2 mb-1" style="padding: 1.5em">
  {% for number in metaflows[1]["numbers"][1] %} 
    <div class="row pb-1 pt-1"
         style="{% if forloop.first %}border-top: 1px solid #e5e5e5;{% endif %}
                border-bottom: 1px solid #e5e5e5;
                border-left: 1px solid #e5e5e5;
                border-right: 1px solid #e5e5e5;">
    {% include "_metaflows_capture_element.tpl" type="numbers" capture=number %}
    </div>
  {% endfor %}
  {% for pattern in metaflows[1]["patterns"][1] %} 
    <div class="row pb-1 pt-1"
         style="border-bottom: 1px solid #e5e5e5;
                border-left: 1px solid #e5e5e5;
                border-right: 1px solid #e5e5e5;">
    {% include "_metaflows_capture_element.tpl" type="patterns" capture=pattern %}
    </div>
  {% endfor %}
</div>
{% endwith %}
<span id="metaflows_capture_add_span">
  {% include "_metaflows_capture_add.tpl" %}
</span>
{# print m.kazoo[{metaflows account_id=account_id}] #}
