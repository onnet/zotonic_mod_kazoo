{% wire type={mqtt topic="~site/public/current_account_credit_" ++ m.session.kazoo_account_id}
        action={replace target=#current_account_credit template="_current_account_credit.tpl"}
              
%}
<span id="{{ #current_account_credit }}">{{ m.kazoo.current_account_credit|currency_sign }} {{ m.session.kazoo_account_id }}</span>

{% wire type={mqtt topic="~site/public/hello"} action={growl text="hello"} %}
