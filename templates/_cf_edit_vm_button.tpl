{% wire id="button_cf_select_edit_kzvmbox"
        action={dialog_open title=_"Edit voicemail"++" "++q.kz_element_name
                            template="_add_vm_dialog.tpl"
                            vmbox_id=q.kz_element_id
                            width="auto"
               }
%}
<button id="button_cf_select_edit_kzvmbox"
        class="col-xs-12 btn btn-zprimary margin-bottom-xs">
  {_ Edit voicemail _}
</button>
