{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
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
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
        <tr><th colspan="2">Contacts:</th>
        <tr><td>E-mail</td><td>{{ m.kazoo[{kz_account_doc_field field1="contact" field2="billing" field3="email"}] }}</td></tr>
        <tr><td>{_ Phone number _}</td><td>{{ m.kazoo[{kz_account_doc_field field1="contact" field2="billing" field3="number"}] }}</td></tr>
    </tbody>
</table>
{% endblock %}

