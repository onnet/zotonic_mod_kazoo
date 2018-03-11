{% wire type="submit" id="arm_credit_form" postback="arm_credit" delegate="mod_kazoo" %}
<form id="arm_credit_form" method="post" action="postback" delegate="mod_kazoo">
<table id="dashboard_credit_table"
       class="table table-hover table-centered table-condensed">
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
         <input type="radio" name="creditme" value="25" />
         {{ m.vars.local_currency_sign }}25
      </td>
      <td>
         <input type="radio" name="creditme" value="50" />
         {{ m.vars.local_currency_sign }}50
      </td>
      <td>
         <input type="radio" name="creditme" value="100" />
         {{ m.vars.local_currency_sign }}100
      </td>
      <td>
        <button class="btn btn-xs btn-onnet pull-right">
          {_ proceed _}
        </button>
      </td>
    </tr>
  </tbody>
</table>
</form>
