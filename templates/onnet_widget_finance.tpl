{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh balance" action={emit signal={update_onnet_widget_finance_tpl} } %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
    {% wire action={connect signal={update_onnet_widget_finance_tpl} action={update target="onnet_widget_finance_tpl" template="onnet_widget_finance_lazy.tpl"}} %}
    <span id="onnet_widget_finance_tpl">
        {% include "onnet_widget_finance_table.tpl" %}
    </span>
{% endblock %}
