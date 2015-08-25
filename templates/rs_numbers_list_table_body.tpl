    <thead>
        <tr>
            <th class="text-center">{_ Number _}</th>
            <th class="text-center">{_ State _}</th>
            <th class="text-center">{_ Used By _}</th>
            <th class="text-center">{_ Delete _}</th>
        </tr>
    </thead>
    <tbody>
        {% for number in m.kazoo[{get_acc_numbers_info account_id=q.triggervalue}] %}
          <tr  id="number_line_{{ forloop.counter }}">
             <td class="text-center">{{ number[1] }}</td>
             <td class="text-center">{{ number[2][1]["state"] }}</td>
             <td class="text-center">{% if number[2][1]["used_by"] %}{{ number[2][1]["used_by"] }}{% else %}spare{% endif %}</td>
             <td class="text-center">
                {% wire id="delete_number_"++forloop.counter
                  action={confirm text=_"Do you really want to delete this number? <br />"
                          action={postback postback={deallocate_number number=number[1] account_id=q.triggervalue} delegate="mod_kazoo"}
                          action={mask target="number_line_"++forloop.counter message=_"Processing number removal..."}
                         }
                %}
                <i id="delete_number_{{ forloop.counter }}" style="cursor: pointer;" class="fa fa-trash-o" title="{_ Delete _}"></i>
             </td>
          </tr>
        {% endfor %}
    </tbody>
