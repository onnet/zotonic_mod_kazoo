{% wire type="submit" id="arm_credit_form" postback="arm_credit" delegate="mod_onbill" %}
<form id="arm_credit_form" method="post" action="postback" delegate="mod_onbill">
<table id="dashboard_credit_table" class="table table-hover table-centered table-condensed">
  <thead>
    <tr>
      <th width="45%">{_ Apply for credit _}</th>
      <th width="15%"> </th>
      <th width="15%"> </th>
      <th width="15%"> </th>
      <th width="10%"> </th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>{_ Choose amount _}</td>
        <td>
           <input type="radio" name="creditme" value="25" /> {{ m.config.mod_kazoo.local_currency_sign.value }}25
        </td>
        <td>
           <input type="radio" name="creditme" value="50" /> {{ m.config.mod_kazoo.local_currency_sign.value }}50
        </td>
        <td>
           <input type="radio" name="creditme" value="100" /> {{ m.config.mod_kazoo.local_currency_sign.value }}100
        </td>
        <td>{% button class="btn btn-xs btn-onnet pull-right" text=_"proceed" %}</td>
    </tr>
  </tbody>
</table>
</form>
