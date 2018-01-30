<span id="reseller_current_call_info_lazy">
{% print uuid %}
{% print account_id %}
   <div class="text-center p-3">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={replace target="reseller_current_call_info_lazy"
                            template="reseller_current_call_info.tpl"
                            account_id=account_id
                            uuid=uuid
                            running_call=running_call
                    }
    %}
  </div>
</span>
