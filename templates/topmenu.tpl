{% if m.kazoo.is_auth %}
  {% include "menu_kazoo_auth.tpl" %}
{% elseif m.session.lb_user_id %}
  {% include "menu_lbonly_auth.tpl" %}
{% else %}
  {% include "menu_noauth.tpl" %}
{% endif %}
