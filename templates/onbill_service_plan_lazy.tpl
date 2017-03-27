    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onbill_service_plan_widget_opened"
                                                                    template="onbill_service_plan_table.tpl"
                                                                    service_plan_id=q.service_plan_id}
        %}
    </div>
