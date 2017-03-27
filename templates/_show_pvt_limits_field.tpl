{% wire id="edit_pvt_limits_"++field_name
        type="click"
        action={update target="pvt_limits_"++field_name
                       template="_edit_pvt_limits_field.tpl"
                       account_id=account_id
                       field_name=field_name
                       filter=filter
               }
%}
{% if filter == "currency_sign" %}
  {{ m.onbill[{onbill_pvt_limits account_id=account_id}][1][field_name]|currency_sign }}
{% else %}
  {{ m.onbill[{onbill_pvt_limits account_id=account_id}][1][field_name] }}
{% endif %}
<i id="edit_pvt_limits_{{ field_name }}" class="fa fa-edit pointer" title="Edit {{ field_name }}"></i>
