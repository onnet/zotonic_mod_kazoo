<div id="{{ #trunk_edit }}">
  <div class="text-center">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target=#trunk_edit
                            template="_edit_trunk.tpl"
                            trunk_id=trunk_id
                            server_index=server_index
                    }
    %}
  </div>
</div>
