{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Operations" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% include "onbill_operations_docs_widget.tpl" headline=_"Docs operations" account_id=account_id %}
</div>
<div class="pl-10 pr-10 col-md-6">
  {% include "_ratedecks_widget.tpl" headline=_"Ratedecks" account_id=account_id %}
</div>

{% endblock %}
