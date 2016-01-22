{% wire id="form_account_list_entries" type="submit" postback="account_list_entries" delegate="mod_kazoo" %}
<form id="form_account_list_entries" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-3">
          <input type="text" class="form-control margin-bottom-xs" id="list_entry_number" name="list_entry_number" placeholder="{_ Enter number here _}" value="">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="list_entry_displayname" name="list_entry_displayname" placeholder="{_ Enter description here _}" value="">
        </div>
        <div class="col-sm-3">
          {% button text=_"Add entry" class="col-xs-12 btn btn-zprimary margin-bottom-xs" action={submit target="form_account_list_entries"}
                                                                                          action={form_reset target="form_account_list_entries" } %}
        </div>
      </div>
    </div>
    <input type="hidden" name="list_id" value="{{ list_id }}" />
    <input type="hidden" name="list_type" value="{{ list_type }}" />
    <input type="hidden" name="template_name" value="_list_entries_dialog.tpl" />
</form>
  <div class="form-group">
    <div class="row">
      <div id="list_entries_div" class="col-sm-6 col-sm-offset-3">
          {% include "_list_entries_dialog.tpl" list_id=list_id %}
      </div>
    </div>
  </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          {% button text=_"Close" class="col-xs-12 btn btn-zprimary margin-bottom-xs" action={dialog_close} %}
        </div>
      </div>
    </div>
{# print m.kazoo[{kz_list_account_list_entries list_id=list_id}] #}
