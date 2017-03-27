    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onbill_widget_invoices_tpl"
                                                                    template="onbill_widget_invoices.tpl"
                                                                    year=m.signal[signal].year
                                                                    month=m.signal[signal].month
                                                                    headline=_"Invoices"}
        %}
    </div>
