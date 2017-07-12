<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active"><a href="#basic" role="tab" data-toggle="tab">{_ Basic _}</a></li>
  {% if trunk_id %}
    <li><a href="#mediasettings" role="tab" data-toggle="tab">{_ Media _}</a></li>
    <li><a href="#tsnumbershandling" role="tab" data-toggle="tab">{_ Numbers handling _}</a></li>
  {% endif %}
</ul>

<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="basic">
    <div class="text-center">
      {% ilazy  class="fa fa-spinner fa-spin fa-3x"
                action={update target="basic"
                               template="_add_trunk_dialog.tpl"
                               trunk_id=trunk_id
                               server_index=server_index
                       }
      %}
    </div>
  </div>
  <!-- Media Settings -->
  <div class="tab-pane fade" id="mediasettings">
    <div class="text-center">
      {% ilazy  class="fa fa-spinner fa-spin fa-3x"
                action={update target="mediasettings"
                               template="_trunkstore_media_settings.tpl"
                               trunk_id=trunk_id
                               server_index=server_index
                       }
      %}
    </div>
  </div>
  <!-- Numbers handling -->
  <div class="tab-pane fade" id="tsnumbershandling">
    <div class="text-center">
      {% ilazy  class="fa fa-spinner fa-spin fa-3x"
                action={update target="tsnumbershandling"
                               template="_manage_trunk_numbers.tpl"
                               trunk_id=trunk_id
                               server_index=server_index
                       }
      %}
    </div>
  </div>
</div>
</div>
