{% if m.kazoo.is_kazoo_account_admin %}
  <ul class="nav navbar-nav">
    <li><a href="/dashboard">{_ Dashboard _}</a></li>
    {% if not m.kazoo.kz_current_context_superadmin %}
      <li><a href="/finance_details">{_ Payments _}</a></li>
    {% endif %}
  </ul>
{% endif %}
