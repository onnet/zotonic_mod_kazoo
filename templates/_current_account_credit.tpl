{% wire action={connect signal={refresh_current_account_credit_span}
                        action={replace target=#current_account_credit template="_current_account_credit.tpl"}
               }
%}
<span id="{{ #current_account_credit }}">{{ m.kazoo.current_account_credit|currency_sign }}</span>
