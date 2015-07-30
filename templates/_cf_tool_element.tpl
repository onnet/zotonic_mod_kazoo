<div class="tool {{ tool_class }}" help="{{ help }}">
    {% draggable id=tool_id tag={ drag_args tool_name=tool_name} delegate="mod_kazoo" clone %}
    <div id="{{ tool_id }}" name="{{ tool_name }}" class="action" style="position: relative; opacity: 1; left: 0px; top: 0px;">
        <div class="icon medium app_sm {{ icon }}">
        </div>
        <div class="tool_name active">
            {{ tool_descr }}
        </div>
    </div>
</div>
