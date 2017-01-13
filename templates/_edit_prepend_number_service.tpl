{% with m.kazoo[{number_info number=number}] as number_info %}
{# print number_info[1] #}
{% wire id="edit-prepend-number-service-form"
        type="submit"
        postback={edit_failover_number_service number=number account_id=account_id}
        delegate="mod_kazoo"
%}
<form id="edit-prepend-number-service-form"  method="post" action="postback">
  <br />
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <span style="float: right; margin-top: 8px;">
          {_ Text to prepend: _}
          </span>
        </div>
        <div class="col-sm-3">
          {% wire id="failover_type"
                  type="change"
                  action={slide_down target="button_prepend_number_service"}
          %}
          <select name="failover_type" id="failover_type" class="form-control margin-bottom-xs">
            <option value="true" {% if number_info[1]["prepend"][1]["enabled"] %}selected{% endif %}>
              {_ Enabled _}
            </option>
            <option value="false" {% if not number_info[1]["prepend"][1]["enabled"] %}selected{% endif %}>
              {_ Disabled _}
            </option>
          </select>

        </div>
        <div class="col-sm-5">
          {% wire id="prepend_text_input"
                  type="focus"
                  action={slide_down target="button_prepend_number_service"}
          %}
          <input id="prepend_text_input"
                 name="prepend_text_input"
                 type="text"
                 class="form-control margin-bottom-xs"
                 placeholder="Input text here..."
                 value="{{ number_info[1]["prepend"][1]["name"] }}">
        </div>
      </div>
    </div>
  <br />
</form>
<p>{_ This text will appear before your number when receiving a call. _}
   {_ This can be used to better identify which number was called when you use more than one. _}
</p>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      {% button id="button_prepend_number_service_close" class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Close" %}
    </div>
  </div>
</div>
  <div class="row">
    <div class="col-sm-12">
      <button id="button_prepend_number_service" class="col-xs-12 btn btn-zalarm margin-bottom-xs display_none">{_ Save _}</button>
    </div>
  </div>
{% wire id="button_prepend_number_service" action={submit target="edit-prepend-number-service-form"} %}
{% wire id="button_prepend_number_service_close" action={dialog_close} %}
{% endwith %}
