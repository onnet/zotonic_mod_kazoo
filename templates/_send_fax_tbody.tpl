{% wire id="send-fax-form" type="submit" postback="send_fax" delegate="mod_kazoo" %}
<form id="send-fax-form" method="post" action="postback" class="form">
<table class="table table-condensed table-hover table-centered" style="table-layout: fixed;">
<tbody id="send-fax-tbody">
  <tr id="send_to_number">
  <td style="width: 63%">{_ Enter the number of the Fax to send document to _}:</td>
  <td class="td-left"><input id="fax_number" class="input input-number-onnet" type="text" name="fax_number" placeholder="{{ m.config.mod_kazoo.placeholder_phone.value }}" maxlength="15"></td>
  {% validate id="fax_number" type={format pattern="^[0-9]+$" failure_message=_"Invalid phone format"} %}
  </tr>
  <tr id="fax_file">
  <td >{_ Please upload your document _} (pdf, tiff):</td>
  <td class="td-left"><input id="faxfile" type="file" name="faxfile" accept="application/pdf,image/tiff" style="width: 61%;" onchange="this.style.width = '100%';"></td>
  </tr>
  <tr id="send_from_number">
  <td >{_ Please choose the number to send fax from _}:</td>
  <td class="td-left">
       <select name="fax_from" id="fax_from" class="btn-onnet">
       {% for number in m.kazoo.get_acc_numbers %}
       <option>{{ number }}</option>
       {% endfor %}
       </select></td>
  </tr>
  <tr id="attempts_number">
  <td >{_ Please choose the number of attempts _}:</td>
  <td class="td-left"><select name="attempts" id="fax_retries" maxlength="1" class="btn-onnet"><option>1</option><option>2</option><option>3</option></select></td>
  </tr>
  <tr id="company_name_header_line">
  <td >{_ Check to add company name to fax header _}:</td>
  <td class="td-left"><input type="checkbox" id="company_name_checkbox" name="company_name_checkbox" value="checked"></td>
  </tr>
</tbody>
</table>
</form>
