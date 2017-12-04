<ul class="nav navbar-nav">
  {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status)
       and m.kazoo.is_kazoo_account_admin
  %}
    <li><a href="/reseller_portal">{_ Accounts _}</a></li>
    <li><a href="/reseller_settings">{_ Settings _}</a>
    <li><a href="/billing_operations">{_ Operations _}</a></li>
    <li><a href="/reseller_system_monitor">{_ Monitor _}</a></li>
  {% endif %}
</ul>
{% if m.session.kazoo_reseller_account_id
     and (m.session.kazoo_account_id != m.session.kazoo_reseller_account_id)
%}
  <ul class="nav navbar-nav navbar-right hidden-xs" style="margin-right: 0;">
    {% wire id="rs_demask" action={postback postback="rs_account_demask" delegate="mod_kazoo"} %}
    <li id="rs_demask">
      <a href="#">{_ Unmask _} -- {{ m.kazoo[{kz_account_doc_field field1="name"}] }} -- </a>
    </li>
  </ul>
{% endif %}
