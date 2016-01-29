{% wire id="form_account_list_entries" type="submit" postback="account_list_entries" delegate="mod_kazoo" %}
<form id="form_account_list_entries" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-2">
            <select id="cid_key" name="cid_key" class="form-control margin-bottom-xs" style="text-align:center;">
                <option value="00" {% if list[1]["cid_key"] == "00" %}selected{% endif %}> 00</option>
                <option value="01" {% if list[1]["cid_key"] == "01" %}selected{% endif %}> 01</option>
                <option value="02" {% if list[1]["cid_key"] == "02" %}selected{% endif %}> 02</option>
                <option value="03" {% if list[1]["cid_key"] == "03" %}selected{% endif %}> 03</option>
                <option value="04" {% if list[1]["cid_key"] == "04" %}selected{% endif %}> 04</option>
                <option value="05" {% if list[1]["cid_key"] == "05" %}selected{% endif %}> 05</option>
                <option value="06" {% if list[1]["cid_key"] == "06" %}selected{% endif %}> 06</option>
                <option value="07" {% if list[1]["cid_key"] == "07" %}selected{% endif %}> 07</option>
                <option value="08" {% if list[1]["cid_key"] == "08" %}selected{% endif %}> 08</option>
                <option value="09" {% if list[1]["cid_key"] == "09" %}selected{% endif %}> 09</option>
                <option value="10" {% if list[1]["cid_key"] == "10" %}selected{% endif %}> 10</option>
                <option value="11" {% if list[1]["cid_key"] == "11" %}selected{% endif %}> 11</option>
                <option value="12" {% if list[1]["cid_key"] == "12" %}selected{% endif %}> 12</option>
                <option value="13" {% if list[1]["cid_key"] == "13" %}selected{% endif %}> 13</option>
                <option value="14" {% if list[1]["cid_key"] == "14" %}selected{% endif %}> 14</option>
                <option value="15" {% if list[1]["cid_key"] == "15" %}selected{% endif %}> 15</option>
                <option value="16" {% if list[1]["cid_key"] == "16" %}selected{% endif %}> 16</option>
                <option value="17" {% if list[1]["cid_key"] == "17" %}selected{% endif %}> 17</option>
                <option value="18" {% if list[1]["cid_key"] == "18" %}selected{% endif %}> 18</option>
                <option value="19" {% if list[1]["cid_key"] == "19" %}selected{% endif %}> 19</option>
            </select>
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control margin-bottom-xs" id="cid_name" name="cid_name" placeholder="{_ Enter CID name here _}" value="">
        </div>
        <div class="col-sm-3">
            <select id="cid_number" name="cid_number" class="form-control margin-bottom-xs selectpicker" style="text-align:center;" data-live-search="true">
              {% for number in m.kazoo.get_acc_numbers %}
                  <option value="{{ number }}" {% if c2call[1]["caller_id_number"] == number %}selected{% endif %}>{{ number }}</option>
              {% endfor %}
            </select>
            {% javascript %}
                $('#cid_number').selectpicker({
                  size: 7
                });
            {% endjavascript %}
        </div>
        <div class="col-sm-3">
          {% button text=_"Add entry" class="col-xs-12 btn btn-zprimary margin-bottom-xs" action={submit target="form_account_list_entries"}
                                                                                          action={form_reset target="form_account_list_entries" } %}
        </div>
      </div>
    </div>
    <input type="hidden" name="list_id" value="{{ list_id }}" />
    <input type="hidden" name="list_type" value="{{ list_type }}" />
    <input type="hidden" name="template_name" value="_dynamic_cid_list_entries_dialog.tpl" />
</form>
  <div class="form-group">
    <div class="row">
      <div id="list_entries_div" class="col-sm-6 col-sm-offset-3">
          {% include "_dynamic_cid_list_entries_dialog.tpl" list_id=list_id %}
      </div>
    </div>
  </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          {% button text=_"Close" class="col-xs-12 btn btn-zprimary margin-bottom-xs" action={dialog_close} %}
        </div>
      </div>
    </div>
{# print m.kazoo[{kz_list_account_list_entries list_id=list_id}] #}
