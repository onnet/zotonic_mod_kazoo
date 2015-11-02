<div id="{{ element_id }}_child" class="child">
    {% if drop_parent == "menu" or drop_parent == "temporal_route" or drop_parent == "check_cid" %}
      {% include "_cf_child_head_option.tpl" %}
    {% else %}
      {% include "_cf_child_head.tpl" %}
    {% endif %}
    {% droppable id=element_id tag={drop_args drop_id=element_id drop_parent=tool_name} delegate="mod_kazoo" %}
    <div id="{{ element_id }}" class="branch">
        <div name="{{ tool_name }}" class="node icons_black" style="position: relative;">
            <div class="node-options">
                {% wire id=element_id++"_delete" action={remove target=element_id++"_child"}
                                                 action={postback postback={cf_delete_element element_id=element_id} delegate="mod_kazoo"}
                %}
                <div id="{{ element_id }}_delete" class="delete"></div>
                {% wire id=element_id++"_cf_park" action={postback postback={cf_park_element element_id=element_id} delegate="mod_kazoo"} %}
                <div id="{{ element_id }}_cf_park" class="cf_park"></div>
                <div class="module">
                    {% wire id=element_id++"_div_icon" action={ dialog_open title=_"Edit"++" " template="_cf_select_"++tool_name++".tpl" element_id=element_id
                                                                                                                                       tool_name=tool_name
                                                                                                                                       kz_element_id=kz_element_id
                                                                                                                                       kz_element_name=kz_element_name
                                                              }
                    %}
                    <div id="{{ element_id }}_div_icon" class="div_icon">
                        <span class="icon"></span>
                        <span class="module_name"></span>
                    </div>
                    <div id="{{ element_id }}_details" class="details">{{ kz_element_name }}</div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div id="{{ element_id }}-children" class="children">
          {% wire action={postback postback={check_children id=element_id  drop_id=element_id drop_parent=tool_name} delegate="mod_kazoo"} %}
        </div>
    </div>
</div>
{% javascript %}
    $('#{{ element_id }} .icon').addClass($('#{{ tool_name }} div.icon').attr('class').split(' ').pop());
    $('#{{ element_id }} .module_name').text($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
