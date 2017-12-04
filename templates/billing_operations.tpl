{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Operations" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% include "onbill_operations_docs_widget.tpl" headline=_"Docs operations" account_id=account_id %}
</div>
<div class="pl-10 pr-10 col-md-6">
  <span id="tasks_widget_tpl">
    {% include "tasks_widget.tpl" headline=_"Background jobs" %}
  </span>
</div>

{% endblock %}
