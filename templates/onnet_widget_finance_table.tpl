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
        <tr><td>{_ Current balance _}</td><td>{% include "_current_account_credit.tpl" %}</td></tr>
    </tbody>
</table>
