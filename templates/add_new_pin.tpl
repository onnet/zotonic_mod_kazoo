{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}

{% button class="btn btn-xs btn-onnet pull-right" text=_"add" 
                                          action={submit target="add-cccp-pin-form"}
%}

<i class="fa fa-mobile-phone fa-lg hidden-md"></i>
<input type="text" class="input input-number-onnet" style="margin-right: 0.5em;" name="pin_number" maxlength="12" 
                  readonly value={{ ["0","1","2","3","4","5","6","7","8","9","0","7"]|randomize }} />

<i class="fa fa-slack hidden-md"></i>
<select name="outbound_cid" style="margin-right: 0.5em;">
{% for number in m.kazoo.get_acc_numbers %}
  <option value="{{ number }}">{{ number }}</option>
{% endfor %}
</select>

<i class="fa fa-user hidden-md"></i>
<select name="user_id">
{% for user in m.kazoo.kz_list_account_users %}
  <option value="{{ user["id"] }}">{{ user["username"] }}</option>
{% endfor %}
</select>

{% endblock %}

