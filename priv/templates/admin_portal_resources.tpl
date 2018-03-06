{% with m.kazoo.outbound_routing_strategy as routing %}
  {% if routing[1] == "resources" and not routing[2] %}
            {% include "reseller_portal_resources.tpl" headline=_"Outbound routing" %}
  {% endif %}
{% endwith %}
