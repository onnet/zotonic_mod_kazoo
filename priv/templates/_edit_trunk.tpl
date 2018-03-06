<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li id="basic_li" class="active pointer">
    <a href="#tab_content" role="tab" data-toggle="tab">
      {_ Basic _}
    </a>
  </li>
  {% if trunk_id %}
    <li id="mediasettings_li">
      <a href="#tab_content" role="tab" data-toggle="tab">
        {_ Codecs _}
      </a>
    </li>
    <li id="tsnumbershandling_li">
      <a href="#tab_content" role="tab" data-toggle="tab">
        {_ Numbers handling _}
      </a>
    </li>
  {% endif %}
</ul>

{% wire id="basic_li"
        type="click"
        action={add_class class="active" target="basic_li"}
        action={remove_class class="active" target="tsnumbershandling_li"}
        action={remove_class class="active" target="mediasettings_li"}
        action={update target="tab_content"
                       template="_add_trunk_dialog.tpl"
                       trunk_id=trunk_id
                       server_index=server_index
               }
%}

{% wire id="mediasettings_li"
        type="click"
        action={add_class class="active" target="mediasettings_li"}
        action={remove_class class="active" target="tsnumbershandling_li"}
        action={remove_class class="active" target="basic_li"}
        action={update target="tab_content"
                       template="_trunkstore_media_settings.tpl"
                       trunk_id=trunk_id
                       server_index=server_index
               }
%}

{% wire id="tsnumbershandling_li"
        type="click"
        action={add_class class="active" target="tsnumbershandling_li"}
        action={remove_class class="active" target="mediasettings_li"}
        action={remove_class class="active" target="basic_li"}
        action={update target="tab_content"
                       template="_manage_trunk_numbers.tpl"
                       trunk_id=trunk_id
                       server_index=server_index
               }
%}

<div class="tab-content">
  <div class="active tab-pane fade in" id="tab_content">
    <div class="text-center">
      {% ilazy  class="fa fa-spinner fa-spin fa-3x"
                action={update target="tab_content"
                               template="_add_trunk_dialog.tpl"
                               trunk_id=trunk_id
                               server_index=server_index
                       }
      %}
    </div>
  </div>
</div>
</div>
