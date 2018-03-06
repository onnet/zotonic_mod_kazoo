<span id="agents_status_dialog">
  <div class="text-center">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
             action={update target="agents_status_dialog"
                            template="_agents_status_dialog.tpl"
                            account_id=account_id
                    }
    %}
  </div>
</span>
