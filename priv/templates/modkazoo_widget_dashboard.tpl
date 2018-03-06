<div {% if idname %}id={{ idname }}{% endif %} class="panel panel-onnet {% if class %}{{ class }}{% endif %}{% block widget_class %}{% endblock %}">
  <div class="panel-heading">
    <h3 class="panel-title">
	{% block widget_headline %}{% endblock %}
    </h3>
  </div>
    <div class="panel-body">
        {% block widget_content %}{% endblock %}
    </div>
</div>
