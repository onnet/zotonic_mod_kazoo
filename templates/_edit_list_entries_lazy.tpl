<div id="{{ #list_entries_edit }}">
  <div class="text-center">
    {% if list_type == "dynamic_cid" %}
      {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#list_entries_edit template="_edit_dynamic_cid_list_entries_dialog.tpl" list_id=list_id list_type=list_type} %}
    {% else %}
      {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#list_entries_edit template="_edit_list_entries_dialog.tpl" list_id=list_id list_type=list_type} %}
    {% endif %}
  </div>
</div>
