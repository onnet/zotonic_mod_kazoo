<div id="{{ #queue_edit }}">
  <div class="text-center">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target=#queue_edit
                            template="_edit_queue.tpl"
                            queue_id=queue_id
                    }
    %}
  </div>
</div>
