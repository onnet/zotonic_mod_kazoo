<div class="row" style="padding: 1em; margin-bottom: 1em;">
  {% wire id="rs_account_reload_btn" action={update target="child_sandbox" template="reseller_child_info.tpl" account_id=account_id} %}
  <div class="col-xs-2 col-xs-offset-3">
    <button id="rs_account_reload_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Reload _}</button>
  </div>
  {% wire id="cf_details_btn" action={ dialog_open title=_"Account details" template="_account_details.tpl" account_id=account_id class="iamclass" width="auto" } %}
  <div class="col-xs-2">
    <button id="cf_details_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Details _}</button>
  </div>
  {% wire id="rs_account_delete_btn" action={confirm text="Do you really want to delete this account?"
                                     action={postback postback={rs_account_delete account_id=account_id} delegate="mod_kazoo"}
                             }
  %}
  <div class="col-xs-2">
    <button id="rs_account_delete_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Delete _}</button>
  </div>
</div>

<div class="pl-10 pr-10 col-md-6">
  <span id="rs_widget_account_details_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="rs_widget_account_details_tpl"
                                                                    template="rs_widget_account_details.tpl"
                                                                    dashboard
                                                                    account_id=account_id
                                                                    headline=_"Account details"}
        %}
      </div>
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_rs_allocated_numbers_tpl} action={update target="rs_allocated_numbers_tpl" template="rs_allocated_numbers.tpl" headline=_"Account's allocated numbers"}} %}
  <span id="rs_allocated_numbers_tpl">
        {% include "rs_allocated_numbers.tpl" headline=_"Account's allocated numbers" %}
  </span>
</div>
