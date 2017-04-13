{% wire id="button_cf_select_edit_kzuser"
        action={dialog_open title=_"Edit user"++" "++q.kz_element_name
                            template="_edit_user_lazy.tpl"
                            user_id=q.kz_element_id width="auto"
               }
%}
<button id="button_cf_select_edit_kzuser"
        class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Edit user _}</button>
