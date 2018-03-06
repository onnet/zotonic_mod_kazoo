{% with m.kazoo[{number_info number=number}] as number_info %}
{# print number_info[1] #}
{% wire id="edit-cname-number-service-form"
        type="submit"
        postback={edit_cname_number_service number=number account_id=account_id}
        delegate="mod_kazoo"
%}
<form id="edit-cname-number-service-form"  method="post" action="postback">
  <br />
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4 col-sm-offset-1">
          <span class="zalarm" style="float: right; margin-top: 8px;">
          {_ Outbound Caller ID Name _}:
          </span>
        </div>
        <div class="col-sm-3">
          {% wire id="cnam"
                  type="focus"
                  action={slide_down target="button_cname_number_service"}
          %}
          <input id="cnam"
                 name="cnam"
                 type="text"
                 class="form-control margin-bottom-xs"
                 placeholder="Input text here..."
                 value="{{ number_info[1]["cnam"][1]["display_name"] }}">
        </div>
      </div>
      <div class="row">
        <div class="col-sm-10 col-sm-offset-1">
        <p class="zprimary">
           <br />
           {_ This name will appear as your Caller ID when you make outbound calls (15 char. maximum). _}
           <br />
           {_ This request may take up to 72 hours to process. _}
        </p>
        </div>
      </div>
    </div>
  <br />
    <div class="form-group">
      <div class="row">
        <div class="col-sm-4 col-sm-offset-1">
          <span class="zalarm" style="float: right; margin-top: 8px;">
          {_ Inbound Caller ID Name _}:
          </span>
        </div>
        <div class="col-sm-3">
          {% wire id="inbound_lookup"
                  type="change"
                  action={slide_down target="button_cname_number_service"}
          %}
          <select name="inbound_lookup" id="inbound_lookup" class="form-control margin-bottom-xs">
            <option value="true" {% if number_info[1]["cnam"][1]["inbound_lookup"] %}selected{% endif %}>
              {_ Enabled _}
            </option>
            <option value="false" {% if not number_info[1]["cnam"][1]["inbound_lookup"] %}selected{% endif %}>
              {_ Disabled _}
            </option>
          </select>

        </div>
      </div>
      <div class="row">
        <div class="col-sm-9 col-sm-offset-1">
        <p class="zprimary">
           <br />
           {_ If you turn on this feature, the Caller's Name will appear in your Caller ID when you receive incoming calls. _}
        </p>
        </div>
      </div>
    </div>
  <br />
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      {% button id="button_cname_number_service_close" class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Close" %}
    </div>
  </div>
</div>
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cname_number_service" class="col-xs-12 btn btn-zalarm margin-bottom-xs display_none">{_ Save _}</button>
    </div>
  </div>
{% wire id="button_cname_number_service" action={submit target="edit-cname-number-service-form"} %}
{% wire id="button_cname_number_service_close" action={dialog_close} %}
{% endwith %}
