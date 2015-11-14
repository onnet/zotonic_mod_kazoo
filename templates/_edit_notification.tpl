{% with m.kazoo[{kz_notification_info notification_id=notification_id}] as notification %}
{% print notification_id %}
{% print notification %}
{% endwith %}

