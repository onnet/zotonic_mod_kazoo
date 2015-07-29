<div id="{{ #conference_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#conference_edit template="_add_conference_dialog.tpl" conference_id=conference_id} %}
  </div>
</div>
