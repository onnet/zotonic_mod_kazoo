{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table class="table table-condensed table-hover table-centered">
   <thead>
        <tr>
            <th>{_ Counterparty _}</th>
            <th>{_ Date _}</th>
            <th>{_ Sum _}</th>
            <th>{_ VAT _}</th>
            <th>{_ Total _}</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/getlbdocs/id/{{order_id}}">{{ oper_name }}</a></td>
            <td><a href="/getlbdocs/id/{{order_id}}">{{ order_date[2]|date:'Y-m-d' }}</a></td>
            <td><a href="/getlbdocs/id/{{order_id}}">{{ curr_summ|format_price:[".",""] }}</a></td>
            <td><a href="/getlbdocs/id/{{order_id}}">{{ tax_summ|format_price:[".",""] }}</a></td>
            <td><a href="/getlbdocs/id/{{order_id}}">{{ total_summ|format_price:[".",""] }}</a></td>
        </tr>
    </tbody>
</table>
{% endblock %}

