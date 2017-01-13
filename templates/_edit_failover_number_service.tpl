{% with m.kazoo[{number_info number=number}] as number_info %}
{# print number_info[1] #}
{% wire id="edit-failover-number-service-form"
        type="submit"
        postback={edit_failover_number_service number=number account_id=account_id}
        delegate="mod_kazoo"
%}
<form id="edit-failover-number-service-form"  method="post" action="postback">
  <br />
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% wire id="failover_type"
                  type="change"
                  action={script script="Type = $('#failover_type').val();
                                         if (Type == 'sip')
                                             {$('#failover_destination').prop('placeholder', 'sip:jon@doe.com');
                                              $('#failover_destination').val('"++ number_info[1]["failover"][1]["sip"] ++"');
                                              $('#failover_destination').show()}
                                         else if (Type == 'e164')
                                             {$('#failover_destination').prop('placeholder', '+1 415-222-5555');
                                              $('#failover_destination').val('"++ number_info[1]["failover"][1]["e164"] ++"');
                                              $('#failover_destination').show()}
                                         else
                                             {$('#failover_destination').hide()};"
                         }
                  action={slide_down target="button_failover_number_service"}
          %}
          <select name="failover_type" id="failover_type" class="form-control margin-bottom-xs">
            <option id="deactivated"
                    value="deactivated"
                    {% if not number_info[1]["failover"] %}selected{% endif %}>
              {_ No failover _}
            </option>
            <option id="e164"
                    value="e164"
                    {% if number_info[1]["failover"][1][1][1] == "e164" %}selected{% endif %}>
              {_ Alternate Number _}
            </option>
            <option id="sip"
                    value="sip"
                    {% if number_info[1]["failover"][1][1][1] == "sip" %}selected{% endif %}>
              {_ SIP Address _}
            </option>
          </select>
        </div>
        <div class="col-sm-6">
          <input id="failover_destination"
                 name="failover_destination"
                 type="text"
                 class="form-control margin-bottom-xs {% if not number_info[1]["failover"] %}display_none{% endif %}"
                 placeholder="{% if number_info[1]["failover"][1]["sip"] %}
                                sip:jon@doe.com
                              {% elseif number_info[1]["failover"][1]["e164"] %}
                                +1 415-222-5555
                              {% endif %}"
                 value="{{ number_info[1]["failover"][1][1][2] }}">
        </div>
      </div>
    </div>
  <br />
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      {% button id="button_failover_number_service_close" class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Close" %}
    </div>
  </div>
</div>
  <div class="row">
    <div class="col-sm-12">
      <button id="button_failover_number_service" class="col-xs-12 btn btn-zalarm margin-bottom-xs display_none">{_ Save _}</button>
    </div>
  </div>
{% wire id="button_failover_number_service" action={submit target="edit-failover-number-service-form"} %}
{% wire id="button_failover_number_service_close" action={dialog_close} %}
{% endwith %}
