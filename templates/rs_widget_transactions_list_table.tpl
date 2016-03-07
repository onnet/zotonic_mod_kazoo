<table class="table table-condensed table-centered">
    <thead>
        <tr><th colspan="2">Opening balance</th><th></th></tr>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    </thead>
</table>

{% include  "rs_widget_payments_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
    <thead>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    </thead>
</table>

{% include  "rs_widget_monthly_fees_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
    <thead>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    </thead>
</table>

{% include  "rs_widget_per_minute_calls_list_lazy.tpl" transactions=transactions %}
