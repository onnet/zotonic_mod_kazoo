{% wire id="edit_"++allotment_name++"_"++field_name
        type="click"
        action={update target="allotment_"++allotment_name++"_"++field_name
                       template="_edit_allotment_field.tpl"
                       account_id=account_id
                       allotment_name=allotment_name
                       field_name=field_name
               }
%}
{{ m.kazoo[{allotments account_id=account_id}][1][allotment_name][1][field_name] }}
<i id="edit_{{ allotment_name }}_{{ field_name }}" class="fa fa-edit pointer" title="Edit {{ field_name }}"></i>
