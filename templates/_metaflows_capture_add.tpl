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
        <span id="metaflows_capture_select_type_span">
          {% include "_metaflows_capture_select_type.tpl" %}
        </span>
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
