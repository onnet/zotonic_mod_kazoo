{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% button class="btn btn-xs btn-onnet pull-right"
          text=_"add" 
          action={submit target="add-cccp-pin-form"}
%}
<i class="fa fa-mobile-phone fa-lg hidden-md"></i>
<input type="text"
       class="input input-number-onnet"
       name="pin_number"
       maxlength="12" 
       readonly value={{ ["0","1","2","3","4","5","6","7","8","9","0","7"]
                         |randomize }} />
<i class="fa fa-user hidden-md pl-05"></i>
<select id="cccp_pin_user_id"
        name="user_id"
        data-width="12em"
        data-live-search="true">
{% for user in m.kazoo.kz_list_account_users %}
  <option value="{{ user[1]["id"] }}">{{ user[1]["username"] }}</option>
{% endfor %}
</select>
{% javascript %}
    $('#cccp_outbound_pin_selector').selectpicker({size: 5, style: 'btn-xs btn-onnet'});
    $('#cccp_pin_user_id').selectpicker({size: 5, style: 'btn-xs btn-onnet'});
{% endjavascript %}
{% endblock %}

