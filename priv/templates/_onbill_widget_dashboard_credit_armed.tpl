<table id="dashboard_credit_table" class="table table-hover table-centered table-condensed">
  <thead>
    <tr>
      <th width="35%">
        {_ Status _}
      </th>
      <th width="65%">
        {% if (pr_pt[1]["start"] + pr_pt[1]["duration"])|inno_timestamp_expired == "active" %}
          <span class="zwarning"> {_ Active _} </span>
        {% elif (pr_pt[1]["start"] + pr_pt[1]["duration"])|inno_timestamp_expired == "expired" %}
          <span class="zalarm"> {_ Expired _} </span>
        {% else %}
          {_ Undefined _}
        {% endif %}
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        {_ Credit amount _}
      </td>
      <td>
        {{ m.vars.local_currency_sign }}{{ pr_pt[1]["amount"]|onnet_format_price }}
      </td>
    </tr>
    <tr>
      <td>
        {_ Maturity date _}
      </td>
      <td>
        {{
          (pr_pt[1]["start"] + pr_pt[1]["duration"])
          |gregsec_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone
        }}
      </td>
    </tr>
  </tbody>
</table>
