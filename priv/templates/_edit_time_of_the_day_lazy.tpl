<div id="{{ #time_of_the_day_edit }}">
  <div class="text-center">
    {% ilazy  class="fa fa-spinner fa-spin fa-3x" action={update target=#time_of_the_day_edit template="_add_time_of_the_day_dialog.tpl" rule_id=rule_id} %}
  </div>
</div>
