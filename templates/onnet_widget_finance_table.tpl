<table class="table table-condensed table-hover table-centered">
    <thead>
        <tr>
            <th>{_ Account status _}</th>
            <th>{% if m.kazoo[{kz_account_doc_field field1="enabled"}] %}<span class="zprimary">{_ Active _}</span> 
                            {% else %}<span class="zalarm">{_ Blocked _}{% endif %}</span>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr><td>{_ Current balance _}</td><td>{{ m.config.mod_kazoo.local_currency_sign.value }}{{ m.kazoo.current_account_credit|format_price }}</td></tr>
    </tbody>
</table>
