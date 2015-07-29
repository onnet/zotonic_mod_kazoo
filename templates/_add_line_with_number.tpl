        <tr id={{ #tr }}>
            <td class="td-center" width="40%">
                {{ number }}
            </td>
            <td class="td-center" width="40%">
               {{ price|onnet_add_vat }} {_ rub. _} ({_ incl. _} {_ VAT _})
            </td>
            <td class="hidden"><input id="badidea" type="hidden" value={{ number_id }}:{{ price }} name="chosennumbers"></td>
            <td class="td-center"><i id={{ #del }} title="{_ Remove _}" class="fa fa-times-circle-o fa-lg"></i> </td>
            {% wire id=#del action={remove target=#tr } %}
        </tr>
