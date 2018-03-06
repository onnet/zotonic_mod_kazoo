<div id="{{ #user_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#user_edit template="_edit_user.tpl" user_id=user_id} %}
  </div>
</div>
