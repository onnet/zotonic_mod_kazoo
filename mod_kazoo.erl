-module(mod_kazoo).
-author("kirill.sysoev@gmail.com").

-mod_title("Kazoo UI").
-mod_description("Zotonic Kazoo user interface module").
-mod_prio(11).

-export([init/1]).

-export([
     observe_search_query/2
    ,observe_postback_notify/2
    ,observe_kazoo_notify/2
    ,observe_topmenu_element/2
    ,observe_onbill_topmenu_element/2
    ,observe_currency_sign/2
    ,event/2
]).


-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

init(_Context) ->
    application:start('ibrowse'),
    'ok'.

observe_search_query(_, _) ->
    'undefined'.

observe_postback_notify({postback_notify, <<"no_auth">>,_,_,_}, Context) ->
    lager:info("Catched postback notify: no_auth"),
 %   {ok, Context1} = z_session_manager:stop_session(Context),
    z_render:wire({redirect, [{dispatch, home}]}, Context);

observe_postback_notify(A, _Context) ->
    lager:info("Catched postback notify: ~p", [A]),
    undefined.

observe_kazoo_notify({kazoo_notify, <<"no_auth">>,_,_,_}, Context) ->
    lager:info("Catched kazoo notify: no_auth"),
    z_session:add_script(<<"z_notify('no_auth');">>, Context#context.session_pid);
 %   {ok, Context1} = z_session_manager:stop_session(Context),
 %   z_render:wire({redirect, [{dispatch, "home"}]}, Context1);

observe_kazoo_notify(A, _Context) ->
    lager:info("Catched kazoo notify: ~p", [A]),
    undefined.

observe_topmenu_element(_, Context) ->
    case modkazoo_auth:is_auth(Context) of
        'false' -> 'undefined';
        'true' -> choose_topmenu(Context)
    end.

choose_topmenu(Context) ->
    case modkazoo_auth:is_superadmin_or_reseller(Context) of
        'true' -> <<"_kazoo_topmenu_reseller.tpl">>;
        'false' -> <<"_kazoo_topmenu_hosted_pbx.tpl">>
    end.

observe_currency_sign(_A, Context) ->
    case onbill_util:currency_sign(Context) of
        <<"undefined">> -> 'undefined';
        'undefined' -> 'undefined';
        CurrencySign -> {'ok', CurrencySign}
    end.

observe_onbill_topmenu_element(_, Context) ->
    case modkazoo_auth:is_auth(Context) of
        'false' -> 'undefined';
        'true' -> <<"_onbill_topmenu.tpl">>
    end.

event({submit,{innoauth,[]},<<"sign_in_form">>,<<"sign_in_form">>}, Context) ->
    Login = z_convert:to_binary(z_context:get_q("username",Context)),
    Password = z_convert:to_binary(z_context:get_q("password",Context)),
    Account = z_convert:to_binary(z_context:get_q("account",Context)),
    modkazoo_auth:do_sign_in(Login, Password, Account, Context);

event({submit,{innoauth,[]},<<"sign_in_page_form">>,<<"sign_in_page_form">>}, Context) ->
    Login = z_convert:to_binary(z_context:get_q("username_page",Context)),
    Password = z_convert:to_binary(z_context:get_q("password_page",Context)),
    Account = z_convert:to_binary(z_context:get_q("account_page",Context)),
    modkazoo_auth:do_sign_in(Login, Password, Account, Context);

event({postback,{signout,[]}, _, _}, Context) ->
    modkazoo_auth:signout(Context);

event({submit,{innosignup,[]},<<"sign_up_form">>,<<"sign_up_form">>}, Context) ->
    lager:info("innosignup event variables: ~p", [z_context:get_q_all(Context)]),
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
      throw:{error,account_name_already_in_use} -> z_render:growl_error(?__("Account name already in use",Context), Context);
      E1:E2 ->
          lager:info("Err ~p:~p", [E1, E2]), 
          z_render:growl_error(?__("All fields should be correctly filled in",Context), Context)
    end;

event({submit,{kazoo_user_settings,[]},<<"user_settings_form_form">>,<<"user_settings_form_form">>}, Context) ->
    kazoo_util:update_kazoo_user(Context);

event({postback,{set_vm_message_folder,[{folder, Folder}, {vmbox_id,VMBoxId}, {media_id,MediaId}]}, _, _}, Context) ->
    kazoo_util:set_vm_message_folder(Folder, VMBoxId, MediaId, Context),
    Context;

event({postback,{delete_vm_message,[{vmbox_id,VMBoxId}, {media_id,MediaId}]}, _, _}, Context) ->
    kazoo_util:vmbox_message('delete', MediaId, VMBoxId, Context),
    mod_signal:emit({user_portal_voicemails_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,{forgottenpwd,[]},_,_}, Context) ->
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
            Routines = [fun(Ctx) -> z_render:wire([{set_class, [{target, "forgot-pwd-box"},{class,"search-box hidden"}]}], Ctx) end
                       ,fun(Ctx) -> z_render:growl(?__("Please check your mailbox", Ctx), Ctx) end
                       ,fun(Ctx) -> z_render:update("password_change_span_id",z_template:render("password_change_check_email.tpl",[],Ctx),Ctx) end
                       ],
            lists:foldl(fun(F, Ctx) -> F(Ctx) end, Context, Routines)
    end;

event({postback,{reset_password,[{username,FormUsername}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    AccountName = kazoo_util:kz_account_doc_field(<<"name">>, AccountId, Context),
    Username = case FormUsername of
                   'undefined' -> kazoo_util:kz_user_doc_field(<<"username">>, Context);
                    FormUsername -> FormUsername
               end,
    case kazoo_util:password_recovery(Username, AccountName, Context) of
        <<"">> -> z_render:growl_error(?__("The provided account name could not be found",Context), Context);
        Answer -> z_render:growl(?__(Answer, Context), Context)
    end;

event({postback,{password_reset_submit,[{reset_id,ResetId}]},_,_}, Context) ->
    case kazoo_util:password_reset_submit(ResetId, Context) of
        {'ok', [50,_,_], _, Body} ->
            {JsonData} = jiffy:decode(Body),
            Data = proplists:get_value(<<"data">>, JsonData),
            AuthToken = proplists:get_value(<<"auth_token">>, JsonData),
            AccountId = modkazoo_util:get_value(<<"account_id">>, Data),
            OwnerId = modkazoo_util:get_value(<<"owner_id">>, Data),
            AccountName = modkazoo_util:get_value(<<"account_name">>, Data),
            UserDoc = kazoo_util:kz_get_user_doc_by_authtoken(OwnerId, AccountId, AuthToken, Context),
            UserName = modkazoo_util:get_value(<<"username">>, UserDoc),
            z_render:update("password_change_span_id"
                           ,z_template:render("password_change_form.tpl"
                                             ,[{'auth_token', AuthToken}
                                              ,{'account_id', AccountId}
                                              ,{'owner_id', OwnerId}
                                              ,{'account_name', AccountName}
                                              ,{'username', UserName}
                                              ]
                                             ,Context)
                           ,Context);
        E ->
            lager:info("password_reset_submit Error: ~p", [E]),
            z_render:update("password_change_span_id",z_template:render("password_change_error.tpl",[],Context),Context)
         %   growl_redirect("error", "Something went wrong, please try again", "home", Context)
    end;

event({submit,password_recovery_form,_,_}, Context) ->
    lager:info("password_recovery_form variables: ~p", [z_context:get_q_all(Context)]),
  try
    Password = z_context:get_q("password1", Context),
    OwnerId = z_context:get_q("owner_id", Context),
    AccountId = z_context:get_q("account_id", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    AccountName = z_context:get_q("account_name", Context),
    UserName = z_context:get_q("username", Context),
    _ = kazoo_util:kz_set_user_doc(<<"password">>, Password, OwnerId, AccountId, AuthToken, Context),
    z_render:update("password_change_span_id"
                   ,z_template:render("password_change_success.tpl",[{'account_name', AccountName},{'username', UserName}],Context)
                   ,Context)
  %  kazoo_util:growl_redirect('undefined', "Password changed, please try sign-in", "home", Context)
  catch
    E1:E2 -> 
        lager:info("Error. E1: ~p E2: ~p", [E1, E2]),
        z_render:update("password_change_span_id",z_template:render("password_change_error.tpl",[],Context),Context)
     %   kazoo_util:growl_redirect("error", "Something went wrong, please try again", "home", Context)
  end;

event({postback,rate_seek,_,_}, Context) ->
    Number = z_convert:to_binary(re:replace(z_context:get_q("rate_seek",Context), "[^0-9]", "", [global, {return, list}])),
    case kazoo_util:rate_number(Number, Context) of
        {'ok', PriceInfo} ->
            z_render:update("single_number_rate", z_template:render("_single_number_rate.tpl", [{priceinfo, PriceInfo}], Context), Context);
        _ ->
            z_render:growl_error(?__("Wrong number provided, please try again.",Context), Context)
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
       %    AttachmentUrl = <<<<"https://">>/binary,(?TO_BIN(z_dispatcher:hostname(Context)))/binary,<<"/getfaxdoc/id/">>/binary,FileName/binary>>,
            AttachmentUrl = <<<<"http://">>/binary, (?TO_BIN(z_dispatcher:hostname(Context)))/binary, <<"/getfaxdoc/id/">>/binary, FileName/binary>>,
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
    no_number_entered ->
        z_render:growl_error(?__("No number entered",Context), Context);
    no_document_uploaded ->
        z_render:growl_error(?__("No document chosen",Context), Context);
    error:{badmatch, {true, faxfile}} ->
        z_render:growl_error(?__("Maximum file size exceeded. Please try to upload smaller file.",Context), Context);
    E1:E2 -> 
        lager:info("Error. E1: ~p E2: ~p", [E1, E2]),
        z_render:growl_error(?__("Something wrong happened.",Context), Context)

  end;

event({postback,kazoo_transaction,_,_}, Context) ->
    case z_convert:to_float(z_context:get_q("kazoo_transaction", Context)) of
        Amount when Amount >= 10, Amount =< 200 ->
            case kazoo_util:make_payment(Amount, z_context:get_session('kazoo_account_id', Context), Context) of
                {'error', _ReturnCode, Body} ->
                    Message = modkazoo_util:get_first_defined([[<<"data">>,<<"amount">>,<<"maximum">>]
                                                              ,[<<"data">>,<<"api_error">>,<<"message">>]
                                                              ]
                                                             ,jiffy:decode(Body)
                                                             ,<<"Something went wrong">>),
                    z_render:growl_error(?__(z_convert:to_list(Message), Context), Context);
                JObj ->
                    case modkazoo_util:get_value([<<"bookkeeper_info">>,<<"status">>], JObj) of
                        <<"submitted_for_settlement">> ->
                            modkazoo_util:delay_signal(1, 'update_onnet_widget_online_payment_tpl', ?SIGNAL_FILTER(Context), Context),
                            modkazoo_util:delay_signal(2, 'update_onnet_widget_finance_tpl', ?SIGNAL_FILTER(Context), Context),
                            modkazoo_util:delay_signal(2 ,'update_fin_info_signal' , ?SIGNAL_FILTER(Context), Context),
                            z_render:growl(?__("Funds successfully added.",Context), Context);
                        E ->
                            z_render:growl_error(?__("Something went wrong: ", Context)++z_convert:to_list(E), Context)
                    end
            end;
        _ -> 
            Context1 = z_render:growl_error(?__("Payment failed!<br />Please input correct amount.", Context), Context),
            z_render:update("onnet_widget_online_payment_tpl"
                           ,z_template:render("onnet_widget_online_payment.tpl"
                                             ,[{cat, "text"} 
                                              ,{headline, "Online payments"}
                                              ,{bt_customer, kazoo_util:kz_bt_customer(Context1)}
                                              ]
                                             ,Context1)
                           ,Context1)
    end;

event({postback,{bt_delete_card,[{card_id,CardId}]},_,_}, Context) ->
    kazoo_util:bt_delete_card(CardId, Context),
    mod_signal:emit({update_onnet_widget_online_payment_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{bt_make_default_card,[{card_id,CardId}]},_,_}, Context) ->
    bt_util:bt_make_default_card(CardId, Context),
    z_render:update("cards_list_body"
                   ,z_template:render("_make_payment_cards_list.tpl", [{bt_customer, kazoo_util:kz_bt_customer(Context)}], Context)
                   ,Context);

event({submit,add_card,<<"add_card_form">>,<<"add_card_form">>}, Context) ->
    case z_context:get_q("payment_method_nonce", Context) of
        'undefined' -> Context;
        [] -> Context;
        _ -> 
            case bt_util:bt_card_add(Context) of
                "success" -> 
                    mod_signal:emit({emit_growl_signal
                                    ,?SIGNAL_FILTER(Context) ++
                                     [{'text',?__("Card successfully added.", Context)}
                                     ,{'type', 'notice'}
                                     ]}
                                    ,Context);
                E ->
                    mod_signal:emit({emit_growl_signal
                                    ,?SIGNAL_FILTER(Context) ++
                                     [{'text',?__(E, Context)}
                                     ,{'type', 'error'}
                                     ]}
                                    ,Context)
            end,
            mod_signal:emit({update_onnet_widget_online_payment_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Context
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

event({postback,issue_proforma_invoice,_,_},Context) ->
    try z_convert:to_float(z_context:get_q("invoice_amount",Context)) of
        Amount when Amount == 'undefined' orelse Amount =< 0 ->
            Context1 = z_render:update("onnet_widget_make_invoice_tpl"
                                      ,z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context)
                                      ,Context),
            z_render:growl_error(?__("Please input correct amount of funds you'd like to transfer.", Context1), Context1);
        Amount when Amount > 0 ->
            AccountId = z_context:get_session('kazoo_account_id', Context),
            Res = onbill_util:create_proforma_invoice(Amount, AccountId, Context),
            z_render:update("onnet_widget_make_invoice_tpl"
                           ,z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"},{result, Res}], Context)
                           ,Context)
    catch
        _:_ ->
            Context1 = z_render:update("onnet_widget_make_invoice_tpl"
                                      ,z_template:render("onnet_widget_make_invoice.tpl", [{headline,"Wire transfer"}], Context)
                                      ,Context),
            z_render:growl_error(?__("Please input correct amount of funds you'd like to transfer.", Context1), Context1)
    end;

event({postback,new_numbers_lookup,_,_}, Context) ->
    AreaCode = case z_convert:to_binary(z_context:get_q("areacode",Context)) of
        <<"0", Number/binary>> -> Number;
        Number -> Number
    end,
    Country = z_context:get_q("country",Context),
    lager:info("Country and AreaCode lookup attempt: ~p:~p",[Country, AreaCode]),
    PhoneNumbersServices = modkazoo_util:get_value([<<"items">>,<<"phone_numbers">>], kazoo_util:current_service_plans(Context)),
    case kazoo_util:lookup_numbers(Country, AreaCode, Context) of
        [FreeNumber|_] = FNS ->
            NumberClass = kazoo_util:classify_number(modkazoo_util:get_value(<<"number">>, FreeNumber), Context),
            NumberFriendlyName = modkazoo_util:get_value(<<"friendly_name">>, NumberClass),
            NumberName = modkazoo_util:get_value(<<"name">>, NumberClass),
            Rate = modkazoo_util:get_value([NumberName, <<"rate">>], PhoneNumbersServices),
            ActivationCharge = modkazoo_util:get_value([NumberName, <<"activation_charge">>], PhoneNumbersServices),
            FreeNumbers = [modkazoo_util:set_values([{<<"name">>, NumberName}
                                                    ,{<<"friendly_name">>, NumberFriendlyName}
                                                    ,{<<"rate">>, Rate}
                                                    ,{<<"activation_charge">>, ActivationCharge}
                                                    ]
                                                   ,FN)
                           || FN <- FNS],
            z_render:update("numbers_to_choose",z_template:render("_numbers_lookup.tpl", [{free_numbers, FreeNumbers}], Context),Context);
        _ ->
            z_render:update("numbers_to_choose",z_template:render("_numbers_lookup.tpl", [{free_numbers, []}], Context),Context)
    end;

event({postback,{rs_add_number,[{account_id,AccountId}]},_,_}, Context) ->
    case z_context:get_q("new_number_to_add",Context) of
        'undefined' -> z_render:growl_error(?__("Something wrong happened.", Context), Context);
        NumberToAdd -> 
            _ = kazoo_util:rs_add_number(NumberToAdd, AccountId, Context),
            lager:info("Number add attempt: ~p",[NumberToAdd]),
            {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
            SenderName = kazoo_util:email_sender_name(Context),
            Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
                   ,{login_name, z_context:get_session('kazoo_login_name', Context)}
                   ,{email_from, m_config:get_value('mod_kazoo', sales_email, Context)}
                   ,{clientip, ClientIP}
                   ,{sender_name, SenderName}
                   ,{number, NumberToAdd}],
            spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_number_purchase.tpl", Vars, Context]),
            lager:info("Number add attempt AccountId: ~p",[ AccountId]),
            mod_signal:emit({update_rs_allocated_numbers_tpl, ?SIGNAL_FILTER(Context) ++ [{account_id, AccountId}]}, Context),
            Context
    end;

event({postback,{deallocate_number,[{number,Number}]},_,_}, Context) ->
    lager:info("Number deallocation attempt: ~p",[Number]),
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    SenderName = kazoo_util:email_sender_name(Context),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{email_from, m_config:get_value('mod_kazoo', sales_email, Context)}
           ,{sender_name, SenderName}
           ,{clientip, ClientIP}
           ,{number, Number}],
    spawn('z_email'
         ,'send_render'
         ,[m_config:get_value('mod_kazoo', sales_email, Context), "_email_deallocate_number.tpl", Vars, Context]
         ),
    case kazoo_util:deallocate_number(Number, Context) of
        <<>> ->
            Context1 = z_render:update("onnet_allocated_numbers_tpl"
                                      ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], Context)
                                      ,Context),
            Context2 = z_render:update("onnet_widget_monthly_fees_tpl"
                                      ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current services"}], Context1)
                                      ,Context1),
            z_render:growl_error(?__("Something wrong happened.", Context2), Context2);
        _ -> 
            Context1 = z_render:update("onnet_allocated_numbers_tpl"
                                      ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], Context)
                                      ,Context),
            Context2 = z_render:update("onnet_widget_monthly_fees_tpl"
                                      ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current month services"}], Context1)
                                      ,Context1),
            z_render:growl(?__("Number ", Context2)++z_convert:to_list(Number)++?__(" successfully removed.", Context2), Context2)
    end;

event({postback,{deallocate_number,[{number,Number},{account_id, AccountId}]},_,_}, Context) ->
    lager:info("Number deallocation attempt: ~p",[Number]),
    SenderName = kazoo_util:email_sender_name(Context),
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{email_from, m_config:get_value('mod_kazoo', sales_email, Context)}
           ,{clientip, ClientIP}
           ,{sender_name, SenderName}
           ,{number, Number}],
    spawn('z_email', 'send_render', [m_config:get_value('mod_kazoo', sales_email, Context), "_email_deallocate_number.tpl", Vars, Context]),
    case kazoo_util:deallocate_number(Number, AccountId, Context) of
        <<>> ->
            Context1 = z_render:update("rs_numbers_list_table"
                                      ,z_template:render("rs_numbers_list_table_body.tpl", [{account_id, AccountId}], Context)
                                      ,Context),
            z_render:growl_error(?__("Something wrong happened.", Context1), Context1);
        _ -> 
            Context1 = z_render:update("rs_numbers_list_widget_opened"
                                      ,z_template:render("rs_numbers_list_table_body.tpl", [{account_id, AccountId}], Context)
                                      ,Context),
            z_render:growl(?__("Number ", Context1)++z_convert:to_list(Number)++?__(" successfully removed.", Context1), Context1)
    end;

event({postback,{fix_allocated_numbers,[{account_id, 'undefined'}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,{fix_allocated_numbers,[{account_id, AccountId}]},<<>>,<<>>}, Context);
event({postback,{fix_allocated_numbers,[{account_id, AccountId}]},_,_}, Context) ->
    mod_signal:emit({emit_growl_signal
                    ,?SIGNAL_FILTER(Context) ++
                     [{'text',?__("Numbers refresh request sent. This could take a while", Context)}
                     ,{'type', 'notice'}
                     ]}
                   ,Context),
    spawn(kazoo_util,account_numbers_fix_plus,[AccountId,Context]),
    Context;

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
    z_render:update("user_portal_faxes_incoming"
                   ,z_template:render("user_portal_faxes_incoming.tpl", [{headline,?__("Incoming faxes", Context)}], Context)
                   ,Context);

event({postback,{toggle_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, AccountId}]},_,_}, Context) ->
    event({postback,{toggle_field,[{type,Type}
                                  ,{doc_id,DocId}
                                  ,{field_name, FieldName}
                                  ,{prefix, 'undefined'}
                                  ,{account_id, AccountId}
                                  ]}
                                 ,<<>>,<<>>}, Context);

event({postback,{toggle_field,[{type,Type}
                              ,{doc_id,DocId}
                              ,{field_name, FieldName}
                              ,{prefix, Prefix}
                              ,{account_id, 'undefined'}
                              ]}
                             ,_,_}, Context) ->
    event({postback,{toggle_field,[{type,Type}
                                  ,{doc_id,DocId}
                                  ,{field_name, FieldName}
                                  ,{prefix, Prefix}
                                  ,{account_id, z_context:get_session('kazoo_account_id', Context)}
                                  ]}
                                 ,<<>>,<<>>}, Context);
event({postback,{toggle_field,[{type,Type}
                              ,{doc_id,DocId}
                              ,{field_name, FieldName}
                              ,{prefix, Prefix}
                              ,{account_id, AccountId}
                              ]}
                             ,_,_}, Context) ->
    TargetId = case Prefix of
                   'undefined' -> FieldName;
                   L -> L ++ FieldName
               end,
    case Type of
        <<"account">> ->
            _ = kazoo_util:kz_toggle_account_doc(FieldName, AccountId, Context),
            maybe_update_toggled_field(TargetId, Type, DocId, FieldName, Prefix, AccountId, Context);
        <<"user">> ->
            _ = kazoo_util:kz_toggle_user_doc(FieldName, DocId, Context),
            maybe_update_toggled_field(TargetId, Type, DocId, FieldName, Prefix, AccountId, Context);
        <<"device">> ->
            _ = kazoo_util:kz_toggle_device_doc(FieldName, DocId, Context),
            maybe_update_toggled_field(TargetId, Type, DocId, FieldName, Prefix, AccountId, Context);
        <<"config">> ->
            z_notifier:notify1({'doc_field', 'toggle', ?TO_BIN(DocId), ?TO_BIN(FieldName), AccountId}, Context),
            timer:sleep(1000),
            maybe_update_toggled_field(TargetId, Type, DocId, FieldName, Prefix, AccountId, Context)
    end;

event({submit,passwordForm,_,_}, Context) ->
    lager:info("passwordForm event variables: ~p", [z_context:get_q_all(Context)]),
  try
    case z_context:get_q("username",Context) of
        [] -> 
            _ = kazoo_util:kz_set_user_doc(<<"password">>, z_convert:to_binary(z_context:get_q("password1", Context))
                                           ,z_convert:to_binary(z_context:get_q("chpwd_user_id", Context))
                                           ,Context),
            z_render:growl(?__("Password changed", Context), Context);
        Username ->
            {{ok, _}, _} = validator_base_email:validate(email, 2, Username, [], Context),
            case z_context:get_q("email",Context) of
                Username -> 'ok';
                _ -> throw({'error', 'emails_not_equal'})
            end,
            case kazoo_util:change_credentials(Username
                                              ,z_context:get_q("password1", Context)
                                              ,z_context:get_q("chpwd_user_id", Context)
                                              ,Context)
            of
                {'error', _ReturnCode, _Body} -> throw({'error', 'username_already_in_use'});
                _ -> 'ok'
            end, 
            mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:dialog_close(z_render:growl(?__("User cedentials changed", Context), Context))
    end
  catch
      error:{badmatch,{{error, 2, invalid}, _}} -> z_render:growl_error(?__("Incorrect Email field",Context), Context);
      error:{badmatch, _} -> z_render:growl_error(?__("All fields should be filled in",Context), Context);
      throw:{error,'emails_not_equal'} -> z_render:growl_error(?__("Entered emails should be equal",Context), Context);
      throw:{error,'username_already_in_use'} -> z_render:growl_error(?__("Username/Email already in use",Context), Context);
      E1:E2 ->
          lager:info("Err ~p:~p", [E1, E2]),
          z_render:growl_error(?__("All fields should be correctly filled in",Context), Context)
  end;

event({postback,{delete_user,[{user_id,UserId}]},_,_}, Context) ->
    _ = kazoo_util:delete_user(UserId, Context),
    mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;
event({postback,{delete_device,[{device_id,DeviceId}]},_,_}, Context) ->
    _ = kazoo_util:delete_device(DeviceId, Context),
    mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{enable_doc,[{type,Type},{doc_id,DocId},{field_name,Field}]},_,_}, Context) ->
    case Type of
        "user" ->
            _ = kazoo_util:kz_set_user_doc(Field, 'true', DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Context1 = z_render:update("user_enabled_status"
                                      ,z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context)
                                      ,Context),
            z_render:update("user_enable_control"
                           ,z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1)
                           ,Context1);
        "device" ->
            _ = kazoo_util:kz_set_device_doc(Field, 'true', DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Context1 = z_render:update("device_enabled_status"
                                      ,z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context)
                                      ,Context),
            z_render:update("device_enable_control"
                           ,z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1)
                           ,Context1)
    end;

event({postback,{disable_doc,[{type,Type},{doc_id,DocId},{field_name,Field}]},_,_}, Context) ->
    case Type of
        "user" ->
            _ = kazoo_util:kz_set_user_doc(Field, 'false', DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Context1 = z_render:update("user_enabled_status"
                                      ,z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context)
                                      ,Context),
            z_render:update("user_enable_control"
                           ,z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1)
                           ,Context1);
        "device" ->
            _ = kazoo_util:kz_set_device_doc(Field, 'false', DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Context1 = z_render:update("device_enabled_status"
                                      ,z_template:render("_enabled_status.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context)
                                      ,Context),
            z_render:update("device_enable_control"
                           ,z_template:render("_enable_control.tpl", [{type,Type},{doc_id,DocId},{field_name,Field}], Context1)
                           ,Context1)
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
      mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
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
    event({postback
          ,{save_field,[{type,Type}
                       ,{doc_id,DocId}
                       ,{field_name, FieldName}
                       ,{account_id, z_context:get_session('kazoo_account_id', Context)}
                       ]
           },<<>>,<<>>},Context);

event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, 'undefined'}]},_,_}, Context) ->
    event({postback
          ,{save_field,[{type,Type}
                       ,{doc_id,DocId}
                       ,{field_name, FieldName}
                       ,{account_id, z_context:get_session('kazoo_account_id', Context)}
                       ]
           },<<>>,<<>>},Context);

event({postback,{save_field,[{type,Type},{doc_id,DocId},{field_name, FieldName},{account_id, AccountId}]},_,_}, Context) ->
    case Type of
        <<"account">> ->
            _ = kazoo_util:kz_set_acc_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), AccountId, Context),
            z_render:update(FieldName
                           ,z_template:render("_show_field.tpl"
                                             ,[{type,Type},{doc_id,DocId},{field_name,FieldName},{account_id, AccountId}]
                                             ,Context
                                             )
                           ,Context);
        <<"user">> ->
            _ = kazoo_util:kz_set_user_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:update(FieldName, z_template:render("_show_field.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context);
        <<"device">> ->
            _ = kazoo_util:kz_set_device_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:update(FieldName, z_template:render("_show_field.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context);
        <<"config">> ->
            ConfValue = ?TO_BIN(z_context:get_q("input_value", Context)),
            z_notifier:notify1({'doc_field', 'save', ?TO_BIN(DocId), ?TO_BIN(FieldName), ConfValue, AccountId}, Context),
            timer:sleep(1000),
            z_render:update(FieldName, z_template:render("_show_field.tpl", [{type,Type},{doc_id,DocId},{field_name,FieldName}], Context), Context)
    end;

event({postback,{save_field_select,[{type,Type},{doc_id,DocId},{field_name, FieldName},{options,Options}]},_,_}, Context) ->
    event({postback
          ,{save_field_select,[{type,Type}
                              ,{doc_id,DocId}
                              ,{field_name, FieldName}
                              ,{options,Options}
                              ,{prefix,""}
                              ,{postfix,""}
                              ]
           },<<>>,<<>>},Context);


event({postback
      ,{save_field_select,[{type,Type}
                          ,{doc_id,DocId}
                          ,{field_name, FieldName}
                          ,{options,Options}
                          ,{prefix,RawPrefix}
                          ,{postfix,RawPostfix}
                          ]
       },_,_},Context)
    ->
    event({postback
          ,{save_field_select,[{type,Type}
                              ,{doc_id,DocId}
                              ,{field_name, FieldName}
                              ,{options,Options}
                              ,{prefix,RawPrefix}
                              ,{postfix,RawPostfix}
                              ,{account_id,z_context:get_session('kazoo_account_id', Context)}
                              ]
           },<<>>,<<>>}, Context);

event({postback
      ,{save_field_select,[{type,Type}
                          ,{doc_id,DocId}
                          ,{field_name, FieldName}
                          ,{options,Options}
                          ,{prefix,RawPrefix}
                          ,{postfix,RawPostfix}
                          ,{account_id,'undefined'}
                          ]
       },_,_}, Context)
    ->
    event({postback
          ,{save_field_select,[{type,Type}
                              ,{doc_id,DocId}
                              ,{field_name, FieldName}
                              ,{options,Options}
                              ,{prefix,RawPrefix}
                              ,{postfix,RawPostfix}
                              ,{account_id,z_context:get_session('kazoo_account_id', Context)}
                              ]
           },<<>>,<<>>}, Context);

event({postback
      ,{save_field_select,[{type,Type}
                          ,{doc_id,DocId}
                          ,{field_name, FieldName}
                          ,{options,Options}
                          ,{prefix,RawPrefix}
                          ,{postfix,RawPostfix}
                          ,{account_id,AccountId}
                          ]
       },_,_}, Context)
    ->
    Prefix = case RawPrefix of
        'undefined' -> "";
        Pre -> Pre
    end,
    Postfix = case RawPostfix of
        'undefined' -> "";
        Post -> Post
    end,
    case Type of
        <<"account">> ->
            _ = kazoo_util:kz_set_acc_doc(FieldName, z_convert:to_binary(z_context:get_q("input_value", Context)), AccountId, Context),
            z_render:update(Prefix++FieldName
                           ,z_template:render("_show_field_select.tpl"
                                             ,[{type,Type}
                                              ,{doc_id,DocId}
                                              ,{field_name,FieldName}
                                              ,{options,Options}
                                              ,{prefix,Prefix}
                                              ,{postfix,Postfix}
                                              ,{account_id, AccountId}
                                              ]
                                             ,Context)
                           ,Context);
        <<"user">> ->
            _ = kazoo_util:kz_set_user_doc(FieldName, ?TO_BIN(z_context:get_q("input_value", Context)), DocId, Context),
            mod_signal:emit({update_admin_portal_users_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:update(Prefix++FieldName
                           ,z_template:render("_show_field_select.tpl"
                                             ,[{type,Type}
                                              ,{doc_id,DocId}
                                              ,{field_name,FieldName}
                                              ,{options,Options}
                                              ,{prefix,Prefix}
                                              ,{postfix,Postfix}
                                              ]
                                             ,Context)
                           ,Context);
        <<"device">> ->
            InputValue = case z_context:get_q("input_value", Context) of
                [] -> 'undefined';
                Val -> z_convert:to_binary(Val)
            end,
            _ = kazoo_util:kz_set_device_doc(FieldName, InputValue, DocId, Context),
            mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:update(Prefix++FieldName
                           ,z_template:render("_show_field_select.tpl"
                                             ,[{type,Type}
                                              ,{doc_id,DocId}
                                              ,{field_name,FieldName}
                                              ,{options,Options}
                                              ,{prefix,Prefix}
                                              ,{postfix,Postfix}
                                              ]
                                             ,Context)
                           ,Context);
        <<"config">> ->
            ConfValue = ?TO_BIN(z_context:get_q("input_value", Context)),
            z_notifier:notify1({'doc_field', 'save', ?TO_BIN(DocId), ?TO_BIN(FieldName), ConfValue, AccountId}, Context),
            timer:sleep(1000),
            z_render:update(Prefix++FieldName
                           ,z_template:render("_show_field_select.tpl"
                                             ,[{type,Type}
                                              ,{doc_id,DocId}
                                              ,{field_name,FieldName}
                                              ,{options,Options}
                                              ,{prefix,Prefix}
                                              ,{postfix,Postfix}
                                              ]
                                             ,Context)
                           ,Context)
    end;

event({submit,add_new_device,_,_}, Context) ->
    _ = kazoo_util:add_device(Context),
    mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({submit,add_new_group,_,_}, Context) ->
    case z_context:get_q("name",Context) of
        [] -> z_render:growl_error(?__("Please input group name.", Context), Context);
        _ ->
            _ = kazoo_util:add_group(Context),
            mod_signal:emit({update_admin_portal_groups_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:dialog_close(Context)
    end;

event({submit,edit_group,_,_}, Context) ->
    case z_context:get_q("name",Context) of
        [] -> z_render:growl_error(?__("Please input group name.", Context), Context);
        _ ->
            _ = kazoo_util:modify_group(Context),
            mod_signal:emit({update_admin_portal_groups_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
            z_render:dialog_close(Context)
    end;

event({postback,{delete_group,[{group_id,GroupId}]},_,_}, Context) ->
    _ = kazoo_util:delete_group(GroupId, Context),
    mod_signal:emit({update_admin_portal_groups_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
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
                    _ = kazoo_util:cf_add_number(Number,Context),
                    case z_context:get_q("number_type", Context) of
                        "number_type_1" -> kazoo_util:cf_notes_number_action("add", Number, Context);
                        _ -> 'ok'
                    end
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
    mod_signal:emit({update_cf_numbers_div, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{cf_delete_number,[{number,Number}]},_,_}, Context) ->
    _ = kazoo_util:cf_delete_number(Number, Context),
    mod_signal:emit({update_cf_numbers_div, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{cf_note_number,[{action,Action},{number,Number}]},_,_},Context) ->
    kazoo_util:cf_notes_number_action(Action, Number, Context),
    Context;

event({submit,cf_edit_name,_,_},Context) ->
    _ = kazoo_util:cf_edit_name(z_context:get_q("callflow_name", Context),Context),
    _ = kazoo_util:cf_contact_list_exclude(z_context:get_q("callflow_exclude", Context),Context),
    mod_signal:emit({update_cf_edit_name, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_user,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","timeout"]
                                 ,z_convert:to_binary(z_context:get_q("timeout", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","can_call_self"], true, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_device,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","timeout"]
                                 ,z_convert:to_binary(z_context:get_q("timeout", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","can_call_self"], true, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_play,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_voicemail,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_callflow,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_record_call,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","action"], <<"start">>, Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","url"], <<>>, Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","format"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","time_limit"], <<"6000">>, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_group_pickup,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    PickupType = z_context:get_q("pickup_type", Context)++"_id",
    Selected = jiffy:decode(z_context:get_q("selected", Context)),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data",PickupType]
                                 ,modkazoo_util:get_value(<<"id">>,Selected)
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","name"]
                                 ,modkazoo_util:get_value(<<"name">>,Selected)
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_receive_fax,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","owner_id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","media","fax_option"]
                                 ,modkazoo_util:on_to_true(z_context:get_q("t_38_checkbox", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({postback,{cf_save,[{cf,<<"current_callflow">>}]},_,_},Context) ->
    kazoo_util:cf_save('current_callflow', Context);

event({postback,{cf_delete,[{cf,<<"current_callflow">>}]},_,_},Context) ->
    kazoo_util:cf_delete('current_callflow', Context),
    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context);

event({postback,{cf_ring_group_select,[{element_type,ElementType}]},_,_},Context) ->
    Selected = jiffy:decode(z_context:get_q("triggervalue", Context)),
    Context1 = z_render:insert_bottom("sorter"
                                     ,z_template:render("_cf_select_ring_group_element.tpl"
                                                       ,[{selected_value,Selected},{element_type,ElementType}]
                                                       ,Context)
                                     ,Context),
    z_render:wire([{hide, [{target, "option_"++z_convert:to_list(modkazoo_util:get_value(<<"id">>,Selected))}]}], Context1);

event({submit,cf_select_ring_group,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","name"]
                                 ,z_convert:to_binary(z_context:get_q("name", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","strategy"]
                                 ,z_convert:to_binary(z_context:get_q("strategy", Context))
                                 ,Context),
    _ = case z_convert:to_binary(z_context:get_q("ringback", Context)) of
        <<>> -> modkazoo_util:delete_session_jobj_key('current_callflow', z_string:split(ElementId,"-")++["data","ringback"], Context);
        Ringback -> kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","ringback"], Ringback, Context)
    end,
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","endpoints"]
                                 ,kazoo_util:cf_build_ring_group_endpoints(Context)
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","timeout"]
                                 ,kazoo_util:cf_calculate_ring_group_timeout(Context)
                                 ,Context),
    z_render:dialog_close(Context);

event({postback,{cf_page_group_select,[{element_type,ElementType}]},_,_},Context) ->
    Selected = jiffy:decode(z_context:get_q("triggervalue", Context)),
    Context1 = z_render:insert_bottom("sorter"
                                     ,z_template:render("_cf_select_page_group_element.tpl"
                                                       ,[{selected_value,Selected},{element_type,ElementType}]
                                                       ,Context)
                                     ,Context),
    z_render:wire([{hide, [{target, "option_"++z_convert:to_list(modkazoo_util:get_value(<<"id">>,Selected))}]}], Context1);

event({submit,cf_select_page_group,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","name"]
                                 ,z_convert:to_binary(z_context:get_q("name", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","endpoints"]
                                 ,kazoo_util:cf_build_page_group_endpoints(Context)
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_menu,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_temporal_route,_,_}, Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","timezone"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_cidlistmatch,_,_}, Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data","id"]
                                 ,z_convert:to_binary(z_context:get_q("selected", Context))
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_check_cid,_,_}, Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = case modkazoo_util:get_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>]
                                    ,z_context:get_session('current_callflow', Context)
                                    ,?EMPTY_JSON_OBJECT)
        of
            ?EMPTY_JSON_OBJECT -> 'ok';
            _ -> kazoo_util:may_be_check_cid_children_clean(Context)
        end,
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,modkazoo_util:split_b(ElementId,"-")++["data","use_absolute_mode"]
                                 ,z_convert:to_atom(z_context:get_q("selected", Context))
                                 ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,modkazoo_util:split_b(ElementId,"-")++["data","regex"]
                                 ,z_convert:to_binary(z_context:get_q("regex", Context))
                                 ,Context),
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
            mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
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
            mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
            z_render:dialog_close(Context)
    end;

event({submit,cf_select_response,_,_},Context) ->
    lager:info("Response event variables: ~p", [z_context:get_q_all(Context)]),
    ElementId = z_context:get_q("element_id", Context),
    DataValues = modkazoo_util:filter_empty(
        [{<<"code">>, modkazoo_util:get_q_bin("code", Context)}
        ,{<<"message">>, modkazoo_util:get_q_bin("message", Context)}
        ,{<<"media">>, modkazoo_util:get_q_bin("selected", Context)}
        ]),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data"]
                                 ,modkazoo_util:set_values(DataValues, modkazoo_util:new())
                                 ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_disa,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    DataValues = modkazoo_util:filter_empty(
        [{<<"pin">>, modkazoo_util:get_q_bin("pin", Context)}
        ,{<<"use_account_caller_id">>, modkazoo_util:on_to_true(z_context:get_q("use_account_caller_id", Context))}
        ,{<<"preconnect_audio">>, modkazoo_util:get_q_bin("preconnect_audio", Context)}
        ,{<<"max_digits">>, modkazoo_util:get_q_bin("max_digits", Context)}
        ,{<<"retries">>, modkazoo_util:get_q_bin("retries", Context)}
        ,{<<"interdigit">>, modkazoo_util:get_q_bin("interdigit", Context)}
        ]),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data"]
                                 ,modkazoo_util:set_values(DataValues, modkazoo_util:new())
                                 ,Context),
    z_render:dialog_close(Context);

event({postback,{cf_load,_},_,_},Context) ->
    kazoo_util:cf_load_to_session(z_context:get_q("triggervalue", Context),Context),
    kazoo_util:cf_notes_flush(Context),
    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{cf_reload,_},_,_},Context) ->
    case modkazoo_util:get_value(<<"id">>,z_context:get_session('current_callflow', Context)) of
        'undefined' -> kazoo_util:cf_load_to_session("new", Context);
        CallflowId -> kazoo_util:cf_load_to_session(CallflowId, Context)
    end,
    kazoo_util:cf_notes_flush(Context),
    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
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
    mod_signal:emit({update_admin_portal_time_of_the_day_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_time_of_the_day_rule,[{rule_id,RuleId}]},_,_},Context) ->
    _ = kazoo_util:cf_delete_time_of_the_day_rule(RuleId,Context),
    mod_signal:emit({update_admin_portal_time_of_the_day_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{delete_prompt,[{prompt_id,PromptId}]},_,_},Context) ->
    _ = kazoo_util:kz_delete_prompt(PromptId,Context),
    mod_signal:emit({update_admin_portal_media_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{delete_menu,[{menu_id,MenuId}]},_,_},Context) ->
    _ = kazoo_util:kz_menu('delete',MenuId,Context),
    mod_signal:emit({update_admin_portal_menus_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit, add_new_media, _, _}, Context) ->
    _ = kazoo_util:upload_media(Context);

event({submit,kz_menu,_,_},Context) ->
    lager:info("kz_menu event variables: ~p", [z_context:get_q_all(Context)]),
    _ = kazoo_util:kz_menu(Context),
    mod_signal:emit({update_admin_portal_menus_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({submit,cf_select_prepend_cid,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","action"], <<"prepend">>, Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                  ,z_string:split(ElementId,"-")++["data","caller_id_name_prefix"]
                                  ,z_convert:to_binary(z_context:get_q("caller_id_name_prefix", Context))
                                  ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                  ,z_string:split(ElementId,"-")++["data","caller_id_number_prefix"]
                                  ,z_convert:to_binary(z_context:get_q("caller_id_number_prefix", Context))
                                  ,Context),
    z_render:dialog_close(Context);

event({submit,cf_select_set_cid,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                  ,z_string:split(ElementId,"-")++["data","caller_id_name"]
                                  ,z_convert:to_binary(z_context:get_q("caller_id_name", Context))
                                  ,Context),
    _ = kazoo_util:cf_set_session('current_callflow'
                                  ,z_string:split(ElementId,"-")++["data","caller_id_number"]
                                  ,z_convert:to_binary(z_context:get_q("caller_id_number", Context))
                                  ,Context),
    z_render:dialog_close(Context);

event({submit,kz_vmbox,_,_},Context) ->
    _ = kazoo_util:kz_vmbox(Context),
    mod_signal:emit({update_admin_portal_vms_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_vmbox,[{vmbox_id,VmboxId}]},_,_},Context) ->
    _ = kazoo_util:kz_vmbox('delete',VmboxId,Context),
    mod_signal:emit({update_admin_portal_vms_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,kz_conference,_,_},Context) ->
    _ = kazoo_util:kz_conference(Context),
    mod_signal:emit({update_admin_portal_conferences_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_conference,[{conference_id,ConferenceId}]},_,_},Context) ->
    _ = kazoo_util:kz_conference('delete',ConferenceId,Context),
    mod_signal:emit({update_admin_portal_conferences_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,cf_select_conference,_,_},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    case z_context:get_q("selected", Context) of
        [] -> 
            _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data"], ?EMPTY_JSON_OBJECT, Context);
        Id -> 
            _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data","id"], z_convert:to_binary(Id), Context)
    end,
    z_render:dialog_close(Context);

event({submit,cf_select_eavesdrop,<<"form_cf_select_eavesdrop">>,<<"form_cf_select_eavesdrop">>},Context) ->
    ElementId = z_context:get_q("element_id", Context),
    TargetType = z_convert:to_binary(z_context:get_q("target_type", Context)++"_id"),
    ApprovedType = z_convert:to_binary("approved_"++z_context:get_q("approved_type", Context)++"_id"),
    TargetSelected = modkazoo_util:get_value(<<"id">>,jiffy:decode(z_context:get_q("target_selected", Context))),
    ApprovedSelected = modkazoo_util:get_value(<<"id">>,jiffy:decode(z_context:get_q("approved_selected", Context))),
    _ = kazoo_util:cf_set_session('current_callflow'
                                 ,z_string:split(ElementId,"-")++["data"]
                                 ,{[{TargetType,TargetSelected},{ApprovedType,ApprovedSelected}]}
                                 ,Context),
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
    mod_signal:emit({signal_featurecode_voicemail_check, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_voicemail_direct,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_voicemail_direct(Context),
    mod_signal:emit({signal_featurecode_voicemail_direct, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_park_and_retrieve,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_park_and_retrieve(Context),
    mod_signal:emit({signal_featurecode_park_and_retrieve, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_park_valet,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_park_valet(Context),
    mod_signal:emit({signal_featurecode_park_valet, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_park_retrieve,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_park_retrieve(Context),
    mod_signal:emit({signal_featurecode_park_retrieve, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_intercom,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_intercom(Context),
    mod_signal:emit({signal_featurecode_intercom, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_privacy,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_privacy(Context),
    mod_signal:emit({signal_featurecode_privacy, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_hotdesk_enable,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_hotdesk_enable(Context),
    mod_signal:emit({signal_featurecode_hotdesk_enable, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_hotdesk_disable,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_hotdesk_disable(Context),
    mod_signal:emit({signal_featurecode_hotdesk_disable, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_hotdesk_toggle,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_hotdesk_toggle(Context),
    mod_signal:emit({signal_featurecode_hotdesk_toggle, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_activate,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_activate(Context),
    mod_signal:emit({signal_featurecode_call_forward_activate, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_deactivate,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_deactivate(Context),
    mod_signal:emit({signal_featurecode_call_forward_deactivate, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_toggle,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_toggle(Context),
    mod_signal:emit({signal_featurecode_call_forward_toggle, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_featurecode_call_forward_update,_,_}, Context) ->
    _ = kazoo_util:toggle_featurecode_call_forward_update(Context),
    mod_signal:emit({signal_featurecode_call_forward_update, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,set_featurecode_dynamic_cid,_,_}, Context) ->
    _ = kazoo_util:set_featurecode_dynamic_cid(z_context:get_q("dynamic_cid_list_id",Context), Context),
    mod_signal:emit({signal_featurecode_dynamic_cid, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,set_featurecode_eavesdrop,_,_}, Context) ->
    _ = kazoo_util:set_featurecode_eavesdrop(z_context:get_q("eavesdrop_approved_list_id",Context)
                                            ,z_context:get_q("eavesdrop_target_list_id",Context)
                                            ,Context),
    mod_signal:emit({signal_featurecode_eavesdrop, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,delete_featurecode_dynamic_cid,_,_}, Context) ->
    _ = kazoo_util:delete_featurecode(<<"dynamic_cid">>, Context),
    mod_signal:emit({signal_featurecode_dynamic_cid, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,delete_featurecode_eavesdrop,_,_}, Context) ->
    _ = kazoo_util:delete_featurecode(<<"eavesdrop_feature">>, Context),
    mod_signal:emit({signal_featurecode_eavesdrop, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{toggle_blacklist_member,[{blacklist_id,BlacklistId}]},_,_}, Context) ->
    _ = kazoo_util:toggle_blacklist_member(BlacklistId,Context),
    mod_signal:emit({update_admin_portal_blacklists_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,toggle_all_calls_recording,_,_}, Context) ->
    _ = kazoo_util:toggle_all_calls_recording(Context),
    z_render:update("all_calls_recording_enabled", z_template:render("_all_calls_recording.tpl", [], Context), Context);

event({postback,<<"add_blacklisted_number">>,_,_},Context) ->
    case z_context:get_q('new_blacklisted_number',Context) of
        <<>> ->
            Context;
        Number ->
            z_render:insert_top("blacklisted_numbers_list"
                               ,z_template:render("_blacklisted_number.tpl"
                                                 ,[{blacklisted_number, modkazoo_util:cleanout(Number)}
                                                  ,{blacklisted_description
                                                   ,z_context:get_q('new_blacklisted_description', Context)}
                                                  ]
                                                 ,Context)
                               ,Context) 
    end;

event({submit,add_new_blacklist,_,_},Context) ->
    _ = kazoo_util:set_blacklist_doc(z_context:get_q("blacklist_id", Context)
                                    ,z_context:get_q("blacklist_name", Context)
                                    ,z_context:get_q_all("blacklisted_number", Context)
                                    ,Context),
    mod_signal:emit({update_admin_portal_blacklists_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_blacklist,[{blacklist_id,BlacklistId}]},_,_},Context) ->
    _ = kazoo_util:kz_delete_blacklist(BlacklistId,Context),
    mod_signal:emit({update_admin_portal_blacklists_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,<<"rs_child_selected">>,_,_},Context) ->
    AccountId =  z_context:get_q("triggervalue", Context),
    _ = z_session:set('rs_selected_account_id', AccountId, Context),
    z_transport:session(javascript, <<"z_reload();">>, [{qos, 1}], Context),
    Context;

event({postback,{rs_account_delete,[{account_id,AccountId}]},_,_},Context) ->
    spawn(kazoo_util,rs_delete_account,[AccountId,Context]),
    z_render:wire({mask, [{target_id, "child_sandbox"}]}, Context);

event({postback,{'rs_account_mask',[{'account_id',AccountIdRaw}]},_,_},Context) ->
    KazooOwnerId = z_convert:to_binary(z_context:get_q("triggervalue", Context)),
    AccountId = z_convert:to_binary(AccountIdRaw),
    z_context:set_session('kazoo_owner_id', KazooOwnerId, Context),
    modkazoo_util:set_session_jobj('kazoo_reseller_user_tracking', AccountId, KazooOwnerId, ?EMPTY_JSON_OBJECT, Context),
    z_context:set_session('kazoo_account_id', AccountId, Context),
    z_context:set_session('rs_selected_account_id', 'undefined', Context),
    z_context:set_session('kazoo_account_name','undefined',Context),
    z_context:set_session('account_realm','undefined',Context),
    z_context:set_session('current_callflow','undefined',Context),
    z_context:set_session('user_timezone', 'undefined', Context),
    _ = modkazoo_auth:refresh_superadmin_and_reseller_flags(Context),
    _ = modkazoo_auth:may_be_add_third_party_billing(Context),
    _ = modkazoo_auth:may_be_set_user_data(Context),
    _ = modkazoo_auth:set_session_currency_sign(Context),
    modkazoo_auth:choose_page_to_redirect(Context);

event({postback,<<"rs_account_demask">>,_,_},Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AccountDoc = kazoo_util:kz_get_acc_doc_by_account_id(AccountId, Context),
    ResellerId = modkazoo_util:get_value(<<"reseller_id">>, AccountDoc),
    z_context:set_session('kazoo_owner_id', modkazoo_util:get_session_jobj_value('kazoo_reseller_user_tracking', ResellerId, Context), Context),
    z_context:set_session('kazoo_account_id', ResellerId, Context),
    z_context:set_session('rs_selected_account_id', AccountId, Context),
    z_context:set_session('kazoo_account_name','undefined',Context),
    z_context:set_session('account_realm','undefined',Context),
    z_context:set_session('current_callflow','undefined',Context),
    z_context:set_session('user_timezone', 'undefined', Context),
    _ = modkazoo_auth:refresh_superadmin_and_reseller_flags(Context),
    _ = modkazoo_auth:may_be_clean_third_party_billing(Context),
    _ = modkazoo_auth:may_be_set_user_data(Context),
    _ = modkazoo_auth:may_be_add_third_party_billing(Context),
    _ = modkazoo_auth:set_session_currency_sign(Context),
    z_render:wire({redirect, [{dispatch, "reseller_portal"}]}, Context);

event({submit,{addcccpcidform, _}, _, _}, Context) ->
    NewAuthCID = z_convert:to_binary(z_context:get_q("cid_number", Context)),
    UserId = z_convert:to_binary(z_context:get_q("user_id", Context)),
    _ = kazoo_util:add_cccp_doc({<<"cid">>, NewAuthCID}, {<<"user_id">>, UserId}, Context),
    z_render:wire({redirect, [{dispatch, "callback"}]}, Context);

event({submit,{addcccppinform, _}, _, _}, Context) ->
    NewAuthPIN = z_convert:to_binary(z_context:get_q("pin_number", Context)),
    UserId = z_convert:to_binary(z_context:get_q("user_id", Context)),
    _ = kazoo_util:add_cccp_doc({<<"pin">>, NewAuthPIN}, {<<"user_id">>, UserId}, Context),
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
            z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context1), Context1)
    end;

event({submit,kz_trunk_server,_,_},Context) ->
    _ = kazoo_util:kz_trunk_server(Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_trunk,[{trunk_id,TrunkId},{server_index,Index}]},_,_}, Context) ->
    kazoo_util:kz_trunk_server_delete(TrunkId, Index, Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,manage_trunk_numbers,_,_}, Context) ->
    _ = kazoo_util:kz_trunk_server_numbers(Context),
    z_render:dialog_close(Context);

event({postback,{flush_registration_by_username,[{sip_username, Username}]},_,_}, Context) ->
    _ = kazoo_util:kz_flush_registration_by_username(Username, Context),
    mod_signal:emit({update_admin_portal_devices_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{flush_pbx_registration_by_username,[{sip_username, Username}]},_,_}, Context) ->
    _ = kazoo_util:kz_flush_registration_by_username(Username, Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,kz_webhook,_,_},Context) ->
    _ = kazoo_util:kz_webhook(Context),
    mod_signal:emit({update_admin_portal_webhooks_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_webhook,[{webhook_id, WebhookId}]},_,_},Context) ->
    _ = kazoo_util:kz_webhook_delete(WebhookId, Context),
    mod_signal:emit({update_admin_portal_webhooks_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{toggle_webhook,[{webhook_id,WebhookId}]},_,_}, Context) ->
    _ = kazoo_util:kz_webhook_toggle(WebhookId, Context),
    mod_signal:emit({update_admin_portal_webhooks_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,refresh_user_callstats,_,_}, Context) ->
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    {CreatedFrom, CreatedTo} =
        case modkazoo_util:get_q_bin(<<"selected_billing_period">>, Context) of
            <<"today">> -> {modkazoo_util:today_begins_tstamp(Context)
                           ,modkazoo_util:today_ends_tstamp(Context)};
            <<"7_days">> ->
                {modkazoo_util:week_ago_tstamp(Context)
                ,modkazoo_util:current_tstamp(Context)};
            <<"this_month">> ->
                modkazoo_util:curr_month_range();
            <<"range">> ->
                CrFr = modkazoo_util:datepick_to_tstamp(modkazoo_util:get_q_bin("callstatsdayFrom",Context)),
                CrTo = modkazoo_util:datepick_to_tstamp_end_day(modkazoo_util:get_q_bin("callstatsdayTo",Context)),
                case (CrTo - CrFr) > (?SECONDS_IN_DAY * 30) of
                    'false' -> {CrFr, CrTo};
                    'true' ->
                        mod_signal:emit({emit_growl_signal
                                        ,?SIGNAL_FILTER(Context)
                                         ++ [{'text',?__("30 days range max...", Context)},{'type', 'error'}]}
                                       ,Context),
                        {CrFr, CrFr + (?SECONDS_IN_DAY * 30) - 1}
                end
        end,
    mod_signal:emit({update_user_portal_call_history_tpl
                    ,?SIGNAL_FILTER(Context)
                     ++ [{created_from, CreatedFrom}
                        ,{created_to, CreatedTo}
                        ,{selected_billing_period, z_context:get_q("selected_billing_period",Context)}
                        ,{callstatsdayFrom, z_context:get_q("callstatsdayFrom",Context)}
                        ,{callstatsdayTo, z_context:get_q("callstatsdayTo",Context)}
                        ]
                    }
                   ,Context),
    Context;

event({postback,refresh_admin_callstats,_,_}, Context) ->
    {CreatedFrom, CreatedTo} =
        case modkazoo_util:get_q_bin(<<"selected_billing_period">>, Context) of
            <<"today">> -> {modkazoo_util:today_begins_tstamp(Context)
                           ,modkazoo_util:today_ends_tstamp(Context)};
            <<"7_days">> ->
                {modkazoo_util:week_ago_tstamp(Context)
                ,modkazoo_util:current_tstamp(Context)};
            <<"this_month">> ->
                modkazoo_util:curr_month_range();
            <<"range">> ->
                CrFr = modkazoo_util:datepick_to_tstamp(modkazoo_util:get_q_bin("callstatsdayFrom",Context)),
                CrTo = modkazoo_util:datepick_to_tstamp_end_day(modkazoo_util:get_q_bin("callstatsdayTo",Context)),
                case (CrTo - CrFr) > (?SECONDS_IN_DAY * 30) of
                    'false' -> {CrFr, CrTo};
                    'true' ->
                        mod_signal:emit({emit_growl_signal
                                        ,?SIGNAL_FILTER(Context)
                                         ++ [{'text',?__("30 days range max...", Context)},{'type', 'error'}]}
                                       ,Context),
                        {CrFr, CrFr + (?SECONDS_IN_DAY * 30) - 1}
                end
        end,
    mod_signal:emit({update_admin_portal_call_history_tpl
                    ,?SIGNAL_FILTER(Context)
                     ++ [{created_from, CreatedFrom}
                        ,{created_to, CreatedTo}
                        ,{selected_billing_period, z_context:get_q("selected_billing_period",Context)}
                        ,{callstatsdayFrom, z_context:get_q("callstatsdayFrom",Context)}
                        ,{callstatsdayTo, z_context:get_q("callstatsdayTo",Context)}
                        ]
                    }
                   ,Context),
    Context;


event({postback,{global_carrier_routing,[{account_id,AccountId}]},_,_}, Context) ->
    _ = kazoo_util:set_global_carrier_routing(AccountId, Context),
    z_render:update("rs_outbound_routing", z_template:render("_rs_outbound_routing.tpl", [{account_id, AccountId}], Context), Context);

event({postback,reseller_based_routing,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    ResellerId = case kazoo_util:kz_current_context_reseller_status(Context) of
        'true' -> z_context:get_session(kazoo_account_id, Context);
        _ -> kazoo_util:kz_current_context_reseller_id(Context)
    end,
    case ResellerId == kazoo_util:super_account_id(Context) of
        'true' ->
            _ = kazoo_util:set_global_carrier_routing(AccountId, Context);
        'false' ->
            _ = kazoo_util:set_reseller_based_routing(ResellerId, AccountId, Context)
    end,
    mod_signal:emit({update_reseller_portal_resources_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:update("account_outbound_routing_selection", z_template:render("_account_outbound_routing_selection.tpl", [], Context), Context);

event({postback,{reseller_based_routing,[{account_id,AccountId}]},_,_}, Context) ->
    ResellerId = case kazoo_util:kz_current_context_reseller_status(Context) of
        'true' -> z_context:get_session(kazoo_account_id, Context);
        _ -> kazoo_util:kz_current_context_reseller_id(Context)
    end,
    case ResellerId == kazoo_util:super_account_id(Context) of
        'true' ->
            _ = kazoo_util:set_global_carrier_routing(AccountId, Context);
        'false' ->
            _ = kazoo_util:set_reseller_based_routing(ResellerId, AccountId, Context)
    end,
    z_render:update("rs_outbound_routing", z_template:render("_rs_outbound_routing.tpl", [{account_id, AccountId}], Context), Context);

event({postback,account_based_routing,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    _ = kazoo_util:set_account_based_routing(AccountId, Context),
    mod_signal:emit({update_reseller_portal_resources_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:update("account_outbound_routing_selection", z_template:render("_account_outbound_routing_selection.tpl", [], Context), Context);

event({postback,{account_based_routing,[{account_id,AccountId}]},_,_}, Context) ->
    _ = kazoo_util:set_account_based_routing(AccountId, Context),
    z_render:update("rs_outbound_routing", z_template:render("_rs_outbound_routing.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{delete_resource,[{resource_id,ResourceId}]},_,_}, Context) ->
    _ = kazoo_util:kz_resource_delete(ResourceId, Context),
    mod_signal:emit({update_reseller_portal_resources_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{toggle_resource,[{resource_id,ResourceId}]},_,_},Context) ->
    _ = kazoo_util:toggle_resource(ResourceId, Context),
    mod_signal:emit({update_reseller_portal_resources_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,resource_form,_,_}, Context) ->
    _ = kazoo_util:resource(Context),
    mod_signal:emit({update_reseller_portal_resources_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({submit,add_new_list,_,_}, Context) ->
    _ = kazoo_util:account_list(Context),
    mod_signal:emit({update_admin_portal_lists_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_list,[{list_id, ListId}]},_,_}, Context) ->
    _ = kazoo_util:delete_account_list(ListId, Context),
    mod_signal:emit({update_admin_portal_lists_tpl, ?SIGNAL_FILTER(Context)}, Context);

event({submit,account_list_entries,_,_}, Context) ->
    ListId = z_context:get_q("list_id", Context),
    ListType = z_convert:to_binary(z_context:get_q("list_type", Context)),
    TemplateName = z_context:get_q("template_name", Context),
    _ = kazoo_util:kz_account_list_add_entry(ListType, ListId, Context),
    z_render:update("list_entries_div", z_template:render(TemplateName, [{list_id, ListId}], Context), Context);

event({postback,{delete_account_list_entry,[{list_id,ListId},{entry_id,EntryId},{template_name, TemplateName}]},_,_}, Context) ->
    _ = kazoo_util:delete_account_list_entry(EntryId, ListId, Context),
    z_render:update("list_entries_div", z_template:render(TemplateName, [{list_id, ListId}], Context), Context);

event({postback,conference_selected,_,_},Context) ->
    ConferenceId = z_context:get_q("triggervalue", Context),
    _ = z_session:set('selected_conference_id', ConferenceId, Context),
    z_render:update("child_sandbox", z_template:render("conference_info.tpl", [], Context), Context);

event({submit,sendmail_test_notification,_,_}, Context) ->
    Email = z_context:get_q("chosen_email", Context),
    AccountId = z_context:get_session(kazoo_account_id, Context),
    NotificationId = z_context:get_q("notification_id", Context),
    _ = kazoo_util:sendmail_test_notification(Email, AccountId, NotificationId, Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({submit,edit_notification_html,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    NotificationId = z_context:get_q("notification_id", Context),
    CurrNotifyDoc = kazoo_util:kz_notification_info(NotificationId, Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            Plain = kazoo_util:kz_notification_template("text/plain", NotificationId, AccountId, Context),
            _ = kazoo_util:kz_save_notification_template("text/plain", NotificationId, AccountId, Plain, Context);
        _ -> 'ok'
    end,
    MessageBody = z_context:get_q("html_body", Context),
    _ = kazoo_util:kz_save_notification_template("text/html", NotificationId, AccountId, MessageBody, Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({submit,edit_notification_text,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    NotificationId = z_context:get_q("notification_id", Context),
    CurrNotifyDoc = kazoo_util:kz_notification_info(NotificationId, Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            HTML = kazoo_util:kz_notification_template("text/html", NotificationId, AccountId, Context),
            _ = kazoo_util:kz_save_notification_template("text/html", NotificationId, AccountId, HTML, Context);
        _ -> 'ok'
    end,
    MessageBody = z_context:get_q("text_body", Context),
    _ = kazoo_util:kz_save_notification_template("text/plain", NotificationId, AccountId, MessageBody, Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{remove_notification_template,[{notification_id,NotificationId}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    _ = kazoo_util:kz_delete_notification_template(NotificationId, AccountId, Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,add_conf_participant,_,_}, Context) ->
    kazoo_util:add_conf_participant(Context);

event({postback,start_outbound_conference,_,_}, Context) ->
    kazoo_util:start_outbound_conference(Context);

event({postback,{do_conference_action,[{action, Action},{conference_id,ConferenceId}]},_,_}, Context) ->
    _ = kazoo_util:do_conference_action(Action, ConferenceId, Context),
    Context;

event({postback,{do_conference_participant_action,[{action, Action},{participant_id,ParticipantId},{conference_id,ConferenceId}]},_,_}, Context) ->
    _ = kazoo_util:do_conference_participant_action(Action, ParticipantId, ConferenceId, Context),
    Context;

event({postback,add_conference_participants_table_line,_,_}, Context) ->
    ConferenceId = z_context:get_q(conference_id, Context),
    ParticipantId = z_context:get_q(participant_id, Context),
    Participant = kazoo_util:kz_conference_participant(ParticipantId,ConferenceId,Context),
    z_render:insert_top("conference_current_participants_table_tbody"
                   ,z_template:render("_conference_participants_table_line.tpl"
                                     ,[{participant_id,ParticipantId},{conference_id,ConferenceId},{participant,Participant}]
                                     ,Context)
                   ,Context);

event({postback,update_conference_participants_table_line,_,_}, Context) ->
    ConferenceId = z_context:get_q(conference_id, Context),
    ParticipantId = z_context:get_q(participant_id, Context),
    Participant = kazoo_util:kz_conference_participant(ParticipantId,ConferenceId,Context),
    z_render:replace("participants_table_line_id_" ++ z_convert:to_list(ParticipantId)
                   ,z_template:render("_conference_participants_table_line.tpl"
                                     ,[{participant_id,ParticipantId},{conference_id,ConferenceId},{participant,Participant}]
                                     ,Context)
                   ,Context);

event({postback,maybe_update_conference_participants_headline,_,_}, Context) ->
    ConferenceId = z_context:get_q(conference_id, Context),
    EventName = z_context:get_q(event_name, Context),
    kazoo_util:maybe_update_conference_participants_headline(EventName, ConferenceId, Context),
    Context;

event({postback,{channel_hangup,[{channel_id,ChannelId}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    _ = kazoo_util:kz_channel_hangup(ChannelId, AccountId, Context),
    z_render:dialog_close(Context);

event({postback,{channel_hangup_confirm,[{channel_id,ChannelId}]},_,_}, Context) ->
    z_render:dialog(?__("Please confirm ",Context), "_confirm_channel_hangup.tpl", [{channel_id, ChannelId}], Context);

event({postback,channel_hangup_confirm,_,_}, Context) ->
    ChannelId = z_context:get_q("channel_id", Context),
    z_render:dialog(?__("Please confirm ",Context), "_confirm_channel_hangup.tpl", [{channel_id, ChannelId}], Context);

event({postback,{channel_eavesdrop_dialog,[{channel_id,ChannelId}]},_,_}, Context) ->
    z_render:dialog(?__("Please choose device to eavesdrop with ",Context), "_channel_eavesdrop_dialog.tpl", [{channel_id, ChannelId}], Context);

event({postback,channel_eavesdrop_dialog,_,_}, Context) ->
    ChannelId = z_context:get_q("channel_id", Context),
    z_render:dialog(?__("Please choose device to eavesdrop with ",Context), "_channel_eavesdrop_dialog.tpl", [{channel_id, ChannelId}], Context);

event({postback,{channel_eavesdrop,[{channel_id,ChannelId}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    Id = z_context:get_q("id", Context),
    Mode = z_context:get_q("mode", Context),
    _ = kazoo_util:kz_channel_eavesdrop(Id, Mode, ChannelId, AccountId, Context),
    z_render:dialog_close(Context);

event({postback,{channel_transfer_dialog,[{channel_id,ChannelId}]},_,_}, Context) ->
    z_render:dialog(?__("Please select callflow to transfer chosen leg to ",Context)
                   ,"_channel_transfer_dialog.tpl"
                   ,[{channel_id, ChannelId}]
                   ,Context);

event({postback,channel_transfer_dialog,_,_}, Context) ->
    ChannelId = z_context:get_q("channel_id", Context),
    z_render:dialog(?__("Please select callflow to transfer chosen leg to ",Context)
                   ,"_channel_transfer_dialog.tpl"
                   ,[{channel_id, ChannelId}]
                   ,Context);

event({postback,{channel_transfer,[{channel_id,ChannelId}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    Target = z_context:get_q("target", Context),
    _ = kazoo_util:kz_channel_transfer(Target, ChannelId, AccountId, Context),
    z_render:dialog_close(Context);

event({postback,{sync_trunkstore_realms,[{account_id, AccountId}]},_,_}, Context) ->
    _ = kazoo_util:sync_trunkstore_realms(AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{ts_trunk_disable,[{trunk_id,TrunkId},{server_index,Index}]},_,_}, Context) ->
    _ = kazoo_util:ts_trunk_disable(Index, TrunkId, Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, ?SIGNAL_FILTER(Context)}, Context);

event({postback,{ts_trunk_enable,[{trunk_id,TrunkId},{server_index,Index}]},_,_}, Context) ->
    _ = kazoo_util:ts_trunk_enable(Index, TrunkId, Context),
    mod_signal:emit({update_admin_portal_trunk_list_tpl, ?SIGNAL_FILTER(Context)}, Context);

event({submit,kz_c2call,_,_},Context) ->
    _ = kazoo_util:kz_c2call(Context),
    mod_signal:emit({update_admin_portal_c2call_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{delete_c2call,[{c2call_id, C2CallId}]},_,_}, Context) ->
    _ = kazoo_util:kz_c2call('delete',C2CallId,Context),
    mod_signal:emit({update_admin_portal_c2call_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,kz_purge_voicemails,_,_}, Context) ->
    Count = kazoo_util:kz_purge_voicemails(z_convert:to_binary(z_context:get_q("vmbox_id", Context))
                                          ,z_convert:to_binary(z_context:get_q("days_to", Context))
                                          ,Context),
    case Count > 2 of
        'true' ->
            modkazoo_util:delay_signal(Count, 'user_portal_voicemails_tpl', ?SIGNAL_FILTER(Context), Context),
            Context1 = z_render:growl(?__("Messages removal started", Context), Context);
        'false' ->
            Context1 = z_render:growl(?__("No messages to remove", Context), Context)
    end,
    z_render:dialog_close(Context1);

event({submit,kz_notifications,_,_}, Context) ->
    _ = kazoo_util:kz_notifications(Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    z_render:dialog_close(Context);

event({postback,{enable_notification,[{notification_id,NotificationId}]},_,_}, Context) ->
    _ = kazoo_util:kz_notification_toggle('true', NotificationId, Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{disable_notification,[{notification_id,NotificationId}]},_,_}, Context) ->
    _ = kazoo_util:kz_notification_toggle('false', NotificationId, Context),
    mod_signal:emit({update_reseller_portal_notifications_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({submit,rs_send_message,_,_}, Context) ->
    _ = modkazoo_notify:rs_send_message(Context),
    z_render:dialog_close(Context);

event({submit,rs_kz_customer_update,_,_}, Context) ->
    _ = modkazoo_notify:rs_kz_customer_update(Context),
    z_render:dialog_close(Context);

event({postback,{toggle_account_status,[{account_id,AccountId}]},_,_}, Context) ->
    kazoo_util:kz_toggle_account_status(AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{toggle_reseller_status,[{account_id,AccountId}]},_,_}, Context) ->
    kazoo_util:kz_toggle_reseller_status(AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{toggle_services_status,[{account_id,AccountId}]},_,_}, Context) ->
    kazoo_util:toggle_services_status(AccountId, Context),
    mod_signal:emit({update_onbill_account_details, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,add_account_ip_acl_entry,_,_}, Context) ->
    case z_context:get_q("new_ip_entry",Context) of
        [] -> Context;
        IP_Entry ->
            z_render:insert_top("account_ip_acl_entries_list"
                                ,z_template:render("_account_ip_acl_entry.tpl",[{account_ip_acl_entry,z_convert:to_binary(IP_Entry)}],Context)
                                ,Context
                               ) 
    end;

event({submit,add_account_ip_acl,_,_}, Context) ->
    case z_context:get_q_all("ip_acl_entry", Context) of
        [] ->
            _ = kazoo_util:kz_set_acc_doc(<<"crossbar_ip_acl">>, 'undefined', Context);
        IP_ACL_Entries ->
            _ = kazoo_util:kz_set_acc_doc(<<"crossbar_ip_acl">>, lists:map(fun(X) -> z_convert:to_binary(X) end, IP_ACL_Entries), Context)
    end,
    z_render:dialog_close(Context);

event({submit,add_account_sip_acl,_,_}, Context) ->
    case z_context:get_q_all("ip_acl_entry", Context) of
        [] ->
            _ = kazoo_util:kz_account_access_lists('delete', [], Context);
        IP_ACL_Entries ->
            Props = [{<<"order">>, ?TO_BIN(z_context:get_q("sip_access_lists_order", Context))}
                    ,{<<"cidrs">>, lists:map(fun(X) -> z_convert:to_binary(X) end, IP_ACL_Entries)}],
            DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
            _ = kazoo_util:kz_account_access_lists('post', DataBag, Context)
    end,
    z_render:dialog_close(Context);

event({submit,add_device_sip_acl,_,_}, Context) ->
    DeviceId = z_context:get_q("device_id", Context),
    case z_context:get_q_all("ip_acl_entry", Context) of
        [] ->
            _ = kazoo_util:kz_device_access_lists('delete', DeviceId, [], Context);
        IP_ACL_Entries ->
            Props = [{<<"order">>, ?TO_BIN(z_context:get_q("sip_access_lists_order", Context))}
                    ,{<<"cidrs">>, lists:map(fun(X) -> z_convert:to_binary(X) end, IP_ACL_Entries)}],
            DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
            _ = kazoo_util:kz_device_access_lists('post', DeviceId, DataBag, Context)
    end,
    z_render:dialog_close(Context);

event({submit,add_credit,_,_}, Context) ->
    lager:info("add_credit event variables: ~p", [z_context:get_q_all(Context)]),
    Amount = z_context:get_q("credit_amount", Context),
    AccountId = z_context:get_q("account_id", Context),
    Description = z_context:get_q("credit_description", Context),
    Reason = z_context:get_q("credit_reason", Context),
    [_Day, _Month, _Year] = string:tokens(z_context:get_q("credit_date", Context),"/"),
    kazoo_util:kz_transactions_credit(<<"free">>, Amount, Reason, Description, AccountId, Context),
    modkazoo_util:delay_signal(3 ,'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
    z_render:dialog_close(Context);

event({submit,add_debit,_,_}, Context) ->
    Amount = z_context:get_q("debit_amount", Context),
    AccountId = z_context:get_q("account_id", Context),
    Description = z_context:get_q("debit_description", Context),
    Reason = z_context:get_q("debit_reason", Context),
    kazoo_util:kz_transactions_debit(Amount, Reason, Description, AccountId, Context),
    modkazoo_util:delay_signal(3 ,'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
    z_render:dialog_close(Context);

event({postback,{add_chosen_service_plan,[{account_id,AccountId}]},_,_}, Context) ->
    PlanId = z_context:get_q("selected_service_plan", Context),
    _ = kazoo_util:add_service_plan(PlanId, AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{remove_service_plan_from_account,[{account_id,AccountId},{service_plan_id,PlanId}]},_,_}, Context) ->
    kazoo_util:remove_service_plan_from_account(PlanId, AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{sync_account_services,[{account_id,AccountId}]},_,_}, Context) ->
    _ = kazoo_util:sync_service_plans(AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,{reconcile_account_services,[{account_id,AccountId}]},_,_}, Context) ->
    _ = kazoo_util:reconcile_service_plans(AccountId, Context),
    z_render:update("child_sandbox", z_template:render("_child_info.tpl", [{account_id, AccountId}], Context), Context);

event({postback,[{notify_submit_btn,[{account_id, 'undefined'}]}],_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,[{notify_submit_btn,[{account_id, AccountId}]}],<<>>,<<>>}, Context);
event({postback,[{notify_submit_btn,[{account_id, AccountId}]}],_,_}, Context) ->
    Blevel = z_context:get_q("balance",Context),
    _ = kazoo_util:kz_set_acc_doc([<<"notifications">>, <<"low_balance">>, <<"threshold">>], z_convert:to_float(Blevel), AccountId, Context),
    _ = kazoo_util:kz_set_acc_doc([<<"notifications">>, <<"low_balance">>, <<"enabled">>], 'true', AccountId, Context),
    z_render:update("set_notify_level_tpl", z_template:render("_set_notify_level.tpl", [{'account_id', AccountId}], Context), Context);

event({postback,[{notify_disable_btn,[{account_id,'undefined'}]}],_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,[{notify_disable_btn,[{account_id,AccountId}]}],<<>>,<<>>}, Context);
event({postback,[{notify_disable_btn,[{account_id,AccountId}]}],_,_}, Context) ->
    _ = kazoo_util:kz_set_acc_doc([<<"notifications">>, <<"low_balance">>, <<"enabled">>], 'false', AccountId, Context),
    z_render:update("set_notify_level_tpl", z_template:render("_set_notify_level.tpl", [{'account_id', AccountId}], Context), Context);

event({postback,toggle_show_legs_status,_,_}, Context) ->
    case z_context:get_session('show_cdr_legs', Context) of
        'true' ->
            z_context:set_session('show_cdr_legs', 'false', Context),
            mod_signal:emit({update_admin_portal_call_details_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Routines = [fun(J) -> z_render:wire([{set_class, [{target, "show_legs_toggler"},{class,"fa fa-toggle-off pointer pull-right"}]}], J) end
                       ,fun(J) -> z_render:wire([{fade_in, [{target, "admin_portal_call_details_tpl"}]}], J) end],
            lists:foldl(fun(F, J) -> F(J) end, Context, Routines);
        _ ->
            z_context:set_session('show_cdr_legs', 'true', Context),
            mod_signal:emit({update_admin_portal_call_details_tpl, ?SIGNAL_FILTER(Context)}, Context),
            Routines = [fun(J) -> z_render:wire([{set_class, [{target, "show_legs_toggler"},{class,"fa fa-toggle-on pointer pull-right"}]}], J) end
                       ,fun(J) -> z_render:wire([{fade_out, [{target, "admin_portal_call_details_tpl"}]}], J) end],
            lists:foldl(fun(F, J) -> F(J) end, Context, Routines)
    end;

event({postback,{cccp_field_toggler,[{doc_id,DocId},{field_name,FieldName},{signal_id,SignalId}]},_,_}, Context) ->
    _ = kazoo_util:cccp_field_toggler(DocId, FieldName, Context),
    mod_signal:emit({z_convert:to_atom(SignalId), ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{delete_allotment_element,[{account_id,'undefined'},{allotment_element_name,AllotmentElementName}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,{delete_allotment_element,[{account_id,AccountId},{allotment_element_name,AllotmentElementName}]},<<>>,<<>>}, Context);
event({postback,{delete_allotment_element,[{account_id,AccountId},{allotment_element_name,AllotmentElementName}]},_,_}, Context) ->
    _ = kazoo_util:allotment_element_delete(AllotmentElementName, AccountId, Context),
    z_render:update("restrictions_pannel_div",z_template:render("_allotments.tpl",[{account_id,AccountId}],Context),Context);

event({postback,{add_allotment_element,[{account_id,'undefined'}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,{add_allotment_element,[{account_id,AccountId}]},<<>>,<<>>}, Context);
event({postback,{add_allotment_element,[{account_id,AccountId}]},_,_}, Context) ->
    AllotmentElementName = z_context:get_q("new_allotment_element_name",Context),
    _ = kazoo_util:allotment_element_add(AllotmentElementName, AccountId, Context),
    z_render:update("restrictions_pannel_div",z_template:render("_allotments.tpl",[{account_id,AccountId}],Context),Context);

event({postback,{save_allotment_field,[{field_name,FieldName},{allotment_name,AllotmentElementName},{account_id,'undefined'}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,{save_allotment_field,[{field_name,FieldName},{allotment_name,AllotmentElementName},{account_id,AccountId}]},<<>>,<<>>}, Context);
event({postback,{save_allotment_field,[{field_name,FieldName},{allotment_name,AllotmentElementName},{account_id,AccountId}]},_,_}, Context) ->
    InputValue = z_context:get_q("input_value", Context),
    _ = kazoo_util:allotment_element_set_field(InputValue, FieldName, AllotmentElementName, AccountId, Context),
    Context;

event({postback,{redirect_to_reseller_portal,[{realm, Realm}]},_,_}, Context) ->
    [AccountId] = [modkazoo_util:get_value(<<"id">>, Child)
                       || Child <- kazoo_util:kz_list_account_children(Context)
                       ,modkazoo_util:get_value(<<"realm">>, Child) == ?TO_BIN(Realm)],
    z_context:set_session('rs_selected_account_id', AccountId, Context),
    z_render:wire({redirect, [{dispatch, "reseller_portal"}]}, Context);

event({'postback',{'save_trunks_limits',[{'trunks_type', TrunksType},{'account_id','undefined'}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({'postback',{'save_trunks_limits',[{'trunks_type', TrunksType},{'account_id',AccountId}]},<<>>,<<>>}, Context);
event({'postback',{'save_trunks_limits',[{'trunks_type', TrunksType},{'account_id',AccountId}]},_,_}, Context) ->
    case kazoo_util:is_trial_account(Context) of
        'false' ->
            InputValue = z_context:get_q("input_value", Context),
            AcceptCharges = modkazoo_util:get_q_boolean("accept_charges", Context),
            modkazoo_util:delay_signal(3, 'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
            kazoo_util:save_trunks_limits(InputValue, TrunksType, AccountId, AcceptCharges, Context);
        {'true', TimeLeft} ->
            z_render:dialog("<span class='zprimary'>"++?__("Trial mode restriction",Context)++"</span>"
                           ,"_trial_mode_restrictions.tpl"
                           ,[{arg, TimeLeft}]
                           ,Context)
    end;

event({submit,{edit_failover_number_service,[{number,Number},{account_id,undefined}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({submit,{edit_failover_number_service,[{number,Number},{account_id,AccountId}]},<<>>,<<>>}, Context);
event({submit,{edit_failover_number_service,[{number,Number},{account_id,AccountId}]},_,_}, Context) ->
    NumberDoc = kazoo_util:phone_number('get', Number, AccountId, [], Context),
    Features = modkazoo_util:get_value(<<"features">>, NumberDoc, []),
    FailoverDestination = modkazoo_util:get_q_bin(<<"failover_destination">>, Context),
    Routines =
        case z_context:get_q("failover_type", Context) of
            "deactivated" ->
                NewFeatures = lists:delete(<<"failover">>, Features),
                [fun(JObj) -> modkazoo_util:set_value(<<"features">>, NewFeatures, JObj) end
                ,fun(JObj) -> modkazoo_util:delete_key(<<"failover">>,JObj) end];
            "sip" ->
                NewFeatures = lists:usort([<<"failover">>] ++ Features),
                [fun(JObj) -> modkazoo_util:set_value(<<"features">>, NewFeatures, JObj) end
                ,fun(JObj) -> modkazoo_util:set_value(<<"failover">>, {[{<<"sip">>,FailoverDestination}]}, JObj) end];
            "e164" ->
                NewFeatures = lists:usort([<<"failover">>] ++ Features),
                [fun(JObj) -> modkazoo_util:set_value(<<"features">>, NewFeatures, JObj) end
                ,fun(JObj) -> modkazoo_util:set_value(<<"failover">>, {[{<<"e164">>,FailoverDestination}]}, JObj) end]
        end,
    NewDoc = lists:foldl(fun(F, JObj) -> F(JObj) end, NumberDoc, Routines),
    kazoo_util:phone_number('post', Number, AccountId, ?MK_DATABAG(NewDoc), Context),
    z_render:growl(?__("Setting saved", Context), Context);

event({submit,{edit_prepend_number_service,[{number,Number},{account_id,undefined}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({submit,{edit_prepend_number_service,[{number,Number},{account_id,AccountId}]},<<>>,<<>>}, Context);
event({submit,{edit_prepend_number_service,[{number,Number},{account_id,AccountId}]},_,_}, Context) ->
    NumberDoc = kazoo_util:phone_number('get', Number, AccountId, [], Context),
    Values =
        case modkazoo_util:get_q_boolean("enabled", Context) of
            'true' ->
                [{[<<"prepend">>,<<"enabled">>], 'true'}
                ,{[<<"prepend">>,<<"name">>], modkazoo_util:get_q_bin("name", Context)}];
            'false' ->
                [{[<<"prepend">>,<<"enabled">>], 'false'}]
        end,
    kazoo_util:phone_number('post', Number, AccountId, ?MK_DATABAG(modkazoo_util:set_values(Values, NumberDoc)), Context),
    z_render:growl(?__("Setting saved", Context), Context);

event({submit,{edit_cname_number_service,[{number,Number},{account_id,undefined}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({submit,{edit_cname_number_service,[{number,Number},{account_id,AccountId}]},<<>>,<<>>}, Context);
event({submit,{edit_cname_number_service,[{number,Number},{account_id,AccountId}]},_,_}, Context) ->
    NumberDoc = kazoo_util:phone_number('get', Number, AccountId, [], Context),
    Values = modkazoo_util:filter_empty([{[<<"cnam">>,<<"display_name">>], modkazoo_util:get_q_bin("cnam", Context)}
                                        ,{[<<"cnam">>,<<"inbound_lookup">>], modkazoo_util:get_q_boolean("inbound_lookup", Context)}]),
    kazoo_util:phone_number('post', Number, AccountId, ?MK_DATABAG(modkazoo_util:set_values(Values, NumberDoc)), Context),
    z_render:growl(?__("Setting saved", Context), Context);

event({postback,{start_task_processing,[{account_id,'undefined'},{task_id,TaskId}]},_,_}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,{start_task_processing,[{account_id,AccountId},{task_id,TaskId}]},<<>>,<<>>}, Context);
event({postback,{start_task_processing,[{account_id,AccountId},{task_id,TaskId}]},_,_}, Context) ->
    kazoo_util:account_task('patch', TaskId, AccountId, [], Context),
    modkazoo_util:delay_signal(2, 'refresh_tasks_widget_signal', ?SIGNAL_FILTER(Context), Context),
    Context;

event({submit,add_new_task,_,_}, Context) ->
    kazoo_util:add_new_task(Context),
    modkazoo_util:delay_signal(2, 'refresh_tasks_widget_signal', ?SIGNAL_FILTER(Context), Context),
    z_render:dialog_close(z_render:growl(?__("Job pending. Don't forget to start.", Context), Context));

event({drag,_,_},Context) ->
    Context;

event({sort,_,_},Context) ->
    Context;

event({postback,refresh_onbill_docs,_,_}, Context) ->
    DocsMonthInput = z_context:get_q("docsmonthInput",Context),
    [Month,Year] = z_string:split(DocsMonthInput,"/"),
    mod_signal:emit({update_onbill_widget_invoices_tpl, ?SIGNAL_FILTER(Context) ++ [{'year',Year},{'month',Month}]}, Context),
    mod_signal:emit({update_onbill_widget_vatinvoices_tpl, ?SIGNAL_FILTER(Context) ++ [{'year',Year},{'month',Month}]}, Context),
    mod_signal:emit({update_onbill_widget_acts_tpl, ?SIGNAL_FILTER(Context) ++ [{'year',Year},{'month',Month}]}, Context),
    mod_signal:emit({update_onbill_widget_calls_reports_tpl, ?SIGNAL_FILTER(Context) ++ [{'year',Year},{'month',Month}]}, Context),
    Context;

event({postback,{refresh_rs_payments_list,[{account_id, AccountId}]},_,_}, Context) ->
    SelectedBillingPeriod  = z_context:get_q("selected_billing_period", Context),
    z_render:update("rs_widget_transactions_list_tpl"
                   ,z_template:render("rs_widget_transactions_list.tpl"
                                     ,[{headline, ?__("Transactions list", Context)}
                                      ,{account_id, AccountId}
                                      ,{selected_billing_period, SelectedBillingPeriod}]
                                     ,Context)
                   ,Context);

event({postback,{generate_rs_related_documents,[{account_id,'undefined'}, {doc_type, DocType}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    event({postback,{generate_rs_related_documents,[{account_id,AccountId}, {doc_type, DocType}]},<<>>,<<>>}, Context);
event({postback,{generate_rs_related_documents,[{account_id,AccountId}, {doc_type, DocType}]},_,_}, Context) ->
    SelectedBillingPeriod  = z_context:get_q("selected_billing_period", Context),
    [Ts,_] = z_string:split(SelectedBillingPeriod, ","),
    Timestamp = z_convert:to_integer(Ts),
    _ = onbill_util:generate_monthly_docs(DocType, AccountId, Timestamp, Context),
    z_render:update("rs_widget_transactions_list_tpl"
                   ,z_template:render("rs_widget_transactions_list.tpl"
                                     ,[{headline, ?__("Transactions list", Context)}
                                      ,{account_id, AccountId}
                                      ,{selected_billing_period, SelectedBillingPeriod}]
                                     ,Context)
                   ,Context);

event({postback,generate_children_docs,_,_}, Context) ->
    SelectedBillingPeriod  = z_context:get_q("selected_billing_period", Context),
    [Ts,_] = z_string:split(SelectedBillingPeriod, ","),
    Timestamp = z_convert:to_integer(Ts),
    _ = onbill_util:generate_monthly_docs('who_cares', <<"all_children">>, Timestamp, Context),
    z_render:growl(?__("Process started and could take a while.",Context), Context);

event({postback,onbill_set_variables_json,_A,_B}, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    event({postback,{onbill_set_variables_json,[{account_id, AccountId}]},_A,_B}, Context);
event({postback,{onbill_set_variables_json,[{account_id, AccountId}]},_,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list(AccountId), Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
    growl_bad_result(onbill_util:variables(post, AccountId, DataBag, Context), Context);

event({postback,{onbill_set_doc_json,[{doc_id,DocId},{doc_type, DocType}]},_,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list(DocId), Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
    growl_bad_result(onbill_util:(z_convert:to_atom(DocType))(post, AccountId, DocId, DataBag, Context), Context);

event({submit,edit_carrier_template,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    CarrierId = z_context:get_q("carrier_id", Context),
    TemplateId = z_context:get_q("template_id", Context),
    MessageBody = z_context:get_q("html_body", Context),
    _ = onbill_util:carrier_template('post'
                                    ,[{"Content-Type", "text/html;charset=utf-8"}]
                                    ,AccountId
                                    ,CarrierId
                                    ,TemplateId
                                    ,MessageBody
                                    ,Context),
    z_render:dialog_close(Context);

event({submit,periodic_fee,_,_}, Context) ->
    AccountId = ?TO_BIN(z_context:get_q("account_id", Context)),
    ServiceStarts = modkazoo_util:datepick_to_tstamp(z_context:get_q("service_starts", Context)),
    ServiceEnds =
       case ?TO_BIN(z_context:get_q("enddate_defined", Context)) of
          <<>> -> 'undefined';
          _ ->
              modkazoo_util:datepick_to_tstamp_end_day(z_context:get_q("service_ends", Context))
       end,
    Props = modkazoo_util:filter_empty([{<<"account_id">>, ?TO_BIN(z_context:get_q("account_id", Context))}
                                       ,{<<"service_id">>, ?TO_BIN(z_context:get_q("service_id", Context))}
                                       ,{<<"comment">>, ?TO_BIN(z_context:get_q("comment", Context))}
                                       ,{<<"quantity">>, ?TO_INT(z_context:get_q("quantity", Context), 1)}
                                       ,{<<"service_starts">>, ServiceStarts}
                                       ,{<<"service_ends">>, ServiceEnds}
                                       ]),
lager:info("IAM Qty: ~p",[z_context:get_q("quantity", Context, 1)]),
lager:info("IAM TO_INT: ~p",[?TO_INT(z_context:get_q("quantity", Context), 1)]),
lager:info("IAM Props: ~p",[Props]),
lager:info("IAM service_starts: ~p",[z_context:get_q("service_starts", Context)]),
lager:info("IAM service_ends: ~p",[z_context:get_q("service_ends", Context)]),
    case ?TO_BIN(z_context:get_q("fee_id", Context)) of
        <<>> ->
            DataBag = ?MK_DATABAG(modkazoo_util:set_values(Props, modkazoo_util:new())),
            onbill_util:periodic_fees('put', AccountId, DataBag, Context);
        FeeId ->
            CurrDoc = onbill_util:periodic_fees('get', AccountId, FeeId, [], Context),
            case ?TO_BIN(z_context:get_q("enddate_defined", Context)) of
                <<>> ->
                    NewDoc = modkazoo_util:delete_key(<<"service_ends">>, modkazoo_util:set_values(Props, CurrDoc)),
                    onbill_util:periodic_fees('post', AccountId, FeeId, ?MK_DATABAG(NewDoc), Context);
                _ ->
                    NewDoc = modkazoo_util:set_values(Props, CurrDoc),
                    onbill_util:periodic_fees('post', AccountId, FeeId, ?MK_DATABAG(NewDoc), Context)
            end
    end,
    z_render:dialog_close(Context);

event({postback,disarm_credit,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    DataBag = ?MK_DATABAG({[{<<"armed">>,false}]}),
    PrPt = onbill_util:promised_payment('patch', AccountId, DataBag, Context),
    z_render:update("update_widget_dashboard_credit"
                   ,z_template:render("onbill_widget_dashboard_credit.tpl"
                                     ,[{headline,"Credit"},{pr_pt, PrPt}]
                                     ,Context)
                   ,Context);

event({submit,arm_credit,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    Credit_amount = z_context:get_q("creditme",Context),
    try z_convert:to_integer(Credit_amount) of
        Amount ->
            DataBag = ?MK_DATABAG({[{<<"armed">>, true}
                                   ,{<<"amount">>, Amount}
                                   ]}
                                 ),
            PrPt = onbill_util:promised_payment('patch', AccountId, DataBag, Context),
            z_render:update("update_widget_dashboard_credit"
                           ,z_template:render("onbill_widget_dashboard_credit.tpl"
                                             ,[{headline,"Credit"},{pr_pt, PrPt}]
                                             ,Context)
                           ,Context)
    catch
        error:_ ->
            z_render:growl_error(?__("Something went wrong.", Context), Context)
    end;

event({postback,{onbill_transaction_details,[{account_id,AccountId},{transaction_id, TransactionId}]},_,_}, Context) ->
    z_render:dialog(?__("Transaction details. ID:",Context) ++ " " ++ z_convert:to_list(TransactionId)
                   ,"_onbill_transaction_details.tpl"
                   ,[{account_id,AccountId}
                    ,{transaction_id, TransactionId}
                    ,{width, "auto"}
                    ]
                   ,Context);

event({submit,selected_numbers_array_form,_,_}, Context) ->
    case kazoo_util:is_trial_account(Context) of
        'false' ->
            onbill_util:confirm_number_purchase_dialog(Context);
        {'true', TimeLeft} -> 
            z_render:dialog("<span class='zprimary'>"++?__("Trial mode restriction",Context)++"</span>"
                           ,"_trial_mode_restrictions.tpl"
                           ,[{arg, TimeLeft}]
                           ,Context)
    end;

event({submit,{allocate_numbers,[{numbers,Numbers}]},_,_}, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    SenderName = kazoo_util:email_sender_name(Context),
    EmailFrom = m_config:get_value('mod_kazoo', sales_email, Context),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{email_from, EmailFrom}
           ,{clientip, ClientIP}
           ,{sender_name, SenderName}
           ,{numbers, Numbers}],
    AllocateNumberEmail =
        #email{to = EmailFrom
              ,from = EmailFrom
              ,html_tpl = "_email_number_purchase.tpl"
              ,vars = Vars
              },
    spawn('z_email','send' ,[AllocateNumberEmail, Context]),
    AcceptCharges = modkazoo_util:get_q_boolean("accept_charges", Context),
    kazoo_util:process_purchase_numbers(Numbers, AcceptCharges, Context);

event({submit,{set_e911_address,[{account_id,'undefined'}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    event({submit,{set_e911_address,[{account_id,AccountId}]},<<>>,<<>>}, Context);
event({submit,{set_e911_address,[{account_id,AccountId}]},_,_}, Context) ->
    try
      Number = modkazoo_util:get_q_bin("number", Context),
      case modkazoo_util:get_q_bin("confirmed_address", Context) of
          <<"remove_address_radio">> ->
              _ = kazoo_util:remove_e911_number_service(Number, AccountId, Context),
              _ = mod_signal:emit({emit_growl_signal
                                  ,?SIGNAL_FILTER(Context)
                                   ++ [{'text',?__("Address removed", Context)},{'type', 'notice'}]}
                                 ,Context);
          <<AddrDocId:32/binary>> ->
              _ = onbill_util:set_e911_address(AddrDocId, Number, AccountId, Context),
              _ = mod_signal:emit({emit_growl_signal
                                  ,?SIGNAL_FILTER(Context)
                                   ++ [{'text',?__("Address configured", Context)},{'type', 'notice'}]}
                                 ,Context);
          _ ->
              'ok' = modkazoo_util:check_field_filled("postal_code",Context),
              'ok' = modkazoo_util:check_field_filled("locality",Context),
              'ok' = modkazoo_util:check_field_filled("region",Context),
              'ok' = modkazoo_util:check_field_filled("street_address",Context),
              {upload, _UploadFilename, UploadTmp, _, _} = z_context:get_q("address_confirmation_file",Context),
              false = modkazoo_util2:check_file_size_exceeded('address_confirmation_file', UploadTmp, 15000000),
              _ = onbill_util:set_e911_address(Number, AccountId, Context),
              _ = mod_signal:emit({emit_growl_signal
                                  ,?SIGNAL_FILTER(Context)
                                   ++ [{'text',?__("Address configured", Context)},{'type', 'notice'}]}
                                 ,Context)
      end,
      _ = mod_signal:emit({onnet_allocated_numbers_tpl, ?SIGNAL_FILTER(Context)} ,Context),
      modkazoo_util:delay_signal(3, 'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
      z_render:update("number_services_div"
                     ,z_template:render("_edit_e911_number_service.tpl"
                                       ,[{number, Number},{account_id, AccountId}]
                                       ,Context)
                     ,Context)
    catch
      error:{badmatch, {true, 'address_confirmation_file'}} ->
          z_render:growl_error(?__("Maximum file size exceeded",Context), Context);
      error:{badmatch, []} ->
          z_render:growl_error(?__("Please provide proof of address file",Context), Context);
      error:{badmatch, _} ->
          z_render:growl_error(?__("All mandatory fields should be filled in",Context), Context);
      E1:E2 ->
          lager:info("Err ~p:~p", [E1, E2]),
          z_render:growl_error(?__("All fields should be correctly filled in",Context), Context)
    end;

event({submit,{edit_e911_proof_address,[{doc_id,DocId},{account_id,AccountId}]},_,_}, Context) ->
    try
      'ok' = modkazoo_util:check_field_filled("postal_code",Context),
      'ok' = modkazoo_util:check_field_filled("locality",Context),
      'ok' = modkazoo_util:check_field_filled("region",Context),
      'ok' = modkazoo_util:check_field_filled("street_address",Context),
      onbill_util:update_e911_doc(DocId, AccountId, Context),
      mod_signal:emit({rs_widget_e911_addresses_tpl
                      ,?SIGNAL_FILTER(Context)
                       ++ [{'account_id',AccountId},{'headline',?__("E911 addresses", Context)}]
                      }
                     ,Context),
      Context
    catch
      error:{badmatch, _} ->
          z_render:growl_error(?__("All mandatory fields should be filled in",Context), Context);
      E1:E2 ->
          lager:info("Err ~p:~p", [E1, E2]),
          z_render:growl_error(?__("All fields should be correctly filled in",Context), Context)
    end;

event({postback,{mark_e911_address_deleted,[{doc_id,DocId},{account_id,AccountId}]},_,_}, Context) ->
    onbill_util:e911_address('delete', DocId, AccountId, [], Context),
    mod_signal:emit({rs_widget_e911_addresses_tpl
                    ,?SIGNAL_FILTER(Context)
                     ++ [{'account_id',AccountId},{'headline',?__("E911 addresses", Context)}]
                    }
                   ,Context),
    Context;

event({postback,{mark_proforma_invoice_deleted,[{doc_id,DocId}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    onbill_util:onbill_proforma_doc('delete', DocId, AccountId, [], Context),
    z_render:update("proforma_invoice_span",z_template:render("_proforma_invoices_list.tpl",[],Context),Context);

event({postback,{mark_periodic_service_deleted,[{fee_id,FeeId},{account_id,AccountId}]},_,_}, Context) ->
    onbill_util:periodic_fees('delete', AccountId, FeeId, [], Context),
    mod_signal:emit({update_onbill_periodic_services_lazy_tpl, ?SIGNAL_FILTER(Context)}, Context),
    Context;

event({postback,{set_e911_address_confirmed,[{flag, Flag},{doc_id,DocId},{account_id,AccountId}]},_,_}, Context) ->
    onbill_util:confirm_e911_address(z_convert:to_bool(Flag), DocId, AccountId, Context),
    mod_signal:emit({rs_widget_e911_addresses_tpl
                    ,?SIGNAL_FILTER(Context)
                     ++ [{'account_id',AccountId},{'headline',?__("E911 addresses", Context)}]
                    }
                   ,Context),
    Context;

event({submit,{manage_trial_status,[{account_id,AccountId}]},_,_}, Context) ->
    case modkazoo_util:get_q_bin("manage_trial_status", Context) of
        <<"remove_trial_status">> ->
            onbill_util:onbill_trial('delete', AccountId, [], Context),
            modkazoo_util:delay_signal(1, 'update_onbill_account_details', ?SIGNAL_FILTER(Context), Context),
            modkazoo_util:delay_signal(3, 'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
            z_render:dialog_close(Context);
        <<"set_account_type">> ->
            case modkazoo_util:get_q_bin("account_type", Context) of
                <<"postpaid">> ->
                    Amount = modkazoo_util:get_q_bin("max_postpay_amount", Context),
                    List = [{<<"allow_postpay">>, 'true'}
                           ,{<<"max_postpay_amount">>, Amount}
                           ],
                    onbill_util:onbill_pvt_limits('post', AccountId, ?MK_DATABAG(?JSON_WRAPPER(List)), Context);
                _ ->
                    onbill_util:save_pvt_limits_field('false', <<"allow_postpay">>, AccountId, Context)
            end,
            z_render:dialog(?__("Trial status manager", Context)
                           ,"_rs_trial_status_manager.tpl"
                           ,[{account_id,AccountId}
                            ,{trial_time_left, kazoo_util:kz_account_doc_field(<<"trial_time_left">>, AccountId, Context)}
                            ]
                           ,Context);
        <<"new_expiration_date">> ->
            ExpirationString = modkazoo_util:get_q_bin("new_expiration_date", Context),
            [Month, Day, Year] = binary:split(ExpirationString, <<"/">>, [global]),
            TS = calendar:datetime_to_gregorian_seconds({{?TO_INT(Year),?TO_INT(Month),?TO_INT(Day)},{23,59,59}}),
            DataBag = ?MK_DATABAG({[{<<"new_expiration_timestamp">>,TS}]}),
            onbill_util:onbill_trial('post', AccountId, DataBag, Context),
            modkazoo_util:delay_signal(1, 'update_onbill_account_details', ?SIGNAL_FILTER(Context), Context),
            z_render:dialog_close(Context)
    end;

event({postback,{save_pvt_limits_field,[{field_name,FieldName},{account_id, AccountId}]},_,_}, Context) ->
    InputValue = modkazoo_util:get_q_bin("input_value", Context),
    onbill_util:save_pvt_limits_field(InputValue, FieldName, AccountId, Context);

event({submit,{metaflows_capture_add,[{account_id,'undefined'}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    event({submit,{metaflows_capture_add,[{account_id,AccountId}]},<<>>,<<>>}, Context);
event({submit,{metaflows_capture_add,[{account_id,AccountId}]},_,_}, Context) ->
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    CaptureType = modkazoo_util:get_q_bin("capture_type", Context),
    CaptureNP = modkazoo_util:get_q_bin("capture_number_or_pattern", Context),
    Module = modkazoo_util:get_q_bin("metaflows_module", Context),
    CurrDoc = kazoo_util:metaflows('get', AccountId, [], Context),
    ModuleData =
        case Module of
            <<"transfer">> ->
                modkazoo_util:set_value(<<"takeback_dtmf">>,<<"1">>, {[]});
            _ ->
                {[]}
        end,
    Routines =
        [fun(JObj) -> modkazoo_util:set_value([CaptureType, CaptureNP, <<"module">>], Module, JObj) end
        ,fun(JObj) -> modkazoo_util:set_value([CaptureType, CaptureNP, <<"data">>], ModuleData, JObj) end],
    NewDoc = lists:foldl(fun(F, JObj) -> F(JObj) end, CurrDoc, Routines),
    _ = kazoo_util:metaflows('post', AccountId, ?MK_DATABAG(NewDoc), Context),
    z_render:update("restrictions_pannel_div",z_template:render("_metaflows.tpl",[{account_id,AccountId}],Context),Context);

event({postback,{delete_metaflow_capture_element,[{account_id,undefined}
                                                 ,{capture_type,CaptureType}
                                                 ,{capture_number_or_pattern,CaptureNP}]}
                ,_
                ,_
      }
     ,Context)
    ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    event({postback,{delete_metaflow_capture_element,[{account_id,AccountId}
                                                     ,{capture_type,CaptureType}
                                                     ,{capture_number_or_pattern,CaptureNP}]}
                    ,<<>>
                    ,<<>>
          }
         ,Context);
event({postback,{delete_metaflow_capture_element,[{account_id,AccountId}
                                                 ,{capture_type,CaptureType}
                                                 ,{capture_number_or_pattern,CaptureNP}]}
                ,_
                ,_
      }
     ,Context)
    ->
    CurrDoc = kazoo_util:metaflows('get', AccountId, [], Context),
    NewDoc = modkazoo_util:delete_key([?TO_BIN(CaptureType), ?TO_BIN(CaptureNP)], CurrDoc), 
    _ = kazoo_util:metaflows('post', AccountId, ?MK_DATABAG(NewDoc), Context),
    z_render:update("restrictions_pannel_div",z_template:render("_metaflows.tpl",[{account_id,AccountId}],Context),Context);

event({submit,issue_invoice_for_transaction,_,_}, Context) ->
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    AccountId = modkazoo_util:get_q_bin("account_id", Context),
    InvoiceDescription = modkazoo_util:get_q_bin("invoice_description", Context),
    TransactionId = modkazoo_util:get_q_bin("transaction_id", Context),
    Timestamp = modkazoo_util:datepick_to_tstamp(modkazoo_util:get_q_bin("invoice_date", Context)),
    case onbill_util:generate_transaction_based_invoice(TransactionId, InvoiceDescription, AccountId, Timestamp, Context) of
        {'error', _ReturnCode, Body} ->
            Message = modkazoo_util:get_first_defined([[<<"data">>,<<"message">>]
                                                      ,[<<"data">>,<<"api_error">>,<<"message">>]
                                                      ]
                                                     ,jiffy:decode(Body)
                                                     ,<<"Something went wrong">>),
            Context1 = z_render:growl_error(?__(z_convert:to_list(Message), Context), Context),
            z_render:dialog_close(Context1);
        _ ->
            mod_signal:emit({rs_payments_lists_table_opened, ?SIGNAL_FILTER(Context)}, Context),
            z_render:dialog_close(z_render:growl(?__("Invoice created", Context), Context))
    end;

event({postback,{onbill_transaction_delete,[{account_id, AccountId},{transaction_id, TransactionId}]},_,_}, Context) ->
    onbill_util:onbill_transaction('delete', TransactionId, AccountId, [], Context),
    modkazoo_util:delay_signal(2 ,'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
    Context;

event({postback,{onbill_generated_doc_delete,[{account_id,AccountId},{doc_id,DocId}]},_,_}, Context) ->
    onbill_util:doc('delete', AccountId, DocId, [], Context),
    modkazoo_util:delay_signal(2 ,'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
    Context;

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.

growl_bad_result(<<>>, Context) -> 
    z_render:growl_error(?__("Something went wrong.", Context), Context);
growl_bad_result(_, Context) -> 
    z_render:growl(?__("Operation succeeded.",Context), Context).

maybe_update_toggled_field(TargetId, Type, DocId, FieldName, Prefix, AccountId, Context) ->
            z_render:update(TargetId
                           ,z_template:render("_show_field_checkbox.tpl"
                                             ,[{type,Type}
                                              ,{doc_id,DocId}
                                              ,{field_name,FieldName}
                                              ,{prefix, Prefix}
                                              ,{account_id, AccountId}
                                              ]
                                             ,Context)
                           ,Context).

