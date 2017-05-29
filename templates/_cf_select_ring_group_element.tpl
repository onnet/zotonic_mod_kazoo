{% sortable id=#selected tag="test" delegate="mod_kazoo" %}
<div id="{{ #selected }}" class="row" style="padding-top:5px;">
  <input id="{{ #selected }}_index"
         type="hidden"
         name="{{ selected_value[1]["id"] }}"
         value="5000">
  <input type="hidden"
         name="sortable_element"
         value="{{ selected_value[1]["id"] }}">
  <input type="hidden"
         name="{{ selected_value[1]["id"] }}_type"
         value="{{ selected_value[1]["endpoint_type"] }}">
  <div class="col-xs-12">
    <div class="col-xs-1 col-xs-offset-1 text-center">
      {% if selected_value[1]["endpoint_type"]=="group" %} 
        <div class="icon user medium"></div>
      {% elseif selected_value[1]["endpoint_type"]=="user" %}
        <div class="icon head1 medium"></div>
      {% elseif selected_value[1]["endpoint_type"]=="device" %}
        <div class="icon device medium"></div>
      {% endif %}
    </div>
    <div id="{{ #name }}" class="col-xs-4 text-center"></div>
    <div class="col-xs-2 text-center">
      <input type="text"
             name="{{ selected_value[1]["id"] }}_delay"
             maxlength="3"
             size="4"
             style="height: 20px; text-align: center;"
             value="{% if selected_value[1]["delay"] %}{{ selected_value[1]["delay"] }}{% else %}0{% endif %}">
    </div>
    <div class="col-xs-1 text-center">
      <input type="text"
             name="{{ selected_value[1]["id"] }}_timeout"
             maxlength="3"
             size="4"
             style="height: 20px; text-align: center;"
             value="{% if selected_value[1]["timeout"] %}{{ selected_value[1]["timeout"] }}{% else %}20{% endif %}">
      </div>
    {% wire id=#delete
            action={remove target=#selected}
            action={show target="option_"++selected_value[1]["id"]}
    %} 
    <div class="col-xs-1 text-center">
      <a style="padding-left: 7px;">
        <i id="{{ #delete}}"
           style="cursor: pointer;"
           class="fa fa-trash-o"
           title="Delete"></i>
      </a>
    </div>
  </div>
</div>
{% javascript %}
    var SelectedJObj = JSON.parse($('#option_{{ selected_value[1]["id"] }}').val());
    $('#{{ #name }}').text(SelectedJObj['name']);
{% endjavascript %}
