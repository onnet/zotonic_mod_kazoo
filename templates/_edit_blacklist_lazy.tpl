<div id="{{ #blacklist_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x"
              action={update target=#blacklist_edit
                             template="_add_blacklist_dialog.tpl"
                             blacklist_id=blacklist_id
                     }
    %}
  </div>
</div>
