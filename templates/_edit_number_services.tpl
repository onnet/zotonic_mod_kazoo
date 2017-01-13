<div min-height="50%">
  <ul class="nav nav-tabs nav-justified" role="tablist">
    <li id="li_e911_number_service" class="active"><a href="#e911_number_service" role="tab" data-toggle="tab">{_ E911 address _}</a></li>
    {% wire id="li_e911_number_service"
            type="click"
            action={update target="number_services_div" template="_edit_e911_number_service.tpl" account_id=account_id}
            action={set_class target="li_e911_number_service" class="active"}
            action={remove_class target="li_failover_number_service" class="active"}
            action={remove_class target="li_prepend_number_service" class="active"}
    %}
    <li id="li_failover_number_service"><a href="#failover_number_service" role="tab" data-toggle="tab">{_ Failover _}</a></li>
    {% wire id="li_failover_number_service"
            type="click"
            action={update target="number_services_div" template="_edit_failover_number_service.tpl" account_id=account_id}
            action={remove_class target="li_e911_number_service" class="active"}
            action={set_class target="li_failover_number_service" class="active"}
            action={remove_class target="li_prepend_number_service" class="active"}
    %}
    <li id="li_prepend_number_service"><a href="#prepend_number_service" role="tab" data-toggle="tab">{_ Prepend _}</a></li>
    {% wire id="li_prepend_number_service"
            type="click"
            action={update target="number_services_div" template="_edit_prepend_number_service.tpl" account_id=account_id}
            action={remove_class target="li_e911_number_service" class="active"}
            action={remove_class target="li_failover_number_service" class="active"}
            action={set_class target="li_prepend_number_service" class="active"}
    %}
  </ul>

  <div id="number_services_div" class="1tab-content">
      {% include "_edit_e911_number_service.tpl" %}
  </div>
</div>
