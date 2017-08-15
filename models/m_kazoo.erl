-module(m_kazoo).
-author("kirill.sysoev@gmail.com").

-behaviour(gen_model).

-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2
]).

-include_lib("zotonic.hrl").
-include_lib("../include/mod_kazoo.hrl").

m_find_value(get_registrations, _M, _Context) ->
    [];

m_find_value(is_operators_session, _M, _Context) ->
    true;

m_find_value(is_auth, _M, Context) ->
    modkazoo_auth:is_auth(Context);

m_find_value(signal_filter, _M, Context) ->
    z_session_manager:get_session_id(Context);

m_find_value(is_kazoo_account_admin, _M, Context) ->
    kazoo_util:is_kazoo_account_admin(Context);

m_find_value(get_kazoo_account_id, _M, Context) ->
    z_context:get_session(kazoo_account_id, Context);

m_find_value(kz_get_acc_doc, _M, Context) ->
    kazoo_util:kz_get_acc_doc(Context);

m_find_value({kz_get_acc_doc_by_account_id, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_get_acc_doc_by_account_id(AccountId, Context);

m_find_value({kz_account_doc_field, [{field1, Field1}]}, _M, Context) ->
    kazoo_util:kz_account_doc_field(Field1, Context);

m_find_value({kz_account_doc_field, [{field1, Field1}, {field2, Field2}]}, _M, Context) ->
    kazoo_util:kz_account_doc_field([Field1, Field2], Context);

m_find_value({kz_account_doc_field, [{field1, Field1}, {field2, Field2}, {field3, Field3}]}, _M, Context) ->
    kazoo_util:kz_account_doc_field([Field1, Field2, Field3], Context);

m_find_value({kz_device_doc, [{device_id, DeviceId}]}, _M, Context) ->
    kazoo_util:kz_get_device_doc(DeviceId, Context);

m_find_value({kz_user_doc_by_ownerid, [{owner_id, OwnerId}]}, _M, Context) ->
    kazoo_util:kz_get_user_doc(OwnerId, Context);

m_find_value({kz_user_doc_field, [{user_id, UserId}, {field1, Field1}]}, _M, Context) ->
    kazoo_util:kz_user_doc_field(Field1, UserId, Context);

m_find_value({kz_user_doc_field, [{field1, Field1}]}, _M, Context) ->
    kazoo_util:kz_user_doc_field(Field1, Context);

m_find_value({kz_user_doc_field, [{field1, Field1}, {field2, Field2}]}, _M, Context) ->
    kazoo_util:kz_user_doc_field([Field1, Field2], Context);

m_find_value({kz_user_doc_field, [{field1, Field1}, {field2, Field2}, {field3, Field3}]}, _M, Context) ->
    kazoo_util:kz_user_doc_field([Field1, Field2, Field3], Context);

m_find_value({kz_device_doc_field, [{device_id, DeviceId}, {field, Field}]}, _M, Context) ->
    kazoo_util:kz_device_doc_field(Field, DeviceId, Context);

m_find_value({kz_doc_field, [{type,Type}, {doc_id, _DocId}, {field, Field}, {account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({kz_doc_field, [{type,Type}, {doc_id, _DocId}, {field, Field}, {account_id, AccountId}]}, _M, Context);

m_find_value({kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}, {account_id, AccountId}]}, _M, Context) ->
    case Type of
        <<"account">> -> kazoo_util:kz_account_doc_field(Field, AccountId, Context);
        <<"user">> -> kazoo_util:kz_user_doc_field(Field, DocId, Context);
        <<"device">> -> kazoo_util:kz_device_doc_field(Field, DocId, Context);
        <<"media">> -> kazoo_util:kz_media_doc_field(Field, DocId, Context);
        <<"cccp_creds">> -> kazoo_util:cccp_field(Field, DocId, Context);
        <<"onbill_variables">> -> onbill_util:variables_field(Field, AccountId, Context);
        <<"config">> -> z_notifier:first({'doc_field', 'get', ?TO_BIN(DocId), Field, AccountId}, Context);
        E -> lager:info("kz_doc_field Error: ~p",[E])
    end;

m_find_value({kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}]}, _M, Context) ->
    case Type of
        <<"account">> -> kazoo_util:kz_account_doc_field(Field, Context);
        <<"user">> -> kazoo_util:kz_user_doc_field(Field, DocId, Context);
        <<"device">> -> kazoo_util:kz_device_doc_field(Field, DocId, Context);
        <<"media">> -> kazoo_util:kz_media_doc_field(Field, DocId, Context);
        E -> lager:info("kz_doc_field Error: ~p",[E])
    end;

m_find_value(kz_list_account_users, _M, Context) ->
    kazoo_util:kz_list_account_users(Context);

m_find_value({kz_list_account_users, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_list_account_users(AccountId, Context);

m_find_value(kz_list_account_groups, _M, Context) ->
    kazoo_util:kz_list_account_groups(Context);

m_find_value(kz_list_account_blacklists, _M, Context) ->
    kazoo_util:kz_list_account_blacklists(Context);

m_find_value(kz_list_account_children, _M, Context) ->
    kazoo_util:kz_list_account_children(Context);

m_find_value(kz_list_account_channels, _M, Context) ->
    kazoo_util:kz_list_account_channels(Context);

m_find_value({kz_list_account_channels, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_list_account_channels(AccountId, Context);

m_find_value(get_reseller_channels, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kazoo_util:kz_get_reseller_channels(AccountId, Context);

m_find_value({kz_channel_info, [{uuid, UUId}, {account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_channel_info(UUId, AccountId, Context);

m_find_value(kz_list_account_callflows, _M, Context) ->
    kazoo_util:kz_list_account_callflows(Context);

m_find_value({kz_list_account_callflows, [{filter, Filter}]}, _M, Context) ->
    JObjs = kazoo_util:kz_list_account_callflows(Context),
    lists:filter(fun(X) -> modkazoo_util2:if_substring_in_json(Filter, kazoo_util:kz_get_account_callflow(modkazoo_util:get_value(<<"id">>,X), Context)) end, JObjs);

m_find_value({kz_get_account_callflow, [{callflow_id,CallflowId}]}, _M, Context) ->
    kazoo_util:kz_get_account_callflow(CallflowId, Context);

m_find_value({kz_get_account_blacklist, [{blacklist_id, BlacklistId}]}, _M, Context) ->
    kazoo_util:kz_get_account_blacklist(BlacklistId, Context);

m_find_value(kz_list_account_users_short, _M, Context) ->
    lists:map(fun (UserDoc) -> [modkazoo_util:get_value(<<"id">>,UserDoc)
                               ,<<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary
                                 ," "
                                 ,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>
                               ]
              end,
              kazoo_util:kz_list_account_users(Context))  ++ [["","-No owner-"]];

m_find_value(kz_list_account_devices, _M, Context) ->
    kazoo_util:kz_list_account_devices(Context);

m_find_value(kz_list_account_devices_short, _M, Context) ->
    lists:map(fun (DeviceDoc) -> [z_convert:to_list(modkazoo_util:get_value(<<"id">>,DeviceDoc)),modkazoo_util:get_value(<<"name">>,DeviceDoc)] end, kazoo_util:kz_list_account_devices(Context))
        ++ [["","-No owner-"]];

m_find_value(kz_list_user_devices, _M, Context) ->
    kazoo_util:kz_list_user_devices(Context);

m_find_value({kz_list_user_devices, [{owner_id, OwnerId}]}, _M, Context) ->
    kazoo_util:kz_list_user_devices(OwnerId, Context);

m_find_value(kz_list_account_vmboxes, _M, Context) ->
    kazoo_util:kz_list_account_vmboxes(Context);

m_find_value(kz_list_user_vmboxes, _M, Context) ->
    kazoo_util:kz_list_user_vmboxes(Context);

m_find_value({kz_list_user_vmbox_details, [{vmbox_id, 'undefined'}]}, _M, _Context) ->
    'undefined';
m_find_value({kz_list_user_vmbox_details, [{vmbox_id, VMBoxId}]}, _M, Context) ->
    kazoo_util:kz_list_user_vmbox_details(VMBoxId, Context);

m_find_value({kz_list_user_vmbox_messages, [{vmbox_id, VMBoxId}]}, _M, Context) ->
    kazoo_util:kz_list_user_vmbox_messages(VMBoxId, Context);

m_find_value({kz_vmessage_download_link, [{vmbox_id, VMBoxId}, {media_id, MediaId}]}, _M, Context) ->
    kazoo_util:kz_vmessage_download_link(VMBoxId, MediaId, Context);

m_find_value({z_recording_download_link, [{cdr_id, CallId}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    kazoo_util:kz_kzattachment_link(AccountId, CallId, AuthToken, "call_recording", Context);

m_find_value({kz_incoming_fax_download_link, [{doc_id, DocId}]}, _M, Context) ->
    kazoo_util:kz_incoming_fax_download_link(DocId, Context);

m_find_value({list_user_cdr,[{created_from, 'undefined'},{'created_to', 'undefined'}]}, _M, Context) ->
    kazoo_util:kz_list_user_cdr_reduced(modkazoo_util:today_begins_tstamp(Context), modkazoo_util:today_ends_tstamp(Context), Context);
m_find_value({list_user_cdr,[{created_from, CreatedFrom},{'created_to', CreatedTo}]}, _M, Context) ->
    kazoo_util:kz_list_user_cdr_reduced(CreatedFrom, CreatedTo, Context);

m_find_value({list_account_cdr,[{'created_from', CreatedFrom},{'created_to', CreatedTo},{'account_id', 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({list_account_cdr,[{'created_from', CreatedFrom},{'created_to', CreatedTo},{'account_id', AccountId}]}, _M, Context);
m_find_value({list_account_cdr,[{created_from, 'undefined'},{'created_to', 'undefined'},{'account_id', _AccountId}]}, _M, Context) ->
    kazoo_util:kz_list_account_cdr_reduced(modkazoo_util:today_begins_tstamp(Context), modkazoo_util:today_ends_tstamp(Context), Context);
m_find_value({list_account_cdr,[{'created_from', CreatedFrom},{'created_to', CreatedTo},{'account_id', _AccountId}]}, _M, Context) ->
    kazoo_util:kz_list_account_cdr_reduced(CreatedFrom, CreatedTo, Context);

m_find_value({kz_fetch_cdr_details, [{cdr_id, CDR_Id}]}, _M, Context) ->
    kazoo_util:kz_fetch_cdr_details(CDR_Id, Context);

m_find_value({kz_cdr_legs,[{cdr_id,undefined}]}, _M, _Context) ->
    [];
m_find_value({kz_cdr_legs,[{cdr_id,CDR_Id}]}, _M, Context) ->
    kazoo_util:kz_cdr_legs_localized(CDR_Id, Context);

m_find_value(current_account_credit, _M, Context) ->
    modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(Context));

m_find_value({current_account_credit, [{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(AccountId, Context));

m_find_value({current_account_credit, [{account_id, AccountId}]}, _M, Context) ->
    modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(AccountId, Context));

m_find_value({service_plan, [{plan_id, PlanId}]}, _M, Context) ->
    kazoo_util:service_plan(PlanId, Context);

m_find_value({service_plan, [{plan_id, PlanId},{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:service_plan(PlanId, AccountId, Context);

m_find_value(kz_service_plans, _M, Context) ->
    kazoo_util:service_plans(Context);

m_find_value({kz_service_plans, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:service_plans(AccountId, Context);

m_find_value(kz_service_plans_available, _M, Context) ->
    kazoo_util:available_service_plans(Context);

m_find_value({kz_service_plans_available, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:available_service_plans(AccountId, Context);

m_find_value(kz_current_service_plans, _M, Context) ->
    kazoo_util:current_service_plans(Context);

m_find_value({kz_current_service_plans, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:current_service_plans(AccountId, Context);

m_find_value(services_status, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({services_status, [{account_id, AccountId}]}, _M, Context);

m_find_value({services_status, [{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({services_status, [{account_id, AccountId}]}, _M, Context);
m_find_value({services_status, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:services_status('get', AccountId, [], Context);

m_find_value({kz_check_device_registration, [{device_id, DeviceId}]}, _M, Context) ->
    kazoo_util:kz_check_device_registration(DeviceId, Context);

m_find_value({kz_registration_details_by_username, [{username, Username}]}, _M, Context) ->
    kazoo_util:kz_registration_details_by_username(Username, Context);

m_find_value({kz_get_device_registration_details, [{device_id, DeviceId}]}, _M, Context) ->
    kazoo_util:kz_get_device_registration_details(DeviceId, Context);

m_find_value(azrates, _M, Context) ->
    kazoo_util:azrates(Context);

m_find_value(kz_list_incoming_faxes, _M, Context) ->
    kazoo_util:kz_list_incoming_faxes(Context);

m_find_value(get_acc_numbers, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_account_numbers(Context)));

m_find_value({get_acc_numbers, [{account_id,AccountId}]}, _M, Context) ->
    kazoo_util:kz_account_numbers(AccountId,Context);

m_find_value(get_acc_numbers_info, _M, Context) ->
    kazoo_util:kz_account_numbers_info(Context);

m_find_value({get_acc_numbers_info, [{account_id,AccountId}]}, _M, Context) ->
    kazoo_util:kz_account_numbers_info(AccountId,Context);

m_find_value({number_info, [{number, Number}]}, _M, Context) ->
    kazoo_util:phone_number(Number, Context);

m_find_value({number_info, [{number, Number},{account_id,AccountId}]}, _M, Context) ->
    kazoo_util:phone_number('get', Number, AccountId, [], Context);

m_find_value(kz_list_outgoing_faxes, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_list_outgoing_faxes(Context)));

m_find_value(kz_bt_transactions, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_bt_transactions(Context)));

m_find_value(kz_list_transactions, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_list_transactions(Context)));

m_find_value({kz_list_transactions,[{account_id,AccountId}]}, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_list_transactions(AccountId,Context)));

m_find_value({kz_list_transactions,[{account_id, 'undefined'},{selected_billing_period,SelectedBillingPeriod},{type,Type}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({kz_list_transactions,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{type,Type}]}, _M, Context);
m_find_value({kz_list_transactions,[{account_id,AccountId},{selected_billing_period,'undefined'},{type,Type}]}, _M, Context) ->
    CurrBillingPeriod = onbill_util:current_billing_period(AccountId, Context),
    StartPeriodTS = modkazoo_util:get_value([<<"period_start">>, <<"day_begins_ts">>], CurrBillingPeriod),
    EndPeriodTS = modkazoo_util:get_value([<<"period_end">>, <<"day_ends_ts">>], CurrBillingPeriod),
    SelectedBillingPeriod = z_convert:to_list(StartPeriodTS) ++ "," ++ z_convert:to_list(EndPeriodTS),
    m_find_value({kz_list_transactions,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{type,Type}]}, _M, Context);

m_find_value({kz_list_transactions,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{type,Type}]}, _M, Context) ->
    [CF,CT] = z_string:split(SelectedBillingPeriod, ","),
    CreatedFrom = z_convert:to_integer(CF),
    CreatedTo = z_convert:to_integer(CT),
    Transactions = kazoo_util:kz_list_transactions(AccountId, CreatedFrom, CreatedTo, 'undefined', Context),
    case Type of
        <<"debit">> ->
            kazoo_util:debit_transactions(Transactions);
        <<"debit_summ">> ->
            lists:foldl(fun(X,Acc) -> modkazoo_util:get_value(<<"amount">>, X) + Acc end, 0, kazoo_util:debit_transactions(Transactions));
        <<"credit">> ->
            kazoo_util:credit_transactions(Transactions);
        <<"credit_summ">> ->
            lists:foldl(fun(X,Acc) -> modkazoo_util:get_value(<<"amount">>, X) + Acc end, 0, kazoo_util:credit_transactions(Transactions))
    end;

m_find_value({period_balance,[{account_id,'undefined'},{selected_billing_period,SelectedBillingPeriod}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({period_balance,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod}]}, _M, Context);
m_find_value({period_balance,[{account_id,AccountId},{selected_billing_period,'undefined'}]}, _M, Context) ->
    onbill_util:period_balance(AccountId, modkazoo_util:current_tstamp(Context), Context);
m_find_value({period_balance,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod}]}, _M, Context) ->
    [Ts,_] = z_string:split(SelectedBillingPeriod, ","),
    Timestamp = z_convert:to_integer(Ts),
    onbill_util:period_balance(AccountId, Timestamp, Context);

m_find_value({kz_list_ledgers,[{account_id, 'undefined'},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]}, _M, Context);

m_find_value({kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,'undefined'},{ledger_id,LedgerId}]}, _M, Context) ->
    CurrBillingPeriod = onbill_util:current_billing_period(AccountId, Context),
    StartPeriodTS = modkazoo_util:get_value([<<"period_start">>, <<"day_begins_ts">>], CurrBillingPeriod),
    EndPeriodTS = modkazoo_util:get_value([<<"period_end">>, <<"day_ends_ts">>], CurrBillingPeriod),
    SelectedBillingPeriod = z_convert:to_list(StartPeriodTS) ++ "," ++ z_convert:to_list(EndPeriodTS),
    m_find_value({kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]}, _M, Context);

m_find_value({kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]}, _M, Context) ->
    [CF,CT] = z_string:split(SelectedBillingPeriod, ","),
    CreatedFrom = z_convert:to_integer(CF),
    CreatedTo = z_convert:to_integer(CT),
    kazoo_util:kz_list_ledgers(LedgerId, AccountId, CreatedFrom, CreatedTo, Context);

m_find_value({kz_ledgers_summ,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]}, _M, Context) ->
    LedgersList = m_find_value({kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]}, _M, Context),
    lists:foldl(fun(X, Acc) -> case z_convert:to_list(modkazoo_util:get_value([<<"source">>,<<"service">>], X)) of
                                   LedgerId -> Acc + modkazoo_util:get_value([<<"amount">>], X);
                                   _ -> Acc
                               end
                 end
                ,0
                ,LedgersList);

m_find_value(bt_client_token, _M, Context) ->
    bt_util:bt_client_token(Context);

m_find_value(kz_bt_customer, _M, Context) ->
    kazoo_util:kz_bt_customer(Context);

m_find_value({ui_element_opened,[{element, ElementName}]}, _M, Context) ->
    kazoo_util:ui_element_state(ElementName, Context);

m_find_value(kz_list_subscriptions, _M, Context) ->
    kazoo_util:kz_list_subscriptions(Context);

m_find_value({kz_get_subscription,[{subscription_id, SubscriptionId}]}, _M, Context) ->
    kazoo_util:kz_get_subscription(SubscriptionId, kazoo_util:kz_list_subscriptions(Context));

m_find_value({kz_get_subscription,[{subscription_id, SubscriptionId},{account_id, 'undefined'}]}, _M, Context) ->
    m_find_value({kz_get_subscription,[{subscription_id, SubscriptionId}]}, _M, Context);

m_find_value({kz_get_subscription,[{subscription_id, SubscriptionId},{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_get_subscription(SubscriptionId, kazoo_util:kz_list_subscriptions(AccountId, Context));

m_find_value(get_user_timezone, _M, Context) ->
    kazoo_util:get_user_timezone(Context);

m_find_value(tz_list, _M, _Context) ->
    ?TIMEZONES_LIST;

m_find_value(us_states_list, _M, _Context) ->
    ?US_STATES_LIST;

m_find_value(valid_card_exists, _M, Context) ->
    kazoo_util:valid_card_exists(Context);

m_find_value(is_service_plan_applied, _M, Context) ->
    kazoo_util:is_service_plan_applied(Context);

m_find_value(get_account_name, _M, Context) ->
    kazoo_util:get_account_name(Context);

m_find_value(get_account_realm, _M, Context) ->
    kazoo_util:get_account_realm(Context);

m_find_value(kz_list_classifiers, _M, Context) ->
    kazoo_util:kz_list_classifiers(Context);

m_find_value({rand_hex,[{length, Length}]}, _M, _Context) ->
    modkazoo_util:rand_hex_binary(Length);

m_find_value({kz_group_doc, [{group_id, GroupId}]}, _M, Context) ->
    kazoo_util:kz_get_group_doc(GroupId, Context);

m_find_value(kz_list_account_media, _M, Context) ->
    kazoo_util:kz_list_account_media(Context);

m_find_value(kz_list_account_media_short, _M, Context) ->
    [["","Default"]]
    ++
    lists:map(fun (MediaDoc) ->
                  [z_convert:to_list(modkazoo_util:get_value(<<"id">>,MediaDoc))
                  ,modkazoo_util:get_value(<<"name">>,MediaDoc)]
              end
             ,kazoo_util:kz_list_account_media(Context));

m_find_value(kz_list_account_menus, _M, Context) ->
    kazoo_util:kz_list_account_menus(Context);

m_find_value({kz_get_account_menu, [{menu_id, 'undefined'}]}, _M, _Context) ->
    modkazoo_util:new();
m_find_value({kz_get_account_menu, [{menu_id, MenuId}]}, _M, Context) ->
    kazoo_util:kz_menu('get',MenuId,Context);

m_find_value(kz_list_account_temporal_rules, _M, Context) ->
    kazoo_util:kz_list_account_temporal_rules(Context);

m_find_value({kz_get_temporal_rule, [{rule_id, 'undefined'}]}, _M, _Context) ->
    modkazoo_util:new();
m_find_value({kz_get_temporal_rule, [{rule_id, RuleId}]}, _M, Context) ->
    kazoo_util:kz_get_temporal_rule(RuleId, Context);

m_find_value({cf_get_element_by_id, [{element_id, ElementId}]}, _M, Context) ->
    cf_builder:cf_get_element_by_id(ElementId, Context);

m_find_value({kz_get_account_prompt, [{prompt_id, PromptId}]}, _M, Context) ->
    kazoo_util:kz_get_account_prompt(PromptId, Context);

m_find_value({cf_get_module_info, [{module_name, ModuleName},{module_path,ModulePath}]}, _M, Context) ->
    cf_builder:cf_get_module_info(ModuleName, binary:split(ModulePath, <<"-">>, [global]), Context);

m_find_value(kz_list_account_conferences, _M, Context) ->
    kazoo_util:kz_list_account_conferences(Context);

m_find_value(kz_list_account_c2calls, _M, Context) ->
    kazoo_util:kz_list_account_c2calls(Context);

m_find_value({kz_get_account_c2call, [{c2call_id, C2CallId}]}, _M, Context) ->
    kazoo_util:kz_c2call('get', C2CallId, Context);

m_find_value({kz_c2call_hyperlink, [{c2call_id, C2CallId}]}, _M, Context) ->
    kazoo_util:kz_c2call_hyperlink(C2CallId, Context);

m_find_value({kz_get_account_conference, [{conference_id, ConferenceId}]}, _M, Context) ->
    kazoo_util:kz_conference('get', ConferenceId, Context);

m_find_value({kz_get_featurecode_by_name, [{featurecode_name, FCName}]}, _M, Context) ->
    kazoo_util:kz_get_featurecode_by_name(FCName, Context);

m_find_value(get_callflow_numbers_and_patterns, _M, Context) ->
    CurrCallflow = z_context:get_session('current_callflow', Context),
    modkazoo_util:get_value(<<"numbers">>,CurrCallflow,[])++modkazoo_util:get_value(<<"patterns">>,CurrCallflow,[]);

m_find_value(kz_cccp_creds_list, _M, Context) ->
    kazoo_util:kz_cccp_creds_list(Context);

m_find_value({kz_find_account_by_number, [{phone_number, Number}]}, _M, Context) ->
    kazoo_util:kz_find_account_by_number(Number, Context);

m_find_value(get_account_registrations, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kazoo_util:kz_get_registrations_by_accountid(AccountId, Context);

m_find_value({get_registrations_by_accountid, [{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_get_registrations_by_accountid(AccountId, Context);

m_find_value({get_registrations_count_by_accountid, [{account_id, AccountId}]}, _M, Context) ->
    modkazoo_util:get_value(<<"count">>, kazoo_util:kz_get_registrations_count_by_accountid(AccountId, Context));

m_find_value(get_reseller_registrations, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kazoo_util:kz_get_reseller_registrations(AccountId, Context);

m_find_value(get_reseller_registrations_count, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    modkazoo_util:get_value(<<"count">>, kazoo_util:kz_get_reseller_registrations_count(AccountId, Context));

m_find_value(kz_list_account_trunks, _M, Context) ->
    kazoo_util:list_account_trunks(Context);

m_find_value({is_realms_synced, [{account_id, AccountId}]}, _M, Context) ->
    AccountRealm = kazoo_util:get_account_realm(AccountId, Context),
    lists:foldl(fun(X, Sum) -> (AccountRealm == X) and Sum end, 'true', kazoo_util:list_trunks_realm(AccountId, Context));

m_find_value({kz_get_account_trunk, [{trunk_id, TrunkId}]}, _M, Context) ->
    kazoo_util:kz_trunk('get', TrunkId, [], Context);

m_find_value({kz_get_trunk_server, [{trunk_id, TrunkId},{server_index, Index}]}, _M, Context) ->
    kazoo_util:kz_trunk_server_details(TrunkId, Index, Context);

m_find_value(kz_list_account_webhooks, _M, Context) ->
    kazoo_util:kz_list_account_webhooks(Context);

m_find_value({kz_webhook_info, [{webhook_id, WebhookId}]}, _M, Context) ->
    kazoo_util:kz_webhook_info(WebhookId, Context);

m_find_value(kz_current_context_reseller_status, _M, Context) ->
    kazoo_util:kz_current_context_reseller_status(Context);

m_find_value(kz_current_context_superadmin, _M, Context) ->
    kazoo_util:kz_current_context_superadmin(Context);

m_find_value(kz_callflows_numbers, _M, Context) ->
    kazoo_util:kz_callflows_numbers(Context);

m_find_value(kz_spare_numbers, _M, Context) ->
    kazoo_util:kz_spare_numbers(Context);

m_find_value(outbound_routing_strategy, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({outbound_routing_strategy, [{account_id, AccountId}]}, _M, Context);

m_find_value({outbound_routing_strategy, [{account_id, 'undefined'}]}, _M, _Context) ->
    ['undefined', 'undefined'];
m_find_value({outbound_routing_strategy, [{account_id, AccountId}]}, _M, Context) ->
    CF = kazoo_util:kz_callflow_by_number(<<"no_match">>, AccountId, Context),
    [modkazoo_util:get_value([<<"flow">>, <<"module">>], CF), modkazoo_util:get_value([<<"flow">>, <<"data">>, <<"hunt_account_id">>], CF)];

m_find_value(kz_list_account_resources, _M, Context) ->
    kazoo_util:kz_list_account_resources(Context);

m_find_value({kz_resource_info, [{resource_id, 'undefined'}]}, _M, _Context) ->
    'undefined';
m_find_value({kz_resource_info, [{resource_id, ResourceId}]}, _M, Context) ->
    kazoo_util:kz_resource_info(ResourceId, Context);

m_find_value(kz_list_account_notifications, _M, Context) ->
    kazoo_util:kz_list_account_notifications(Context);

m_find_value({kz_notification_info, [{notification_id, 'undefined'}]}, _M, _Context) ->
    'undefined';
m_find_value({kz_notification_info, [{notification_id, TemplateId}]}, _M, Context) ->
    kazoo_util:kz_notification_info(TemplateId, Context);

m_find_value({kz_notification_template, [{notification_id, 'undefined'}, {context_type, _}]}, _M, _Context) ->
    'undefined';
m_find_value({kz_notification_template, [{notification_id, _}, {context_type, 'undefined'}]}, _M, _Context) ->
    'undefined';
m_find_value({kz_notification_template, [{notification_id, TemplateId}, {context_type, ContextType}]}, _M, Context) ->
    kazoo_util:kz_notification_template(ContextType, TemplateId, Context);

m_find_value(kz_list_account_lists, _M, Context) ->
    kazoo_util:kz_list_account_lists(Context);

m_find_value({kz_get_account_list, [{list_id, 'undefined'}]}, _M, _Context) ->
    'undefined';
m_find_value({kz_get_account_list, [{list_id, ListId}]}, _M, Context) ->
    kazoo_util:kz_get_account_list(ListId, Context);

m_find_value({kz_list_account_list_entries, [{list_id, ListId}]}, _M, Context) ->
    kazoo_util:kz_list_account_list_entries(ListId, Context);

m_find_value({kz_conference_participants, [{conference_id, ConferenceId}]}, _M, Context) ->
    kazoo_util:kz_conference_participants(ConferenceId,Context);

m_find_value({kz_conference_participant, [{participant_id, ParticipantId}, {conference_id, ConferenceId}]}, _M, Context) ->
    kazoo_util:kz_conference_participant(ParticipantId,ConferenceId,Context);

m_find_value(notifications_smtplog, _M, Context) ->
    kazoo_util:notifications_smtplog(Context);

m_find_value({notifications_smtplog_by_id, [{notifications_smtplog_id, LogId}]}, _M, Context) ->
    kazoo_util:notifications_smtplog_by_id(LogId, Context);

m_find_value(rs_customer_update_subject, _M, Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_subject.tpl",
    case file:read_file(Filename) of
        {'ok', Data} -> Data;
        _ -> m_config:get_value('mod_kazoo', 'sender_name', Context)
    end;

m_find_value(rs_customer_update_html, _M, Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_html.tpl",
    case file:read_file(Filename) of
        {'ok', Data} ->
            Data;
        _ ->
            {Html, Context} = z_template:render_to_iolist("rs_customer_update_html.tpl", [], Context),
            Html
    end;

m_find_value(rs_customer_update_text, _M, Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_text.tpl",
    case file:read_file(Filename) of
        {'ok', Data} ->
            Data;
        _ ->
            {Text, Context} = z_template:render_to_iolist("rs_customer_update_text.tpl", [], Context),
            Text
    end;

m_find_value(list_system_dialplans_names, _M, Context) ->
    kazoo_util:list_system_dialplans_names(Context);

m_find_value({cf_notes_get, [{type, Type}]}, _M, Context) ->
    cf_builder:cf_notes_get(Type, Context);

m_find_value(kz_account_access_lists, _M, Context) ->
    kazoo_util:kz_account_access_lists('get', [], Context);

m_find_value({kz_device_access_lists,[{device_id, DeviceId}]}, _M, Context) ->
    kazoo_util:kz_device_access_lists('get', DeviceId, [], Context);

m_find_value(limits, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({limits,[{account_id, AccountId}]}, _M, Context);
m_find_value({limits,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({limits,[{account_id, AccountId}]}, _M, Context);
m_find_value({limits,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_limits('get', AccountId, [], Context);

m_find_value({allotments,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({allotments,[{account_id, AccountId}]}, _M, Context);
m_find_value({allotments,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_allotments('get', AccountId, [], Context);

m_find_value({allotments_consumed,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({allotments_consumed,[{account_id, AccountId}]}, _M, Context);
m_find_value({allotments_consumed,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:kz_allotments_consumed('get', AccountId, [], Context);

m_find_value(numbers_countries_list, _M, Context) ->
    case m_config:get_value('mod_kazoo', 'numbers_countries_list', Context) of
        'undefined' -> [<<"US">>];
        Countries -> binary:split(Countries, <<",">>, ['global'])
    end;

m_find_value(all_tasks, _M, Context) ->
    kazoo_util:all_tasks(Context);

m_find_value(account_tasks, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({account_tasks,[{account_id, AccountId}]}, _M, Context);
m_find_value({account_tasks,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({account_tasks,[{account_id, AccountId}]}, _M, Context);
m_find_value({account_tasks,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:account_tasks('get', AccountId, [], Context);

m_find_value({metaflows,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({metaflows,[{account_id, AccountId}]}, _M, Context);
m_find_value({metaflows,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:metaflows('get', AccountId, [], Context);

m_find_value({queues,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({queues,[{account_id, AccountId}]}, _M, Context);
m_find_value({queues,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:queues('get', AccountId, [], Context);

m_find_value({queue,[{queue_id, 'undefined'}, {account_id, _AccountId}]}, _M, _Context) ->
    'undefined';
m_find_value({queue,[{queue_id, QueueId}, {account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({queue,[{queue_id, QueueId}, {account_id, AccountId}]}, _M, Context);
m_find_value({queue,[{queue_id, QueueId}, {account_id, AccountId}]}, _M, Context) ->
    kazoo_util:queue('get', QueueId, AccountId, [], Context);

m_find_value({queue_roster,[{queue_id, 'undefined'}, {account_id, _AccountId}]}, _M, _Context) ->
    'undefined';
m_find_value({queue_roster,[{queue_id, QueueId}, {account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({queue_roster,[{queue_id, QueueId}, {account_id, AccountId}]}, _M, Context);
m_find_value({queue_roster,[{queue_id, QueueId}, {account_id, AccountId}]}, _M, Context) ->
    kazoo_util:queue_roster('get', QueueId, AccountId, [], Context);

m_find_value(acdc_call_stats, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    kazoo_util:acdc_call_stats(AccountId, Context);

m_find_value({agents,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({agents,[{account_id, AccountId}]}, _M, Context);
m_find_value({agents,[{account_id, AccountId}]}, _M, Context) ->
    kazoo_util:agents('get', AccountId, [], Context);

m_find_value({agents_status,[{agent_id, 'undefined'}, {account_id, _AccountId}]}, _M, _Context) ->
    'undefined';
m_find_value({agents_status,[{agent_id, AgentId}, {account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({agents_status,[{agent_id, AgentId}, {account_id, AccountId}]}, _M, Context);
m_find_value({agents_status,[{agent_id, AgentId}, {account_id, AccountId}]}, _M, Context) ->
    kazoo_util:agents_status('get', AgentId, AccountId, [], Context);

m_find_value({agents_queue_status,[{agent_id, 'undefined'}, {account_id, _AccountId}]}, _M, _Context) ->
    'undefined';
m_find_value({agents_queue_status,[{agent_id, AgentId}, {account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_find_value({agents_queue_status,[{agent_id, AgentId}, {account_id, AccountId}]}, _M, Context);
m_find_value({agents_queue_status,[{agent_id, AgentId}, {account_id, AccountId}]}, _M, Context) ->
    kazoo_util:agents_queue_status('get', AgentId, AccountId, [], Context);

m_find_value(_V, _VV, _Context) ->
    lager:info("m_find_value _V: ~p", [_V]),
    lager:info("m_find_value _VV: ~p", [_VV]),
    [_V,_VV,"m_kazoo_find_value_mismatch"].

m_to_list(_V, _Context) ->
    lager:info("m_to_list _V: ~p", [_V]),
    [_V,"m_to_list"].

m_value(#m{value=V}, _Context) -> V.

