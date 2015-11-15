<div id="{{ #list_entries_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#list_entries_edit template="_edit_list_entries_dialog.tpl" list_id=list_id} %}
  </div>
</div>
