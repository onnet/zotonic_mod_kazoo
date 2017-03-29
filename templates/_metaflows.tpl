{% with m.kazoo[{metaflows account_id=account_id}] as metaflows %}
<div class="row">
  <br />
  <div class="col-sm-6">
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">Default metaflow</label></div>
      <div id="account_metaflowsdefault_metaflow" class="col-xs-5">
        <i id="toggle_account_metaflowsdefault_metaflow"
           class="fa fa-toggle-{% if metaflows[1]["default_metaflow"] %}on{% else %}off{% endif %} pointer"></i>
        {% wire id="toggle_account_metaflowsdefault_metaflow"
                type="click"
                action={ postback postback={toggle_field type doc_id field_name prefix}
                delegate="mod_kazoo"
                inject_args type="account" doc_id="_no_need_" field_name=["metaflows","default_metaflow"] prefix="account_"}
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
        %}
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">Digit timeout, ms</label></div>
      <div id="metaflowsdigit_timeout_ms" class="col-xs-5">
        {% include "_show_field.tpl" type="account"
                                     doc_id="_no_need_"
                                     field_name=["metaflows","digit_timeout_ms"]
        %}
      </div>
    </div>
    <div class="row">
      <div class="col-xs-7"><label class="edit_user_label">Binding digit</label></div>
      <div id="metaflowsbinding_digit" class="col-xs-5">
        {% include "_show_field.tpl" type="account"
                                     doc_id="_no_need_"
                                     field_name=["metaflows","binding_digit"]
        %}
      </div>
    </div>
  </div>
</div>
{% endwith %}

{% print m.kazoo[{metaflows account_id=account_id}] %}


