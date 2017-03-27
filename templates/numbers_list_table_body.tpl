    <thead>
        <tr>
            <th class="text-center">{_ Number _}</th>
            <th class="text-center">{_ State _}</th>
            <th class="text-center">{_ Used By _}</th>
            <th class="text-center">{_ E911 _}</th>
            <th class="text-center"></th>
            <th class="text-center"></th>
        </tr>
    </thead>
    <tbody>
      {% for number in m.kazoo.get_acc_numbers_info %}
        {% with  m.kazoo[{number_info number=number[1]}] as number_details %}
          <tr  id="number_line_{{ forloop.counter }}">
{% if number_details[1]["e911"] %}
  {# print number #}
  {# print number_details[1]["e911"] #}
{% endif %}
             <td class="text-center">{{ number[1] }}</td>
             <td class="text-center">{{ number[2][1]["state"] }}</td>
             <td class="text-center">{% if number[2][1]["used_by"] %}{{ number[2][1]["used_by"] }}{% else %}spare{% endif %}</td>
             <td class="text-center">
               {% if number_details[1]["e911"] %}
                 <i class="fa fa-check"></i>
               {% endif %}
             </td>
             <td class="text-center">
                {% wire id="edit_number_"++forloop.counter
                        action={dialog_open title=_"Edit number services for"++" "++number[1]|pretty_phonenumber
                                            template="_edit_number_services.tpl"
                                            number=number[1]
                                            width="auto"
                               }
                %}
                <i id="edit_number_{{ forloop.counter }}" style="cursor: pointer;" class="fa fa-edit pointer" title="{_ Edit _}"></i>
             </td>
             <td class="text-center">
                {% wire id="delete_number_"++forloop.counter
                  action={confirm text=_"Do you really want to delete this number? <br />"
                          action={postback postback={deallocate_number number=number[1]} delegate="mod_kazoo"}
                          action={mask target="number_line_"++forloop.counter message=_"Processing number removal..."}
                         }
                %}
                <i id="delete_number_{{ forloop.counter }}" style="cursor: pointer;" class="fa fa-trash-o" title="{_ Delete _}"></i>
             </td>
          </tr>
        {% endwith %}
      {% endfor %}
    </tbody>

