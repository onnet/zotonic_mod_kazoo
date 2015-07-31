<div class="pl-10 pr-10 pb-10">
  <div class="pull-right">
  <p>
    {_ Logged in as _}
    {{ m.session.kazoo_login_name }}
    {_ at _}
    <a href="/dashboard">{{ m.session.kazoo_account_name }}</a>
  </p>
  </div>
  <h2>{{ title }}</h2>
</div>
