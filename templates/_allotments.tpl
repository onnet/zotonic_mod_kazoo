{% with m.kazoo[{allotments account_id=account_id}][1] as allotments %}
  {% for allotment in allotments %}
    {% include "_allotment_element.tpl" allotment=allotment %}
  {% endfor %}
{% endwith %}
<br />
