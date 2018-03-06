<span>
  {% if limits[1][trunks_type] %}
    {{ limits[1][trunks_type] }}
  {% else %}
    0
  {% endif %}
</span>
<i id="edit_{{ trunks_type }}" class="fa fa-edit pointer" title="Edit {{ trunks_type }}"></i>
{% wire id="edit_"++trunks_type
        type="click"
        action={update target="span_id_"++trunks_type
                       template="_edit_trunks_manager_field_select.tpl"
                       account_id=account_id
                       current_trunks_amount=limits[1][trunks_type]
                       trunks_type=trunks_type
               }
%}
