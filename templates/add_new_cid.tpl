{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}

{% button class="btn btn-xs btn-onnet pull-right" text=_"add" 
                                          action={submit target="add-cccp-cid-form"}
%}

<i class="fa fa-mobile-phone fa-lg hidden-md"></i>
<input type="text" class="input input-number-onnet" name="cid_number" placeholder="1234567" maxlength="12"/>

<i class="fa fa-user hidden-md pl-05"></i>
<select id="cccp_cid_user_id" name="user_id" data-width="12em" data-live-search="true">
{% for user in m.kazoo.kz_list_account_users %}
  <option value="{{ user["id"] }}">{{ user["username"] }}</option>
{% endfor %}
</select>

{% javascript %}
    $('#cccp_outbound_cid_selector').selectpicker({size: 5, style: 'btn-xs btn-onnet'});
    $('#cccp_cid_user_id').selectpicker({size: 5, style: 'btn-xs btn-onnet'});
{% endjavascript %}

{% endblock %}

