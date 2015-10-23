-module(mod_kazoo).
-author("kirill.sysoev@gmail.com").

-mod_title("Kazoo UI").
-mod_description("Zotonic Kazoo user interface module").
-mod_prio(5).

-export([
     observe_search_query/2
    ,observe_postback_notify/2
    ,event/2
]).


-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

observe_search_query(_, _) ->
    'undefined'.

observe_postback_notify({postback_notify, "no_auth",_,_,_}, Context) ->
    lager:info("Catched postback notify: no_auth"),
    {ok, Context1} = z_session_manager:stop_session(Context),
    z_render:wire({redirect, [{dispatch, "home"}]}, Context1);

observe_postback_notify(A, _Context) ->
    lager:info("Catched postback notify: ~p", [A]),
    undefined.

event({submit,{innoauth,[]},"sign_in_form","sign_in_form"}, Context) ->
    Login = z_convert:to_binary(z_context:get_q("username",Context)),
    Password = z_convert:to_binary(z_context:get_q("password",Context)),
    Account = z_convert:to_binary(z_context:get_q("account",Context)),
    modkazoo_auth:do_sign_in(Login, Password, Account, Context);

event({submit,{innoauth,[]},"sign_in_page_form","sign_in_page_form"}, Context) ->
    Login = z_convert:to_binary(z_context:get_q("username_page",Context)),
    Password = z_convert:to_binary(z_context:get_q("password_page",Context)),
    Account = z_convert:to_binary(z_context:get_q("account_page",Context)),
    modkazoo_auth:do_sign_in(Login, Password, Account, Context);

event({postback,{signout,[]}, _, _}, Context) ->
    modkazoo_auth:signout(Context);

event({submit,{innosignup,[]},"sign_up_form","sign_up_form"}, Context) ->
    try
      'ok' = modkazoo_util:check_field_filled("firstname",Context),
      'ok' = modkazoo_util:check_field_filled("surname",Context),
      'ok' = modkazoo_util:check_field_filled("username",Context),
      'ok' = modkazoo_util:check_field_filled("email",Context),
      'ok' = modkazoo_util:check_field_filled("phonenumber",Context),
      Email = z_context:get_q_all("email",Context),
      {{ok, _}, _} = validator_base_format:validate(format, 1, z_context:get_q_all("phonenumber",Context), [false,"^[-+0-9 ()]+$"], Context),
      {{ok, _}, _} = validator_base_email:validate(email, 2, Email, [], Context),
      case z_context:get_q_all("username",Context) of
          Email -> 'ok';
          _ -> throw({'error', 'emails_not_equal'})
      end,
      "on" = z_context:get_q("checkbox",Context),
      case modkazoo_auth:gcapture_check(Context) of
          'true' -> modkazoo_auth:process_signup_form(Context);
          'false' -> z_render:growl_error(?__("Are you robot?", Context), Context)
      end
    catch
      error:{badmatch,{{error, 1, invalid}, _}} -> z_render:growl_error(?__("Incorrect Contact phone field",Context), Context);
      error:{badmatch,{{error, 2, invalid}, _}} -> z_render:growl_error(?__("Incorrect Email field",Context), Context);
      error:{badmatch, []} -> z_render:growl_error(?__("Please accept our Terms of Service and Privacy Policy",Context), Context);
      error:{badmatch, _} -> z_render:growl_error(?__("All fields should be filled in",Context), Context);
      throw:{error,emails_not_equal} -> z_render:growl_error(?__("Entered emails should be equal",Context), Context);
      E1:E2 ->
          lager:info("Err ~p:~p", [E1, E2]), 
          z_render:growl_error(?__("All fields should be correctly filled in",Context), Context)
    end;

event({submit,{kazoo_user_settings,[]},"user_settings_form_form","user_settings_form_form"}, Context) ->
    kazoo_util:update_kazoo_user(Context);

event({postback,{set_vm_message_folder,[{folder, Folder}, {vmbox_id,VMBoxId}, {media_id,MediaId}]}, _, _}, Context) ->
    kazoo_util:set_vm_message_folder(Folder, VMBoxId, MediaId, Context),
    Context;

event({postback,{delete_vm_message,[{vmbox_id,VMBoxId}, {media_id,MediaId}]}, _, _}, Context) ->
    kazoo_util:set_vm_message_folder(<<"deleted">>, VMBoxId, MediaId, Context),
    z_render:update("user_portal_voicemails", z_template:render("user_portal_voicemails.tpl", [{headline,?__("Voicemails", Context)}], Context), Context);

event({submit,{forgottenpwd,[]},"forgottenpwd_form","forgottenpwd_form"}, Context) ->
    Username = z_convert:to_binary(z_context:get_q("forgotten_username",Context)),
    NumberOrName = modkazoo_util:normalize_account_name(z_context:get_q("forgotten_account_name",Context)),
    AccountName = case kazoo_util:kz_admin_find_accountname_by_number(NumberOrName, Context) of
        'undefined' -> NumberOrName;
         NameFound -> NameFound
    end,
    case kazoo_util:password_recovery(Username, AccountName, Context) of
        <<"">> -> z_render:growl_error(?__("No account found",Context), Context);
        Answer -> 
            lager:info("Password recovery request answer: ~p",[Answer]),
            Context1 = z_render:wire([{set_class, [{target, "forgot-pwd-box"},{class,"search-box hidden"}]}], Context),
            z_render:growl(?__("Please check your mailbox", Context1), Context1)
    end;

event({submit,{forgottenpwd,[]},"password_recovery_page_form","password_recovery_page_form"}, Context) ->
    Username = z_convert:to_binary(z_context:get_q("forgotten_username_page",Context)),
    AccountName = z_convert:to_binary(z_context:get_q("forgotten_account_name_page",Context)),
    case kazoo_util:password_recovery(Username, AccountName, Context) of
        <<"">> -> z_render:growl_error(?__("The provided account name could not be found",Context), Context);
        Answer -> z_render:growl(?__(Answer, Context), Context)
    end;

event({postback,rate_seek,_,_}, Context) ->
    Number = z_convert:to_binary(re:replace(z_context:get_q("rate_seek",Context), "[^0-9]", "", [global, {return, list}])),
    case kazoo_util:rate_number(Number, Context) of
        {'ok', PriceInfo} -> z_render:update("single_number_rate", z_template:render("_single_number_rate.tpl", [{priceinfo, PriceInfo}], Context), Context);
        _ -> z_render:growl_error(?__("Wrong number provided, please try again.",Context), Context)
    end;

event({submit, send_fax, _, _}, Context) ->
  try
    case z_context:get_q("fax_number", Context) of
        [] ->
               FaxTo = <<"">>,     
               throw(no_number_entered);
        FaxToStr ->
               FaxTo = z_convert:to_binary(FaxToStr)
    end,
    FaxFrom = z_convert:to_binary(z_context:get_q("fax_from", Context)),
    Attempts = z_convert:to_binary(z_context:get_q("attempts", Context)),

    case z_context:get_q("faxfile", Context) of
        {upload, _FaxUploadFilename, FaxUploadTmp, _, _} ->
            false = modkazoo_util:check_file_size_exceeded(faxfile, FaxUploadTmp, 15000000),
            {ok, FaxData} = file:read_file(FaxUploadTmp),
            {ok, FaxIdnProps} = z_media_identify:identify(FaxUploadTmp, Context),
            FaxMime = proplists:get_value(mime, FaxIdnProps),
            [_, Ext] = filename:split(FaxMime),
            AccountId = z_context:get_session('kazoo_account_id', Context),
            DocName = <<<<"faxout-">>/binary, AccountId/binary, <<"-">>/binary,
                        (z_convert:to_binary(string:to_lower(lists:flatten([io_lib:format("~2.16.0B", [H]) ||
                                        H <- z_convert:to_list(base64:encode(crypto:strong_rand_bytes(8)))]))))/binary>>,
            FileName = z_convert:to_binary(io_lib:format("~s.~s", [DocName, Ext])),
            _ = file:write_file(<<<<"/tmp/">>/binary, FileName/binary>>, FaxData),
            AttachmentUrl = <<<<"https://">>/binary, (z_convert:to_binary(z_dispatcher:hostname(Context)))/binary, <<"/getfaxdoc/id/">>/binary, FileName/binary>>,
            FaxHeader = case z_context:get_q("company_name_checkbox", Context) of
                            "checked" -> z_context:get_session('kazoo_account_name', Context);
                            _ -> <<"Fax Service https://onnet.info">>
                        end,
            kazoo_util:kz_send_fax(AccountId, FaxTo, FaxFrom, AttachmentUrl, Attempts, FaxHeader, Context),
            z_render:update("send-fax-tbody", z_template:render("_send_fax_tbody.tpl", [], Context), Context);
        _ ->
            throw(no_document_uploaded)
    end
  catch
    no_number_entered -> z_render:growl_error(?__("No number entered",Context), Context);
    no_document_uploaded -> z_render:growl_error(?__("No document chosen",Context), Context);
    error:{badmatch, {true, faxfile}} -> z_render:growl_error(?__("Maximum file size exceeded. Please try to upload smaller file.",Context), Context);
    E1:E2 -> 
        lager:info("Error. E1: ~p E2: ~p", [E1, E2]),
        z_render:growl_error(?__("Something wrong happened.",Context), Context)

  end;

event({postback,kazoo_transaction,_,_}, Context) ->
    case z_convert:to_float(z_context:get_q("kazoo_transaction", Context)) of
        Amount when Amount >= 10, Amount =< 200 ->
            JObj = kazoo_util:make_payment(Amount, z_context:get_session('kazoo_account_id', Context), Context),
            case modkazoo_util:get_value([<<"bookkeeper_info">>,<<"status">>], JObj) of
                <<"submitted_for_settlement">> ->
                    Context1 = z_render:growl(?__("£"++z_convert:to_list(Amount)++" successfully added.",Context), Context),
                    Context2 = z_render:update("onnet_widget_finance_tpl"
                                     ,z_template:render("onnet_widget_finance.tpl", [{cat, "text"}, {headline, "Account"}], Context1), Context1),
                    Context3 = z_render:update("onnet_widget_make_payment_tpl" ,z_template:render("onnet_widget_make_payment.tpl", [{cat, "text"}, 
                                                        {headline, "Online payments"}, {bt_customer, kazoo_util:kz_bt_customer(Context2)}], Context2), Context2),
                    z_render:update("onnet_widget_payments_list_tpl"
                                     ,z_template:render("onnet_widget_payments_list.tpl", [{headline, "Payments list"}], Context3), Context3);
                E ->
                    z_render:growl_error(?__("Something went wrong Response code: "++z_convert:to_list(E), Context), Context)
            end;
        _ -> 
            Context1 = z_render:growl_error(?__("Payment failed!<br />Please input correct amount.", Context), Context),
            z_render:update("onnet_widget_make_payment_tpl" ,z_template:render("onnet_widget_make_payment.tpl", [{cat, "text"}, 
                             {headline, "Online payments"}, {bt_customer, kazoo_util:kz_bt_customer(Context1)}], Context1), Context1)
    end;

event({postback,{bt_delete_card,[{card_id,CardId}]},_,_}, Context) ->
    kazoo_util:bt_delete_card(CardId, Context),
    z_render:update("cards_list_body", z_template:render("_make_payment_cards_list.tpl", [{bt_customer, kazoo_util:kz_bt_customer(Context)}], Context), Context);

event({postback,{bt_make_default_card,[{card_id,CardId}]},_,_}, Context) ->
    bt_util:bt_make_default_card(CardId, Context),
    z_render:update("cards_list_body", z_template:render("_make_payment_cards_list.tpl", [{bt_customer, kazoo_util:kz_bt_customer(Context)}], Context), Context);

event({submit,add_card,"add_card_form","add_card_form"}, Context) ->
    case z_context:get_q("payment_method_nonce", Context) of
        'undefined' -> Context;
        [] -> Context;
        _ -> 
            case bt_util:bt_card_add(Context) of
                "success" -> 
                    Context1 = z_render:growl(?__("Card successfully added.",Context), Context),
                    z_render:update("make_payment_manage_cards_tpl"
                                     ,z_template:render("_make_payment_manage_cards.tpl", [{bt_customer, kazoo_util:kz_bt_customer(Context1)}], Context1), Context1);
                E ->
                    Context1 = z_render:growl_error(?__(E, Context), Context),
                    z_render:update("onnet_widget_make_payment_tpl"
                                     ,z_template:render("onnet_widget_make_payment.tpl", [{bt_customer, kazoo_util:kz_bt_customer(Context1)}], Context1), Context1)
            end
    end;

event({postback,topup_submit_btn,_,_},Context) ->
    kazoo_util:topup_submit(z_context:get_q("threshold", Context)
                           ,z_context:get_q("amount", Context)
                           ,z_context:get_session('kazoo_account_id', Context)
                           ,Context),
    z_render:update("make_payment_topup_settings_tpl", z_template:render("_make_payment_topup_settings.tpl", [], Context), Context);

event({postback,topup_disable_btn,_,_},Context) ->
    kazoo_util:topup_disable(z_context:get_session('kazoo_account_id', Context),Context),
    z_render:update("make_payment_topup_settings_tpl", z_template:render("_make_payment_topup_settings.tpl", [], Context), Context);

event({postback,{trigger_innoui_widget,[{arg,WidgetId}]},_,_}, Context) ->
    kazoo_util:trigger_innoui_widget(WidgetId, Context),
    Context;

event({postback,invoiceme,TriggerId,_},Context) ->
  try z_convert:to_float(z_context:get_q("invoice_amount",Context)) of
      'undefined' ->
          Context1 = z_render:update("onnet_widget_make_invoice_tpl", z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context), Context),
          z_render:growl_error(?__("Please input correct amount of funds you'd like to transfer.", Context1), Context1);
      InvoiceAmount when InvoiceAmount =< 0 ->
          Context1 = z_render:update("onnet_widget_make_invoice_tpl", z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context), Context),
          z_render:growl_error(?__("Please input correct amount of funds you'd like to transfer.", Context1), Context1);
      InvoiceAmount when InvoiceAmount > 0 ->
         case TriggerId of
             "email_invoice" -> 
                 case modkazoo_notify:send_invoice(InvoiceAmount,Context) of
                     {'ok',_} ->
                         Context1 = z_render:update("onnet_widget_make_invoice_tpl"
                                                   ,z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context)
                                                   ,Context),
                         z_render:growl(?__("Invoice successfully sent to ", Context1)++z_convert:to_list(kazoo_util:kz_user_doc_field(<<"email">>, Context1)), Context1);
                     _ -> 
                         Context1 = z_render:update("onnet_widget_make_invoice_tpl"
                                                   ,z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context)
                                                   ,Context),
                         z_render:growl_error(?__("Please input integer number.", Context1), Context1)
                 end;
             "download_invoice" -> 
                 Context
         end
  catch
      _:_ ->
          Context1 = z_render:update("onnet_widget_make_invoice_tpl"
                                     ,z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context)
                                     ,Context),
          z_render:growl_error(?__("Please input correct amount of funds you'd like to transfer.", Context1), Context1)
  end;

event({submit,set_accounts_address,_,_}, Context) ->
    Line1 = z_convert:to_binary(z_context:get_q("line1",Context)),
    Line2 = z_convert:to_binary(z_context:get_q("line2",Context)),
    Line3 = z_convert:to_binary(z_context:get_q("line3",Context)),
    kazoo_util:set_accounts_address(Line1, Line2, Line3, Context),
    z_render:growl(?__("Address successfully updated.", Context), Context);

event({postback,new_numbers_lookup,_,_}, Context) ->
    AreaCode = case z_convert:to_binary(z_context:get_q("areacode",Context)) of
        <<"0", Number/binary>> -> Number;
        Number -> Number
    end,
    lager:info("AreaCode lookup attempt: ~p",[AreaCode]),
    FreeNumbers = kazoo_util:lookup_numbers(AreaCode, Context),
    z_render:update("numbers_to_choose",z_template:render("_numbers_lookup.tpl", [{free_numbers, FreeNumbers}], Context),Context);

event({postback,{rs_add_number,[{account_id,AccountId}]},_,_}, Context) ->
    case z_context:get_q("new_number_to_add",Context) of
        'undefined' -> z_render:growl_error(?__("Something wrong happened.", Context), Context);
        NumberToAdd -> 
            _ = kazoo_util:rs_add_number(NumberToAdd, AccountId, Context),
            lager:info("Number add attempt: ~p",[NumberToAdd]),
            {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
            Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
                   ,{login_name, z_context:get_session('kazoo_login_name', Context)}
                   ,{clientip, ClientIP}
                   ,{number, NumberToAdd}],
            spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_number_purchase.tpl", Vars, Context]),
            mod_signal:emit({update_rs_allocated_numbers_tpl, [{account_id,AccountId}]}, Context),
            Context
    end;

event({postback,{allocate_number,[{number,Number}]},_,_}, Context) ->
    lager:info("Number purchase attempt: ~p",[Number]),
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{clientip, ClientIP}
           ,{number, Number}],
    case kazoo_util:is_creditable(Context) of
        'true' ->
            spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_number_purchase.tpl", Vars, Context]),
            kazoo_util:process_purchase_number(Number, Context);
        'false' -> 
            spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_number_purchase.tpl", [{'not_creditable','true'}|Vars], Context]),
            Context1 = z_render:update("onnet_widget_order_additional_number_tpl" ,z_template:render("onnet_widget_order_additional_number.tpl", [], Context),Context),
            z_render:growl_error(?__("Please add Credit Card or top-up account balance first.", Context1), Context1)
    end;

event({postback,{deallocate_number,[{number,Number}]},_,_}, Context) ->
    lager:info("Number deallocation attempt: ~p",[Number]),
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{clientip, ClientIP}
           ,{number, Number}],
    spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_deallocate_number.tpl", Vars, Context]),
    case kazoo_util:deallocate_number(Number, Context) of
        <<>> ->
            Context1 = z_render:update("onnet_allocated_numbers_tpl" ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], Context),Context),
            Context2 = z_render:update("onnet_widget_monthly_fees_tpl" ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current month services"}], Context1),Context1),
            z_render:growl_error(?__("Something wrong happened.", Context2), Context2);
        _ -> 
            Context1 = z_render:update("onnet_allocated_numbers_tpl" ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], Context),Context),
            Context2 = z_render:update("onnet_widget_monthly_fees_tpl" ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current month services"}], Context1),Context1),
            z_render:growl(?__("Number ", Context2)++z_convert:to_list(Number)++?__(" successfully removed.", Context2), Context2)
    end;

event({postback,{deallocate_number,[{number,Number},{account_id, AccountId}]},_,_}, Context) ->
    lager:info("Number deallocation attempt: ~p",[Number]),
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{clientip, ClientIP}
           ,{number, Number}],
    spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_deallocate_number.tpl", Vars, Context]),
    case kazoo_util:deallocate_number(Number, AccountId, Context) of
        <<>> ->
            Context1 = z_render:update("rs_numbers_list_table" ,z_template:render("rs_numbers_list_table_body.tpl", [{account_id, AccountId}], Context),Context),
            z_render:growl_error(?__("Something wrong happened.", Context1), Context1);
        _ -> 
            Context1 = z_render:update("rs_numbers_list_widget_opened" ,z_template:render("rs_numbers_list_table_body.tpl", [{account_id, AccountId}], Context),Context),
            z_render:growl(?__("Number ", Context1)++z_convert:to_list(Number)++?__(" successfully removed.", Context1), Context1)
    end;

event({submit,{start_webphone_form,[]},_,_}, Context) ->
    DeviceId = z_context:get_q("webrtc_device",Context),
    DeviceDoc = kazoo_util:kz_get_device_doc(DeviceId, Context),
    z_context:set_session('webrtc_dev_id', modkazoo_util:get_value(<<"id">>,DeviceDoc), Context),
    z_context:set_session('webrtc_dev_name', modkazoo_util:get_value(<<"name">>,DeviceDoc), Context),
    z_context:set_session('webrtc_dev_sip_username', modkazoo_util:get_value([<<"sip">>,<<"username">>],DeviceDoc), Context),
    z_context:set_session('webrtc_dev_sip_password', modkazoo_util:get_value([<<"sip">>,<<"password">>],DeviceDoc), Context),
    z_render:update("webphone_widget" ,z_template:render("user_portal_phone.tpl", [{devicedoc, DeviceDoc}], Context),Context);

event({postback,{delete_incoming_fax,[{fax_id, FaxId}]},_,_}, Context) ->
    _ = kazoo_util:kz_incoming_fax_delete(FaxId, Context),
    z_render:update("user_portal_faxes_incoming", z_template:render("user_portal_faxes_incoming.tpl", [{headline,?__("Incoming faxes", Context)}], Context), Context);

event({postback,{toggle_field,[{type,Type},{doc_id,DocId},{field_name, FieldName}]},_,_}, Context) ->
    case Type of
        "user" ->
            _ = kazoo_util:kz_toggle_user_doc(FieldName, DocId, Context),
            z_render:update(FieldName, z_template:render("_show_field_checkbox.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context);
        "device" ->
            _ = kazoo_util:kz_toggle_device_doc(FieldName, DocId, Context),
            z_render:update(FieldName, z_template:render("_show_field_checkbox.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context)
    end;

event({submit,passwordForm,_,_}, Context) ->
    _ = kazoo_util:kz_set_user_doc(<<"password">>, z_convert:to_binary(z_context:get_q("password1", Context)), z_convert:to_binary(z_context:get_q("chpwd_user_id", Context)), Context),
    z_render:growl(?__("Password changed", Context), Context);

event({postback,{delete_user,[{user_id,UserId}]},_,_}, Context) ->
    _ = kazoo_util:delete_user(UserId, Context),
    mod_signal:emit({update_admin_portal_users_list_tpl, []}, Context),
    Context;
event({postback,{delete_device,[{device_id,DeviceId}]},_,_}, Context) ->
    _ = kazoo_util:delete_device(DeviceId, Context),
    mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
    Context;

event({postback,{enable_doc,[{type,Type},{doc_id,DocId},{field_name,Field}]},_,_}, Context) ->
    case Type of
        "user" ->
            _ = kazoo_util:kz_set_user_doc(Field, 'true', DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, []}, Context),
            Context1 = z_render:update("user_enabled_status", z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context), Context),
            z_render:update("user_enable_control", z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1), Context1);
        "device" ->
            _ = kazoo_util:kz_set_device_doc(Field, 'true', DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
            Context1 = z_render:update("device_enabled_status", z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context), Context),
            z_render:update("device_enable_control", z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1), Context1)
    end;

event({postback,{disable_doc,[{type,Type},{doc_id,DocId},{field_name,Field}]},_,_}, Context) ->
    case Type of
        "user" ->
            _ = kazoo_util:kz_set_user_doc(Field, 'false', DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, []}, Context),
            Context1 = z_render:update("user_enabled_status", z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context), Context),
            z_render:update("user_enable_control", z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1), Context1);
        "device" ->
            _ = kazoo_util:kz_set_device_doc(Field, 'false', DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
            Context1 = z_render:update("device_enabled_status", z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context), Context),
            z_render:update("device_enable_control", z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1), Context1)
    end;

event({submit,add_new_user_form,_,_}, Context) ->
    try
      'ok' = modkazoo_util:check_field_filled("firstname",Context),
      'ok' = modkazoo_util:check_field_filled("surname",Context),
      'ok' = modkazoo_util:check_field_filled("username",Context),
      'ok' = modkazoo_util:check_field_filled("email",Context),
      Email = z_context:get_q_all("email",Context),
      {{ok, _}, _} = validator_base_email:validate(email, 2, Email, [], Context),
      case z_context:get_q_all("username",Context) of
          Email -> 'ok';
          _ -> throw({'error', 'emails_not_equal'})
      end,
      kazoo_util:create_kazoo_user(Email
                       ,modkazoo_util:rand_hex_binary(10)
                       ,z_convert:to_binary(z_context:get_q("firstname", Context))
                       ,z_convert:to_binary(z_context:get_q("surname", Context))
                       ,z_convert:to_binary(Email)
                       ,'undefined'
                       ,<<"user">>
                       ,z_context:get_session('kazoo_account_id', Context)
                       ,Context),
      mod_signal:emit({update_admin_portal_users_list_tpl, []}, Context),
      z_render:dialog_close(Context)
    catch
      error:{badmatch,{{error, 2, invalid}, _}} -> z_render:growl_error(?__("Incorrect Email field",Context), Context);
      error:{badmatch, _} -> z_render:growl_error(?__("All fields should be filled in",Context), Context);
      throw:{error,emails_not_equal} -> z_render:growl_error(?__("Entered emails should be equal",Context), Context);
      E1:E2 ->
          lager:info("Err ~p:~p", [E1, E2]),
          z_render:growl_error(?__("All fields should be correctly filled in",Context), Context)
    end;

event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName}]},_,_}, Context) ->
    event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, z_context:get_session('kazoo_account_id', Context)}]},'dont_care','dont_care'}, Context);

event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, 'undefined'}]},_,_}, Context) ->
    event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, z_context:get_session('kazoo_account_id', Context)}]},'dont_care','dont_care'}, Context);

event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, AccountId}]},_,_}, Context) ->
    case Type of
        "account" ->
            _ = kazoo_util:kz_set_acc_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), AccountId, Context),
            z_render:update(FieldName, z_template:render("_show_field.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName},{account_id, AccountId}], Context), Context);
        "user" ->
            _ = kazoo_util:kz_set_user_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, []}, Context),
            z_render:update(FieldName, z_template:render("_show_field.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context);
        "device" ->
            _ = kazoo_util:kz_set_device_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
            z_render:update(FieldName, z_template:render("_show_field.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context)
    end;

event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options}]},_,_}, Context) ->
    event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options},{prefix,""},{postfix,""}]},"",""}, Context);


event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options},{prefix,RawPrefix},{postfix,RawPostfix}]},_,_}, Context) ->
    event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options},{prefix,RawPrefix}
                                       ,{postfix,RawPostfix},{account_id,z_context:get_session('kazoo_account_id', Context)}]},'dont_care','dont_care'}, Context);

event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options},{prefix,RawPrefix},{postfix,RawPostfix},{account_id,'undefined'}]},_,_}, Context) ->
    event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options},{prefix,RawPrefix}
                                       ,{postfix,RawPostfix},{account_id,z_context:get_session('kazoo_account_id', Context)}]},'dont_care','dont_care'}, Context);

event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options},{prefix,RawPrefix},{postfix,RawPostfix},{account_id,AccountId}]},_,_}, Context) ->
    Prefix = case RawPrefix of
        'undefined' -> "";
        Pre -> Pre
    end,
    Postfix = case RawPostfix of
        'undefined' -> "";
        Post -> Post
    end,
    case Type of
        "account" ->
            _ = kazoo_util:kz_set_acc_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), AccountId, Context),
            z_render:update(Prefix++FieldName, z_template:render("_show_field_select.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}
                                                                                           ,{options,Options},{prefix,Prefix},{postfix,Postfix},{account_id, AccountId}], Context), Context);
        "user" ->
            _ = kazoo_util:kz_set_user_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, []}, Context),
            z_render:update(Prefix++FieldName, z_template:render("_show_field_select.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}
                                                                                           ,{options,Options},{prefix,Prefix},{postfix,Postfix}], Context), Context);
        "device" ->
            InputValue = case z_context:get_q("input_value", Context) of
                [] -> 'undefined';
                Val -> z_convert:to_binary(Val)
            end,
            _ = kazoo_util:kz_set_device_doc(FieldName, InputValue, DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
            z_render:update(Prefix++FieldName, z_template:render("_show_field_select.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}
                                                                                           ,{options,Options},{prefix,Prefix},{postfix,Postfix}], Context), Context)
    end;

event({submit,add_new_device,_,_}, Context) ->
    _ = kazoo_util:add_device(Context),
    mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({submit,add_new_group,_,_}, Context) ->
    case z_context:get_q("name",Context) of
        [] -> z_render:growl_error(?__("Please input group name.", Context), Context);
        _ ->
            _ = kazoo_util:add_group(Context),
            mod_signal:emit({update_admin_portal_groups_list_tpl, []}, Context),
            z_render:dialog_close(Context)
    end;

event({submit,edit_group,_,_}, Context) ->
    case z_context:get_q("name",Context) of
        [] -> z_render:growl_error(?__("Please input group name.", Context), Context);
        _ ->
            _ = kazoo_util:modify_group(Context),
            mod_signal:emit({update_admin_portal_groups_list_tpl, []}, Context),
            z_render:dialog_close(Context)
    end;

event({postback,{delete_group,[{group_id,GroupId}]},_,_}, Context) ->
    _ = kazoo_util:delete_group(GroupId, Context),
    mod_signal:emit({update_admin_portal_groups_list_tpl, []}, Context),
    Context;

event({drop,_,_}=A,Context) ->
    try
        lager:info("Drop A: ~p",[A]),
        kazoo_util:cf_handle_drop(A,Context)
    catch
      _E1:_E2 -> 'ok'
    end;

event({submit,cf_add_number,_,_},Context) ->
    case z_context:get_q("new_number", Context) of
        'undefined' -> 'ok';
        Num ->
            case re:replace(Num, " ", "", [global, {return, binary}]) of
                <<>> -> 'ok';
                Number -> 
                    _ = kazoo_util:cf_add_number(Number,Context)
            end
    end,
    case z_context:get_q("new_pattern", Context) of
        'undefined' -> 'ok';
        Patt ->
            case re:replace(Patt, " ", "", [global, {return, binary}]) of
                <<>> -> 'ok';
                Pattern -> 
                    _ = kazoo_util:cf_add_pattern(Pattern,Context)
            end
    end,
    mod_signal:emit({update_cf_numbers_div, []}, Context),
    z_render:dialog_close(Context);

event({postback,{cf_delete_number,[{number,Number}]},_,_}, Context) ->
    _ = kazoo_util:cf_delete_number(Number, Context),
    mod_signal:emit({update_cf_numbers_div, []}, Context);

event({submit,cf_edit_name,_,_},Context) ->
    _ = kazoo_util:cf_edit_name(z_context:get_q("callflow_name", Context),Context),
    _ = kazoo_util:cf_contact_list_exclude(z_context:get_q("callflow_exclude", Context),Context),
    mod_signal:emit({update_cf_edit_name, []}, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_user,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","timeout"], z_convert:to_binary(z_context:get_q("timeout", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","can_call_self"], true, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_device,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","timeout"], z_convert:to_binary(z_context:get_q("timeout", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","can_call_self"], true, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_play,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_voicemail,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_callflow,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_record_call,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","action"], <<"start">>, Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","url"], <<>>, Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","format"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","time_limit"], <<"6000">>, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_group_pickup,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    PickupType = z_context:get_q("pickup_type", Context)++"_id",
    Selected = jiffy:decode(z_context:get_q("selected", Context)),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data",PickupType], modkazoo_util:get_value(<<"id">>,Selected), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","name"], modkazoo_util:get_value(<<"name">>,Selected), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_receive_fax,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","owner_id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","media","fax_option"], modkazoo_util:on_to_true(z_context:get_q("t_38_checkbox", Context)), Context),
    z_render:dialog_close(Context);

event({postback,{cf_save,[{cf,"current_callflow"}]},_,_},Context) ->
    kazoo_util:cf_save('current_callflow', Context);

event({postback,{cf_delete,[{cf,"current_callflow"}]},_,_},Context) ->
    kazoo_util:cf_delete('current_callflow', Context),
    mod_signal:emit({update_cf_builder_area, []}, Context);

event({postback,{cf_ring_group_select,[{element_type,ElementType}]},_,_},Context) ->
    Selected = jiffy:decode(z_context:get_q("triggervalue", Context)),
    Context1 = z_render:insert_bottom("sorter",z_template:render("_cf_select_ring_group_element.tpl",[{selected_value,Selected},{element_type,ElementType}],Context),Context),
    z_render:wire([{hide, [{target, "option_"++z_convert:to_list(modkazoo_util:get_value(<<"id">>,Selected))}]}], Context1);

event({submit,cf_select_ring_group,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","name"], z_convert:to_binary(z_context:get_q("name", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","strategy"], z_convert:to_binary(z_context:get_q("strategy", Context)), Context),
    _ = case z_convert:to_binary(z_context:get_q("ringback", Context)) of
        <<>> -> modkazoo_util:delete_session_jobj_key('current_callflow', z_string:split(ElementId,"-")++["data","ringback"], Context);
        Ringback -> kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","ringback"], Ringback, Context)
    end,
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","endpoints"], kazoo_util:cf_build_ring_group_endpoints(Context), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","timeout"], kazoo_util:cf_calculate_ring_group_timeout(Context), Context),
    z_render:dialog_close(Context);

event({postback,{cf_page_group_select,[{element_type,ElementType}]},_,_},Context) ->
    Selected = jiffy:decode(z_context:get_q("triggervalue", Context)),
    Context1 = z_render:insert_bottom("sorter",z_template:render("_cf_select_page_group_element.tpl",[{selected_value,Selected},{element_type,ElementType}],Context),Context),
    z_render:wire([{hide, [{target, "option_"++z_convert:to_list(modkazoo_util:get_value(<<"id">>,Selected))}]}], Context1);

event({submit,cf_select_page_group,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","name"], z_convert:to_binary(z_context:get_q("name", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","endpoints"], kazoo_util:cf_build_page_group_endpoints(Context), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_menu,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_temporal_route,_,_}, Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","timezone"], z_convert:to_binary(z_context:get_q("selected", Context)), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_cid_check,_,_}, Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = case modkazoo_util:get_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>], z_context:get_session('current_callflow', Context), ?EMPTY_JSON_OBJECT) of
            ?EMPTY_JSON_OBJECT -> 'ok';
            _ -> kazoo_util:may_be_cid_check_children_clean(Context)
        end,
    _ = kazoo_util:cf_set_session('current_callflow', modkazoo_util:split_b(ElementId,"-")++["data","use_absolute_mode"], z_convert:to_atom(z_context:get_q("selected", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', modkazoo_util:split_b(ElementId,"-")++["data","regex"], z_convert:to_binary(z_context:get_q("regex", Context)), Context),
    z_render:dialog_close(Context);

event({submit,cf_select_option,_,_},Context) ->
    lager:info("Existing_Element_id: ~p",[z_context:get_q("existing_element_id", Context)]),
    case z_context:get_q("existing_element_id", Context) of
        [] ->
            kazoo_util:cf_child([{tool_name,z_context:get_q("tool_name", Context)}
                                ,{drop_id,z_context:get_q("drop_id", Context)}
                                ,{drop_parent,z_context:get_q("drop_parent", Context)}
                                ,{branch_id,z_context:get_q("branch_id", Context)}
                                ,{switch,z_context:get_q("switch", Context)}]
                               ,Context);
        ExistingElementId -> 
            kazoo_util:cf_set_new_switch(ExistingElementId,z_context:get_q("switch", Context),Context),
            mod_signal:emit({update_cf_builder_area, []}, Context),
            z_render:dialog_close(Context)
    end;

event({submit,cf_select_option_temporal_route,_,_},Context) ->
    lager:info("Existing_Element_id: ~p",[z_context:get_q("existing_element_id", Context)]),
    case z_context:get_q("existing_element_id", Context) of
        [] ->
            kazoo_util:cf_child([{tool_name,z_context:get_q("tool_name", Context)}
                                ,{drop_id,z_context:get_q("drop_id", Context)}
                                ,{drop_parent,z_context:get_q("drop_parent", Context)}
                                ,{branch_id,z_context:get_q("branch_id", Context)}
                                ,{switch,z_context:get_q("switch", Context)}]
                               ,Context);
        ExistingElementId -> 
            kazoo_util:cf_set_new_switch(ExistingElementId,z_context:get_q("switch", Context),Context),
            mod_signal:emit({update_cf_builder_area, []}, Context),
            z_render:dialog_close(Context)
    end;

event({postback,{cf_load,_},_,_},Context) ->
    kazoo_util:cf_load_to_session(z_context:get_q("triggervalue", Context),Context),
    mod_signal:emit({update_cf_builder_area, []}, Context),
    Context;

event({postback,{cf_reload,_},_,_},Context) ->
    case modkazoo_util:get_value(<<"id">>,z_context:get_session('current_callflow', Context)) of
        'undefined' -> kazoo_util:cf_load_to_session("new", Context);
        CallflowId -> kazoo_util:cf_load_to_session(CallflowId, Context)
    end,
    mod_signal:emit({update_cf_builder_area, []}, Context),
    Context;

event({postback,{check_children,[{id,BranchId},{drop_id,DropId},{drop_parent,DropParent}]},_,_},Context) ->
    kazoo_util:cf_may_be_add_child(BranchId,DropId,DropParent,Context);

event({postback,{cf_delete_element,[{element_id,ElementId}]},_,_},Context) ->
    kazoo_util:cf_delete_element(ElementId,Context);

event({postback,{cf_park_element,[{element_id,ElementId}]},_,_},Context) ->
    kazoo_util:cf_park_element(ElementId,Context);

event({postback,{cf_choose_new_switch,[{element_id,ExistingElementId},{drop_parent,DropParent}]},_,_},Context) ->
    kazoo_util:cf_choose_new_switch(ExistingElementId,DropParent,Context);

event({submit,cf_time_of_the_day,_,_},Context) ->
    _ = kazoo_util:cf_time_of_the_day(Context),
    mod_signal:emit({update_admin_portal_time_of_the_day_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_time_of_the_day_rule,[{rule_id,RuleId}]},_,_},Context) ->
    _ = kazoo_util:cf_delete_time_of_the_day_rule(RuleId,Context),
    mod_signal:emit({update_admin_portal_time_of_the_day_list_tpl, []}, Context),
    Context;

event({postback,{delete_prompt,[{prompt_id,PromptId}]},_,_},Context) ->
    _ = kazoo_util:kz_delete_prompt(PromptId,Context),
    mod_signal:emit({update_admin_portal_media_list_tpl, []}, Context),
    Context;

event({postback,{delete_menu,[{menu_id,MenuId}]},_,_},Context) ->
    _ = kazoo_util:kz_menu('delete',MenuId,Context),
    mod_signal:emit({update_admin_portal_menus_list_tpl, []}, Context),
    Context;

event({submit, add_new_media, _, _}, Context) ->
    _ = kazoo_util:upload_media(Context);

event({submit,kz_menu,_,_},Context) ->
    lager:info("kz_menu event variables: ~p", [z_context:get_q_all(Context)]),
    _ = kazoo_util:kz_menu(Context),
    mod_signal:emit({update_admin_portal_menus_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_prepend_cid,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","action"], <<"prepend">>, Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","caller_id_name_prefix"], z_convert:to_binary(z_context:get_q("caller_id_name_prefix", Context)), Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","caller_id_number_prefix"], z_convert:to_binary(z_context:get_q("caller_id_number_prefix", Context)), Context),
    z_render:dialog_close(Context);

event({submit,kz_vmbox,_,_},Context) ->
    _ = kazoo_util:kz_vmbox(Context),
    mod_signal:emit({update_admin_portal_vms_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_vmbox,[{vmbox_id,VmboxId}]},_,_},Context) ->
    _ = kazoo_util:kz_vmbox('delete',VmboxId,Context),
    mod_signal:emit({update_admin_portal_vms_list_tpl, []}, Context),
    Context;

event({submit,kz_conference,_,_},Context) ->
    _ = kazoo_util:kz_conference(Context),
    mod_signal:emit({update_admin_portal_conferences_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_conference,[{conference_id,ConferenceId}]},_,_},Context) ->
    _ = kazoo_util:kz_conference('delete',ConferenceId,Context),
    mod_signal:emit({update_admin_portal_conferences_list_tpl, []}, Context),
    Context;

event({submit,cf_select_conference,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    case z_context:get_q("selected", Context) of
        [] -> ok;
        Id -> 
            _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(Id), Context)
    end,
    z_render:dialog_close(Context);

event({submit,cf_select_eavesdrop,"form_cf_select_eavesdrop","form_cf_select_eavesdrop"},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    TargetType = z_convert:to_binary(z_context:get_q("target_type", Context)++"_id"),
    ApprovedType = z_convert:to_binary("approved_"++z_context:get_q("approved_type", Context)++"_id"),
    TargetSelected = modkazoo_util:get_value(<<"id">>,jiffy:decode(z_context:get_q("target_selected", Context))),
    ApprovedSelected = modkazoo_util:get_value(<<"id">>,jiffy:decode(z_context:get_q("approved_selected", Context))),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data"], {[{TargetType,TargetSelected},{ApprovedType,ApprovedSelected}]}, Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                  ,[<<"metadata">>,TargetSelected]
                                  ,{[{<<"name">>,modkazoo_util:get_value(<<"name">>,jiffy:decode(z_context:get_q("target_selected", Context)))}
                                    ,{<<"pvt_type">>,z_convert:to_binary(z_context:get_q("target_type", Context))}]}
                                  ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                  ,[<<"metadata">>,ApprovedSelected]
                                  ,{[{<<"name">>,modkazoo_util:get_value(<<"name">>,jiffy:decode(z_context:get_q("approved_selected", Context)))}
                                    ,{<<"pvt_type">>,z_convert:to_binary(z_context:get_q("approved_type", Context))}]}
                                  ,Context),
    z_render:dialog_close(Context);

event({postback,toggle_featurecode_voicemail_check,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_voicemail_check(Context),
    mod_signal:emit({signal_featurecode_voicemail_check, []}, Context),
    Context;

event({postback,toggle_featurecode_voicemail_direct,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_voicemail_direct(Context),
    mod_signal:emit({signal_featurecode_voicemail_direct, []}, Context),
    Context;

event({postback,toggle_featurecode_park_and_retrieve,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_park_and_retrieve(Context),
    mod_signal:emit({signal_featurecode_park_and_retrieve, []}, Context),
    Context;

event({postback,toggle_featurecode_park_valet,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_park_valet(Context),
    mod_signal:emit({signal_featurecode_park_valet, []}, Context),
    Context;

event({postback,toggle_featurecode_park_retrieve,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_park_retrieve(Context),
    mod_signal:emit({signal_featurecode_park_retrieve, []}, Context),
    Context;

event({postback,toggle_featurecode_intercom,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_intercom(Context),
    mod_signal:emit({signal_featurecode_intercom, []}, Context),
    Context;

event({postback,toggle_featurecode_privacy,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_privacy(Context),
    mod_signal:emit({signal_featurecode_privacy, []}, Context),
    Context;

event({postback,toggle_featurecode_hotdesk_enable,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_hotdesk_enable(Context),
    mod_signal:emit({signal_featurecode_hotdesk_enable, []}, Context),
    Context;

event({postback,toggle_featurecode_hotdesk_disable,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_hotdesk_disable(Context),
    mod_signal:emit({signal_featurecode_hotdesk_disable, []}, Context),
    Context;

event({postback,toggle_featurecode_hotdesk_toggle,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_hotdesk_toggle(Context),
    mod_signal:emit({signal_featurecode_hotdesk_toggle, []}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_activate,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_activate(Context),
    mod_signal:emit({signal_featurecode_call_forward_activate, []}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_deactivate,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_deactivate(Context),
    mod_signal:emit({signal_featurecode_call_forward_deactivate, []}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_toggle,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_toggle(Context),
    mod_signal:emit({signal_featurecode_call_forward_toggle, []}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_update,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_update(Context),
    mod_signal:emit({signal_featurecode_call_forward_update, []}, Context),
    Context;

event({postback,{toggle_blacklist_member,[{blacklist_id,BlacklistId}]},_,_}, Context) ->
    _ = kazoo_util:toggle_blacklist_member(BlacklistId,Context),
    mod_signal:emit({update_admin_portal_blacklists_tpl, []}, Context),
    Context;

event({postback,toggle_all_calls_recording,_,_}, Context) ->
    _ = kazoo_util:toggle_all_calls_recording(Context),
    z_render:update("all_calls_recording_enabled", z_template:render("_all_calls_recording.tpl", [], Context), Context);

event({postback,add_blacklisted_number,_,_},Context) ->
    case z_context:get_q("new_blacklisted_number",Context) of
        [] -> Context;
        Number -> z_render:insert_top("blacklisted_numbers_list",z_template:render("_blacklisted_number.tpl",[{blacklisted_number,z_convert:to_binary(Number)}],Context),Context) 
    end;

event({submit,add_new_blacklist,_,_},Context) ->
    _ = kazoo_util:set_blacklist_doc(z_context:get_q("blacklist_id", Context), z_context:get_q("blacklist_name", Context), z_context:get_q_all("blacklisted_number", Context), Context),
    mod_signal:emit({update_admin_portal_blacklists_tpl, []}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_blacklist,[{blacklist_id,BlacklistId}]},_,_},Context) ->
    _ = kazoo_util:kz_delete_blacklist(BlacklistId,Context),
    mod_signal:emit({update_admin_portal_blacklists_tpl, []}, Context),
    Context;

event({postback,rs_child_selected,_,_},Context) ->
    z_render:update("child_sandbox", z_template:render("reseller_child_info.tpl", [{account_id, z_context:get_q("triggervalue", Context)}], Context), Context);

event({postback,{rs_account_delete,[{account_id,AccountId}]},_,_},Context) ->
    spawn(kazoo_util,rs_delete_account,[AccountId,Context]),
    z_render:wire({mask, [{target_id, "child_sandbox"}]}, Context);

event({postback,{rs_account_mask,[{account_id,AccountId}]},_,_},Context) ->
    z_context:set_session(kazoo_owner_id, z_convert:to_binary(z_context:get_q("triggervalue", Context)), Context),
    z_context:set_session(kazoo_account_id, z_convert:to_binary(AccountId), Context),
    modkazoo_auth:may_be_add_third_party_billing(Context),
    z_render:wire({redirect, [{dispatch, "admin_callflows"}]}, Context);

event({postback,rs_account_demask,_,_},Context) ->
    z_context:set_session(kazoo_owner_id, z_context:get_session(kazoo_reseller_owner_id, Context), Context),
    z_context:set_session(kazoo_account_id, z_context:get_session(kazoo_reseller_account_id, Context), Context),
    z_context:set_session('current_callflow','undefined',Context),
    z_context:set_session('account_realm','undefined',Context),
    modkazoo_auth:may_be_add_third_party_billing(Context),
    z_render:wire({redirect, [{dispatch, "reseller_portal"}]}, Context);

event({submit,{addcccpcidform, _}, _, _}, Context) ->
    NewAuthCID = z_convert:to_binary(z_context:get_q("cid_number", Context)),
    OutboundCID = z_convert:to_binary(z_context:get_q("outbound_cid", Context)),
    UserId = z_convert:to_binary(z_context:get_q("user_id", Context)),
    _ = kazoo_util:add_cccp_doc({<<"cid">>, NewAuthCID}, {<<"outbound_cid">>, OutboundCID}, {<<"user_id">>, UserId}, Context),
    z_render:wire({redirect, [{dispatch, "callback"}]}, Context);

event({submit,{addcccppinform, _}, _, _}, Context) ->
    NewAuthPIN = z_convert:to_binary(z_context:get_q("pin_number", Context)),
    OutboundCID = z_convert:to_binary(z_context:get_q("outbound_cid", Context)),
    UserId = z_convert:to_binary(z_context:get_q("user_id", Context)),
    _ = kazoo_util:add_cccp_doc({<<"pin">>, NewAuthPIN}, {<<"outbound_cid">>, OutboundCID}, {<<"user_id">>, UserId}, Context),
    z_render:wire({redirect, [{dispatch, "callback"}]}, Context);

event({postback, {del_cccp_doc,[{doc_id,DocId}]}, _, _}, Context) ->
    _ = kazoo_util:del_cccp_doc(DocId, Context),
    z_render:wire({redirect, [{dispatch, "callback"}]}, Context);

event({submit,rs_account_lookup,_,_},Context) ->
    AccountId = case z_context:get_q("search_option", Context) of
        "by_phone_nunber" ->
            kazoo_util:kz_find_account_by_number(z_context:get_q("name", Context), Context);
        _ ->
            'undefined'
    end,
    case AccountId of
        'undefined' ->
            Context1 = z_render:dialog_close(Context),
            z_render:growl_error(?__("Nothing found", Context1), Context1); 
        _ ->
            Context1 = z_render:dialog_close(Context),
            z_render:update("child_sandbox", z_template:render("reseller_child_info.tpl", [{account_id, AccountId}], Context1), Context1)
    end;

event({submit,kz_trunk_server,_,_},Context) ->
    _ = kazoo_util:kz_trunk_server(Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_trunk,[{trunk_id,TrunkId},{server_index,Index}]},_,_}, Context) ->
    kazoo_util:kz_trunk_server_delete(TrunkId, Index, Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, []}, Context),
    Context;

event({submit,manage_trunk_numbers,_,_}, Context) ->
    _ = kazoo_util:kz_trunk_server_numbers(Context),
    z_render:dialog_close(Context);

event({postback,{flush_registration_by_username,[{sip_username, Username}]},_,_}, Context) ->
    _ = kazoo_util:kz_flush_registration_by_username(Username, Context),
    mod_signal:emit({update_admin_portal_devices_list_tpl, []}, Context),
    Context;

event({submit,kz_webhook,_,_},Context) ->
    _ = kazoo_util:kz_webhook(Context),
    mod_signal:emit({update_admin_portal_webhooks_list_tpl, []}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_webhook,[{webhook_id, WebhookId}]},_,_},Context) ->
    _ = kazoo_util:kz_webhook_delete(WebhookId, Context),
    mod_signal:emit({update_admin_portal_webhooks_list_tpl, []}, Context),
    Context;

event({postback,{toggle_webhook,[{webhook_id,WebhookId}]},_,_}, Context) ->
    _ = kazoo_util:kz_webhook_toggle(WebhookId, Context),
    mod_signal:emit({update_admin_portal_webhooks_list_tpl, []}, Context),
    Context;

event({postback,refresh_admin_callstats,_,_}, Context) ->
    SelectedDay = z_context:get_q("callstatsdayInput",Context),
lager:info("SelectedDay: ~p",[SelectedDay]),
    mod_signal:emit({update_admin_portal_call_history_tpl, [{selected_day, SelectedDay}]}, Context),
    Context;

event({drag,_,_},Context) ->
    Context;

event({sort,_,_},Context) ->
    Context;

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.
