<div min-height="50%">
  <ul class="nav nav-tabs nav-justified" role="tablist">
    <li id="li_failover_number_service" class="active"><a href="#failover_number_service" role="tab" data-toggle="tab">{_ Failover _}</a></li>
    {% wire id="li_failover_number_service"
            type="click"
            action={update target="number_services_div"
                           template="_edit_failover_number_service.tpl"
                           number=number
                           account_id=account_id}
            action={remove_class target="li_e911_number_service" class="active"}
            action={set_class target="li_failover_number_service" class="active"}
            action={remove_class target="li_prepend_number_service" class="active"}
            action={remove_class target="li_cname_number_service" class="active"}
    %}
    <li id="li_prepend_number_service"><a href="#prepend_number_service" role="tab" data-toggle="tab">{_ Prepend _}</a></li>
    {% wire id="li_prepend_number_service"
            type="click"
            action={update target="number_services_div"
                           template="_edit_prepend_number_service.tpl"
                           number=number
                           account_id=account_id}
            action={remove_class target="li_e911_number_service" class="active"}
            action={remove_class target="li_failover_number_service" class="active"}
            action={set_class target="li_prepend_number_service" class="active"}
            action={remove_class target="li_cname_number_service" class="active"}
    %}
    <li id="li_cname_number_service"><a href="#cname_number_service" role="tab" data-toggle="tab">{_ Caller ID _}</a></li>
    {% wire id="li_cname_number_service"
            type="click"
            action={update target="number_services_div"
                           template="_edit_cname_number_service.tpl"
                           number=number
                           account_id=account_id}
            action={remove_class target="li_e911_number_service" class="active"}
            action={remove_class target="li_failover_number_service" class="active"}
            action={remove_class target="li_prepend_number_service" class="active"}
            action={set_class target="li_cname_number_service" class="active"}
    %}
    {% if m.session.display_e911 %}
      <li id="li_e911_number_service">
        <a href="#e911_number_service" role="tab" data-toggle="tab">{_ E911 address _}</a>
      </li>
      {% wire id="li_e911_number_service"
              type="click"
              action={update target="number_services_div"
                             template="_edit_e911_number_service.tpl"
                             number=number
                             account_id=account_id}
              action={set_class target="li_e911_number_service" class="active"}
              action={remove_class target="li_failover_number_service" class="active"}
              action={remove_class target="li_prepend_number_service" class="active"}
              action={remove_class target="li_cname_number_service" class="active"}
      %}
    {% endif %}
  </ul>

  <div id="number_services_div">
    <span id="edit_number_service_initial_load" class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x"
                 action={replace target="edit_number_service_initial_load"
                                 template="_edit_failover_number_service.tpl"
                                 number=number
                                 account_id=account_id}
        %}
    </span>
  </div>
</div>
