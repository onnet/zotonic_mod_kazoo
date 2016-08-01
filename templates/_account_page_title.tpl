<div id="account_page_title" class="pl-10 pr-10 pb-10">
  <div class="pull-right">
  <p>
    {_ Logged in as _}
    <span style="color:{{ m.config.mod_kazoo.color2.value }};">
      {% if m.session.kazoo_owner_id != "userless_mask" %}
        {{ m.kazoo[{kz_doc_field type="user" doc_id=m.session.kazoo_owner_id field="first_name"}] }}
        {{ m.kazoo[{kz_doc_field type="user" doc_id=m.session.kazoo_owner_id field="last_name"}] }}
      {% else %}
        {_ Without user _}
      {% endif %}
      {_ at _}
      {{ m.session.kazoo_account_name }}
    </span>
  </p>
  </div>
  <h3>{{ title }}</h3>
</div>
