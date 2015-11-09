<div id="{{ #resource_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#resource_edit template="_edit_resource.tpl" resource_id=resource_id} %}
  </div>
</div>
