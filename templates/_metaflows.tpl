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
                action={postback postback={toggle_field type doc_id field_name prefix}
                                 delegate="mod_kazoo"
                                 inject_args type="account"
                                             doc_id="_no_need_"
                                             field_name=["metaflows","default_metaflow"]
                                             prefix="account_"
                       }
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
      <div class="col-xs-6"><label class="edit_user_label">Digit timeout, ms</label></div>
      <div id="metaflowsdigit_timeout_ms" class="col-xs-6">
        {% include "_show_field.tpl" type="account"
                                     doc_id="_no_need_"
                                     field_name=["metaflows","digit_timeout_ms"]
        %}
      </div>
    </div>
    <div class="row">
      <div class="col-xs-6"><label class="edit_user_label">Binding digit</label></div>
      <div id="metaflowsbinding_digit" class="col-xs-6">
        {% include "_show_field.tpl" type="account"
                                     doc_id="_no_need_"
                                     field_name=["metaflows","binding_digit"]
        %}
      </div>
    </div>
  </div>
</div>
{% endwith %}

  <form id="form_add_task" method="post" action="postback">
        <br />
    <div id="add_captures_button_div" class="form-group">
      <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                    text=_"Add capture"
                    action={slide_down target="add_captures_div"}
                    action={slide_up target="add_captures_button_div"}
          %}
        </div>
      </div>
    </div>
    <div class="form-group">
      <div id="add_captures_div" class="row display_none">
        <div class="col-sm-4 col-sm-offset-2">
              {% include "_metaflows_capture_select_type.tpl" %}
        </div>
        <div class="col-sm-4">
            <span id="metaflows_capture_input_span">
              {% include "_metaflows_capture_input.tpl" %}
            </span>
        </div>
      </div>
    </div>
    <span id="metaflows_select_module_span">
    </span>
  </form>

{# print m.kazoo[{metaflows account_id=account_id}] #}
