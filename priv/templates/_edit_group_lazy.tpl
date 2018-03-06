<div id="{{ #group_edit }}">
  <div class="text-center">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target=#group_edit template="_edit_group.tpl"
                                               group_id=group_id
                    }
    %}
  </div>
</div>
