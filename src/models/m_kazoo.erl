-module(m_kazoo).
-author("kirill.sysoev@gmail.com").

-behaviour(gen_model).

-export([m_get/2
]).

-include_lib("zotonic_core/include/zotonic.hrl").
-include_lib("../include/mod_kazoo.hrl").

-spec m_get( list(), z:context() ) -> { term(), list() }.

m_get([ is_auth | Rest ], Context) ->
  {modkazoo_auth:is_auth(Context), Rest};

m_get([ is_peer_phiz_whitelisted | Rest ], Context) ->
  {modkazoo_auth:is_peer_phiz_whitelisted(Context), Rest};

m_get([ signal_filter | Rest ], Context) ->
  {z_session_manager:get_session_id(Context), Rest};

m_get([ is_kazoo_account_admin | Rest ], Context) ->
  {kazoo_util:is_kazoo_account_admin(Context), Rest};

m_get([ get_kazoo_account_id | Rest ], Context) ->
  {z_context:get_session(kazoo_account_id, Context), Rest};

m_get([ kz_current_context_superadmin | Rest ], Context) ->
  {kazoo_util:kz_current_context_superadmin(Context), Rest};

m_get([ kz_current_context_reseller_status | Rest ], Context) ->
  {kazoo_util:kz_current_context_reseller_status(Context), Rest};

m_get([ kz_list_account_children | Rest ], Context) ->
  {kazoo_util:kz_list_account_children(Context), Rest};

m_get([ kz_list_account_users | Rest ], Context) ->
  {kazoo_util:kz_list_account_users(Context), Rest};

m_get([ {kz_list_account_users, [{account_id, AccountId}]} | Rest ], Context) ->
  {kazoo_util:kz_list_account_users(AccountId, Context), Rest};

m_get([ {kz_get_acc_doc_by_account_id, [{account_id, AccountId}]} | Rest ], Context) ->
  {kazoo_util:kz_get_acc_doc_by_account_id(AccountId, Context), Rest};

m_get([ {kz_doc_field, [{type,Type}, {doc_id, _DocId}, {field, Field}, {account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {kz_doc_field, [{type,Type}, {doc_id, _DocId}, {field, Field}, {account_id, AccountId}]} | Rest ], Context);

m_get([ {kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}, {account_id, AccountId}]} | Rest], Context) ->
    case Type of
        <<"account">> -> {kazoo_util:kz_account_doc_field(Field, AccountId, Context), Rest};
        <<"user">> -> {kazoo_util:kz_user_doc_field(Field, DocId, Context), Rest};
        <<"device">> -> {kazoo_util:kz_device_doc_field(Field, DocId, Context), Rest};
        <<"media">> -> {kazoo_util:kz_media_doc_field(Field, DocId, Context), Rest};
        <<"cccp_creds">> -> {kazoo_util:cccp_field(Field, DocId, Context), Rest};
        <<"onbill_variables">> -> {onbill_util:variables_field(Field, AccountId, Context), Rest};
        <<"config">> -> {z_notifier:first({'doc_field', 'get', ?TO_BIN(DocId), Field, AccountId}, Context), Rest};
        E -> {lager:info("kz_doc_field Error: ~p",[E]), Rest}
    end;

m_get([ {kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}]} | Rest ], Context) ->
    case Type of
        <<"account">> -> {kazoo_util:kz_account_doc_field(Field, Context), Rest};
        <<"user">> -> {kazoo_util:kz_user_doc_field(Field, DocId, Context), Rest};
        <<"device">> -> {kazoo_util:kz_device_doc_field(Field, DocId, Context), Rest};
        <<"media">> -> {kazoo_util:kz_media_doc_field(Field, DocId, Context), Rest};
        E -> {lager:info("kz_doc_field Error: ~p",[E]), Rest}
    end;

m_get([ tz_list | Rest], _Context) ->
    {?TIMEZONES_LIST, Rest};

m_get([ kz_current_service_plans | Rest ], Context) ->
    {kazoo_util:current_service_plans(Context), Rest};

m_get([ {kz_current_service_plans, [{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:current_service_plans(AccountId, Context), Rest};

m_get([ services_status | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {services_status, [{account_id, AccountId}]} | Rest ], Context);

m_get([ {services_status, [{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {services_status, [{account_id, AccountId}]} | Rest ], Context);
m_get([ {services_status, [{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:services_status('get', AccountId, [], Context), Rest};

m_get([ {ui_element_opened,[{element, ElementName}]} | Rest ], Context) ->
    {kazoo_util:ui_element_state(ElementName, Context), Rest};

%m_get([ {get_registrations | Rest ], _Context) ->
%    [];

%m_get([ {is_operators_session | Rest ], _Context) ->
%    true;

m_get([ kz_get_acc_doc | Rest ], Context) ->
    {kazoo_util:kz_get_acc_doc(Context), Rest};

m_get([ {kz_account_doc_field, [{field1, Field1}]} | Rest ], Context) ->
    {kazoo_util:kz_account_doc_field(Field1, Context), Rest};

m_get([ {kz_account_doc_field, [{field1, Field1}, {field2, Field2}]} | Rest ], Context) ->
    {kazoo_util:kz_account_doc_field([Field1, Field2], Context), Rest};

m_get([ {kz_account_doc_field, [{field1, Field1}, {field2, Field2}, {field3, Field3}]} | Rest ], Context) ->
    {kazoo_util:kz_account_doc_field([Field1, Field2, Field3], Context), Rest};

m_get([ {kz_device_doc, [{device_id, DeviceId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_device_doc(DeviceId, Context), Rest};

m_get([ {kz_user_doc_by_ownerid, [{owner_id, OwnerId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_user_doc(OwnerId, Context), Rest};

m_get([ {kz_user_doc_field, [{user_id, UserId}, {field1, Field1}]} | Rest ], Context) ->
    {kazoo_util:kz_user_doc_field(Field1, UserId, Context), Rest};

m_get([ {kz_user_doc_field, [{field1, Field1}]} | Rest ], Context) ->
    {kazoo_util:kz_user_doc_field(Field1, Context), Rest};

m_get([ {kz_user_doc_field, [{field1, Field1}, {field2, Field2}]} | Rest ], Context) ->
    {kazoo_util:kz_user_doc_field([Field1, Field2], Context), Rest};

m_get([ {kz_user_doc_field, [{field1, Field1}, {field2, Field2}, {field3, Field3}]} | Rest ], Context) ->
    {kazoo_util:kz_user_doc_field([Field1, Field2, Field3], Context), Rest};

m_get([ {kz_device_doc_field, [{device_id, DeviceId}, {field, Field}]} | Rest ], Context) ->
    {kazoo_util:kz_device_doc_field(Field, DeviceId, Context), Rest};

m_get([ kz_list_account_groups | Rest ], Context) ->
    {kazoo_util:kz_list_account_groups(Context), Rest};

m_get([ kz_list_account_blacklists | Rest ], Context) ->
    {kazoo_util:kz_list_account_blacklists(Context), Rest};

m_get([ kz_list_account_channels | Rest ], Context) ->
    {kazoo_util:kz_list_account_channels(Context), Rest};

m_get([ {kz_list_account_channels, [{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_account_channels(AccountId, Context), Rest};

m_get([ get_reseller_channels | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {kazoo_util:kz_get_reseller_channels(AccountId, Context), Rest};

m_get([ {kz_channel_info, [{uuid, UUId}, {account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_channel_info(UUId, AccountId, Context), Rest};

m_get([ kz_list_account_callflows | Rest ], Context) ->
    {kazoo_util:kz_list_account_callflows(Context), Rest};

m_get([ {kz_list_account_callflows, [{filter, Filter}]} | Rest ], Context) ->
    JObjs = kazoo_util:kz_list_account_callflows(Context),
    {lists:filter(fun(X) -> modkazoo_util2:if_substring_in_json(Filter, kazoo_util:kz_get_account_callflow(modkazoo_util:get_value(<<"id">>,X), Context)) end, JObjs), Rest};

m_get([ {kz_get_account_callflow, [{callflow_id,CallflowId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_account_callflow(CallflowId, Context), Rest};

m_get([ {kz_get_account_blacklist, [{blacklist_id, BlacklistId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_account_blacklist(BlacklistId, Context), Rest};

m_get([ kz_list_account_users_short | Rest ], Context) ->
    {lists:map(fun (UserDoc) -> [modkazoo_util:get_value(<<"id">>,UserDoc)
                               ,<<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary
                                 ," "
                                 ,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>
                               ]
              end,
              kazoo_util:kz_list_account_users(Context))  ++ [["","-No owner-"]], Rest};

m_get([ kz_list_account_devices | Rest ], Context) ->
    {kazoo_util:kz_list_account_devices(Context), Rest};

m_get([ kz_list_account_devices_short | Rest ], Context) ->
    {lists:map(fun (DeviceDoc) -> [z_convert:to_list(modkazoo_util:get_value(<<"id">>,DeviceDoc)),modkazoo_util:get_value(<<"name">>,DeviceDoc)] end, kazoo_util:kz_list_account_devices(Context))
        ++ [["","-No owner-"]], Rest};

m_get([ kz_list_user_devices | Rest ], Context) ->
    {kazoo_util:kz_list_user_devices(Context), Rest};

m_get([ {kz_list_user_devices, [{owner_id, OwnerId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_user_devices(OwnerId, Context), Rest};

m_get([ kz_list_account_vmboxes | Rest ], Context) ->
    {kazoo_util:kz_list_account_vmboxes(Context), Rest};

m_get([ kz_list_user_vmboxes | Rest ], Context) ->
    {kazoo_util:kz_list_user_vmboxes(Context), Rest};

m_get([ {kz_list_user_vmbox_details, [{vmbox_id, 'undefined'}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {kz_list_user_vmbox_details, [{vmbox_id, VMBoxId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_user_vmbox_details(VMBoxId, Context), Rest};

m_get([ {kz_list_user_vmbox_messages, [{vmbox_id, VMBoxId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_user_vmbox_messages(VMBoxId, Context), Rest};

m_get([ {kz_vmessage_download_link, [{vmbox_id, VMBoxId}, {media_id, MediaId}]} | Rest ], Context) ->
    {kazoo_util:kz_vmessage_download_link(VMBoxId, MediaId, Context), Rest};

m_get([ {z_recording_download_link, [{cdr_id, CallId}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    {kazoo_util:kz_kzattachment_link(AccountId, CallId, AuthToken, "call_recording", Context), Rest};

m_get([ {kz_incoming_fax_download_link, [{doc_id, DocId}]} | Rest ], Context) ->
    {kazoo_util:kz_incoming_fax_download_link(DocId, Context), Rest};

m_get([ list_account_recordings | Rest ], Context) ->
    {kazoo_util:list_account_recordings(Context), Rest};

m_get([ {list_user_cdr,[{created_from, 'undefined'},{'created_to', 'undefined'}]} | Rest ], Context) ->
    {kazoo_util:kz_list_user_cdr_reduced(modkazoo_util:today_begins_tstamp(Context), modkazoo_util:today_ends_tstamp(Context), Context), Rest};
m_get([ {list_user_cdr,[{created_from, CreatedFrom},{'created_to', CreatedTo}]} | Rest ], Context) ->
    {kazoo_util:kz_list_user_cdr_reduced(CreatedFrom, CreatedTo, Context), Rest};

m_get([ {list_account_cdr,[{'created_from', CreatedFrom},{'created_to', CreatedTo},{'account_id', 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {list_account_cdr,[{'created_from', CreatedFrom},{'created_to', CreatedTo},{'account_id', AccountId}]} | Rest ], Context);
m_get([ {list_account_cdr,[{created_from, 'undefined'},{'created_to', 'undefined'},{'account_id', _AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_account_cdr_reduced(modkazoo_util:today_begins_tstamp(Context), modkazoo_util:today_ends_tstamp(Context), Context), Rest};
m_get([ {list_account_cdr,[{'created_from', CreatedFrom},{'created_to', CreatedTo},{'account_id', _AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_account_cdr_reduced(CreatedFrom, CreatedTo, Context), Rest};

m_get([ {kz_fetch_cdr_details, [{cdr_id, CDR_Id}]} | Rest ], Context) ->
    {kazoo_util:kz_fetch_cdr_details(CDR_Id, Context), Rest};

m_get([ {kz_cdr_legs,[{cdr_id,undefined}]} | Rest ], _Context) ->
    {[], Rest};
m_get([ {kz_cdr_legs,[{cdr_id,CDR_Id}]} | Rest ], Context) ->
    {kazoo_util:kz_cdr_legs_localized(CDR_Id, Context), Rest};

m_get([ current_account_credit | Rest ], Context) ->
    {modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(Context)), Rest};

m_get([ {current_account_credit, [{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(AccountId, Context)), Rest};

m_get([ {current_account_credit, [{account_id, AccountId}]} | Rest ], Context) ->
    {modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(AccountId, Context)), Rest};

m_get([ {service_plan, [{plan_id, PlanId}]} | Rest ], Context) ->
    {kazoo_util:service_plan(PlanId, Context), Rest};

m_get([ {service_plan, [{plan_id, PlanId},{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:service_plan(PlanId, AccountId, Context), Rest};

m_get([ kz_service_plans | Rest ], Context) ->
    {kazoo_util:service_plans(Context), Rest};

m_get([ {kz_service_plans, [{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:service_plans(AccountId, Context), Rest};

m_get([ kz_service_plans_available | Rest ], Context) ->
    {kazoo_util:available_service_plans(Context), Rest};

m_get([ {kz_service_plans_available, [{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:available_service_plans(AccountId, Context), Rest};

m_get([ {kz_check_device_registration, [{device_id, DeviceId}]} | Rest ], Context) ->
    {kazoo_util:kz_check_device_registration(DeviceId, Context), Rest};

m_get([ {kz_registration_details_by_username, [{username, Username}]} | Rest ], Context) ->
    {kazoo_util:kz_registration_details_by_username(Username, Context), Rest};

m_get([ {kz_get_device_registration_details, [{device_id, DeviceId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_device_registration_details(DeviceId, Context), Rest};

m_get([ azrates | Rest ], Context) ->
    {kazoo_util:azrates(Context), Rest};

m_get([ kz_list_incoming_faxes | Rest ], Context) ->
    {kazoo_util:kz_list_incoming_faxes(Context), Rest};

m_get([ get_acc_numbers | Rest ], Context) ->
    {lists:sort(z_convert:to_list(kazoo_util:kz_account_numbers(Context))), Rest};

m_get([ {get_acc_numbers, [{account_id,AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_account_numbers(AccountId,Context), Rest};

m_get([ get_acc_numbers_info | Rest ], Context) ->
    {kazoo_util:kz_account_numbers_info(Context), Rest};

m_get([ {get_acc_numbers_info, [{account_id,AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_account_numbers_info(AccountId,Context), Rest};

m_get([ {number_info, [{number, Number}]} | Rest ], Context) ->
    {kazoo_util:phone_number(Number, Context), Rest};

m_get([ {number_info, [{number, Number},{account_id,AccountId}]} | Rest ], Context) ->
    {kazoo_util:phone_number('get', Number, AccountId, [], Context), Rest};

m_get([ kz_list_outgoing_faxes | Rest ], Context) ->
    {lists:sort(z_convert:to_list(kazoo_util:kz_list_outgoing_faxes(Context))), Rest};

m_get([ kz_bt_transactions | Rest ], Context) ->
    {lists:sort(z_convert:to_list(kazoo_util:kz_bt_transactions(Context))), Rest};

m_get([ kz_list_transactions | Rest ], Context) ->
    {lists:sort(z_convert:to_list(kazoo_util:kz_list_transactions(Context))), Rest};

m_get([ {kz_list_transactions,[{account_id,AccountId}]} | Rest ], Context) ->
    {lists:sort(z_convert:to_list(kazoo_util:kz_list_transactions(AccountId,Context))), Rest};

m_get([ {kz_list_transactions,[{account_id, 'undefined'},{selected_billing_period,SelectedBillingPeriod},{type,Type}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {kz_list_transactions,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{type,Type}]} | Rest ], Context);
m_get([ {kz_list_transactions,[{account_id,AccountId},{selected_billing_period,'undefined'},{type,Type}]} | Rest ], Context) ->
    CurrBillingPeriod = onbill_util:current_billing_period(AccountId, Context),
    StartPeriodTS = modkazoo_util:get_value([<<"period_start">>, <<"day_begins_ts">>], CurrBillingPeriod),
    EndPeriodTS = modkazoo_util:get_value([<<"period_end">>, <<"day_ends_ts">>], CurrBillingPeriod),
    SelectedBillingPeriod = z_convert:to_list(StartPeriodTS) ++ "," ++ z_convert:to_list(EndPeriodTS),
    m_get([ {kz_list_transactions,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{type,Type}]} | Rest ], Context);

m_get([ {kz_list_transactions,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{type,Type}]} | Rest ], Context) ->
    [CF,CT] = z_string:split(SelectedBillingPeriod, ","),
    CreatedFrom = z_convert:to_integer(CF),
    CreatedTo = z_convert:to_integer(CT),
    Transactions = kazoo_util:kz_list_transactions(AccountId, CreatedFrom, CreatedTo, 'undefined', Context),
    case Type of
        <<"debit">> ->
            {kazoo_util:debit_transactions(Transactions), Rest};
        <<"debit_summ">> ->
            {lists:foldl(fun(X,Acc) -> modkazoo_util:get_value(<<"amount">>, X) + Acc end, 0, kazoo_util:debit_transactions(Transactions)), Rest};
        <<"credit">> ->
            {kazoo_util:credit_transactions(Transactions), Rest};
        <<"credit_summ">> ->
            {lists:foldl(fun(X,Acc) -> modkazoo_util:get_value(<<"amount">>, X) + Acc end, 0, kazoo_util:credit_transactions(Transactions)), Rest}
    end;

m_get([ {period_balance,[{account_id,'undefined'},{selected_billing_period,SelectedBillingPeriod}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {period_balance,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod}]} | Rest ], Context);
m_get([ {period_balance,[{account_id,AccountId},{selected_billing_period,'undefined'}]} | Rest ], Context) ->
    {onbill_util:period_balance(AccountId, modkazoo_util:current_tstamp(Context), Context), Rest};
m_get([ {period_balance,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod}]} | Rest ], Context) ->
    [Ts,_] = z_string:split(SelectedBillingPeriod, ","),
    Timestamp = z_convert:to_integer(Ts),
    {onbill_util:period_balance(AccountId, Timestamp, Context), Rest};

m_get([ {kz_list_ledgers,[{account_id, 'undefined'},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]} | Rest ], Context);

m_get([ {kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,'undefined'},{ledger_id,LedgerId}]} | Rest ], Context) ->
    CurrBillingPeriod = onbill_util:current_billing_period(AccountId, Context),
    StartPeriodTS = modkazoo_util:get_value([<<"period_start">>, <<"day_begins_ts">>], CurrBillingPeriod),
    EndPeriodTS = modkazoo_util:get_value([<<"period_end">>, <<"day_ends_ts">>], CurrBillingPeriod),
    SelectedBillingPeriod = z_convert:to_list(StartPeriodTS) ++ "," ++ z_convert:to_list(EndPeriodTS),
    m_get([ {kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]} | Rest ], Context);

m_get([ {kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]} | Rest ], Context) ->
    [CF,CT] = z_string:split(SelectedBillingPeriod, ","),
    CreatedFrom = z_convert:to_integer(CF),
    CreatedTo = z_convert:to_integer(CT),
    {kazoo_util:kz_list_ledgers(LedgerId, AccountId, CreatedFrom, CreatedTo, Context), Rest};

m_get([ {kz_ledgers_summ,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]} | Rest ], Context) ->
    {LedgersList, _} =
        m_get([ {kz_list_ledgers,[{account_id,AccountId},{selected_billing_period,SelectedBillingPeriod},{ledger_id,LedgerId}]} | Rest ]
                    ,Context),
    {lists:foldl(fun(X, Acc) -> case modkazoo_util:get_value([<<"source">>,<<"service">>], X) of
                                   LedgerId -> Acc + modkazoo_util:get_value([<<"amount">>], X);
                                   _ -> Acc
                               end
                 end
                ,0
                ,LedgersList), Rest};

m_get([ bt_client_token | Rest ], Context) ->
    {bt_util:bt_client_token(Context), Rest};

m_get([ kz_bt_customer | Rest ], Context) ->
    {kazoo_util:kz_bt_customer(Context), Rest};

m_get([ kz_list_subscriptions | Rest ], Context) ->
    {kazoo_util:kz_list_subscriptions(Context), Rest};

m_get([ {kz_get_subscription,[{subscription_id, SubscriptionId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_subscription(SubscriptionId, kazoo_util:kz_list_subscriptions(Context)), Rest};

m_get([ {kz_get_subscription,[{subscription_id, SubscriptionId},{account_id, 'undefined'}]} | Rest ], Context) ->
    m_get([ {kz_get_subscription,[{subscription_id, SubscriptionId}]} | Rest ], Context);

m_get([ {kz_get_subscription,[{subscription_id, SubscriptionId},{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_subscription(SubscriptionId, kazoo_util:kz_list_subscriptions(AccountId, Context)), Rest};

m_get([ get_user_timezone | Rest ], Context) ->
    {kazoo_util:get_user_timezone(Context), Rest};

m_get([ us_states_list | Rest ], _Context) ->
    {?US_STATES_LIST, Rest};

m_get([ valid_card_exists | Rest ], Context) ->
    {kazoo_util:valid_card_exists(Context), Rest};

m_get([ is_service_plan_applied | Rest ], Context) ->
    {kazoo_util:is_service_plan_applied(Context), Rest};

m_get([ get_account_name | Rest ], Context) ->
    {kazoo_util:get_account_name(Context), Rest};

m_get([ get_account_realm | Rest ], Context) ->
    {kazoo_util:get_account_realm(Context), Rest};

m_get([ kz_list_classifiers | Rest ], Context) ->
    {kazoo_util:kz_list_classifiers(Context), Rest};

m_get([ {rand_hex,[{length, Length}]} | Rest ], _Context) ->
    {modkazoo_util:rand_hex_binary(Length), Rest};

m_get([ {kz_group_doc, [{group_id, GroupId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_group_doc(GroupId, Context), Rest};

m_get([ kz_list_account_media | Rest ], Context) ->
    {kazoo_util:kz_list_account_media(Context), Rest};

m_get([ kz_list_account_media_short | Rest ], Context) ->
    {[["","Default"]]
    ++
    lists:map(fun (MediaDoc) ->
                  [z_convert:to_list(modkazoo_util:get_value(<<"id">>,MediaDoc))
                  ,modkazoo_util:get_value(<<"name">>,MediaDoc)]
              end
             ,kazoo_util:kz_list_account_media(Context)), Rest};

m_get([ kz_list_account_menus | Rest ], Context) ->
    {kazoo_util:kz_list_account_menus(Context), Rest};

m_get([ {kz_get_account_menu, [{menu_id, 'undefined'}]} | Rest ], _Context) ->
    {modkazoo_util:new(), Rest};
m_get([ {kz_get_account_menu, [{menu_id, MenuId}]} | Rest ], Context) ->
    {kazoo_util:kz_menu('get',MenuId,Context), Rest};

m_get([ kz_list_account_temporal_rules | Rest ], Context) ->
    {kazoo_util:kz_list_account_temporal_rules(Context), Rest};

m_get([ {kz_get_temporal_rule, [{rule_id, 'undefined'}]} | Rest ], _Context) ->
    {modkazoo_util:new(), Rest};
m_get([ {kz_get_temporal_rule, [{rule_id, RuleId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_temporal_rule(RuleId, Context), Rest};

m_get([ {cf_get_element_by_id, [{element_id, ElementId}]} | Rest ], Context) ->
    {cf_builder:cf_get_element_by_id(ElementId, Context), Rest};

m_get([ {kz_get_account_prompt, [{prompt_id, PromptId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_account_prompt(PromptId, Context), Rest};

m_get([ {cf_get_module_info, [{module_name, ModuleName},{module_path,ModulePath}]} | Rest ], Context) ->
    {cf_builder:cf_get_module_info(ModuleName, binary:split(ModulePath, <<"-">>, [global]), Context), Rest};

m_get([ kz_list_account_conferences | Rest ], Context) ->
    {kazoo_util:kz_list_account_conferences(Context), Rest};

m_get([ kz_list_account_c2calls | Rest ], Context) ->
    {kazoo_util:kz_list_account_c2calls(Context), Rest};

m_get([ {kz_get_account_c2call, [{c2call_id, C2CallId}]} | Rest ], Context) ->
    {kazoo_util:kz_c2call('get', C2CallId, Context), Rest};

m_get([ {kz_c2call_hyperlink, [{c2call_id, C2CallId}]} | Rest ], Context) ->
    {kazoo_util:kz_c2call_hyperlink(C2CallId, Context), Rest};

m_get([ {kz_get_account_conference, [{conference_id, ConferenceId}]} | Rest ], Context) ->
    {kazoo_util:kz_conference('get', ConferenceId, Context), Rest};

m_get([ {kz_get_featurecode_by_name, [{featurecode_name, FCName}]} | Rest ], Context) ->
    {kazoo_util:kz_get_featurecode_by_name(FCName, Context), Rest};

m_get([ get_callflow_numbers_and_patterns | Rest ], Context) ->
    CurrCallflow = z_context:get_session('current_callflow', Context),
    {modkazoo_util:get_value(<<"numbers">>,CurrCallflow,[])++modkazoo_util:get_value(<<"patterns">>,CurrCallflow,[]), Rest};

m_get([ kz_cccp_creds_list | Rest ], Context) ->
    {kazoo_util:kz_cccp_creds_list(Context), Rest};

m_get([ {kz_find_account_by_number, [{phone_number, Number}]} | Rest ], Context) ->
    {kazoo_util:kz_find_account_by_number(Number, Context), Rest};

m_get([ get_account_registrations | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {kazoo_util:kz_get_registrations_by_accountid(AccountId, Context), Rest};

m_get([ {get_registrations_by_accountid, [{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_registrations_by_accountid(AccountId, Context), Rest};

m_get([ {get_registrations_count_by_accountid, [{account_id, AccountId}]} | Rest ], Context) ->
    {modkazoo_util:get_value(<<"count">>, kazoo_util:kz_get_registrations_count_by_accountid(AccountId, Context)), Rest};

m_get([ get_reseller_registrations | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {kazoo_util:kz_get_reseller_registrations(AccountId, Context), Rest};

m_get([ get_reseller_registrations_count | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {modkazoo_util:get_value(<<"count">>, kazoo_util:kz_get_reseller_registrations_count(AccountId, Context)), Rest};

m_get([ kz_list_account_trunks | Rest ], Context) ->
    {kazoo_util:list_account_trunks(Context), Rest};

m_get([ {is_realms_synced, [{account_id, AccountId}]} | Rest ], Context) ->
    AccountRealm = kazoo_util:get_account_realm(AccountId, Context),
    {lists:foldl(fun(X, Sum) -> (AccountRealm == X) and Sum end, 'true', kazoo_util:list_trunks_realm(AccountId, Context)), Rest};

m_get([ {kz_get_account_trunk, [{trunk_id, TrunkId}]} | Rest ], Context) ->
    {kazoo_util:kz_trunk('get', TrunkId, [], Context), Rest};

m_get([ {kz_get_trunk_server, [{trunk_id, TrunkId},{server_index, Index}]} | Rest ], Context) ->
    {kazoo_util:kz_trunk_server_details(TrunkId, Index, Context), Rest};

m_get([ kz_list_webhooks | Rest ], Context) ->
    {kazoo_util:kz_list_webhooks(Context), Rest};

m_get([ kz_list_webhooks_ids | Rest ], Context) ->
    Ids = [modkazoo_util:get_value([<<"id">>], Hook)  || Hook <- kazoo_util:kz_list_webhooks(Context)],
    {Ids, Rest};

m_get([ kz_list_account_webhooks | Rest ], Context) ->
    {kazoo_util:kz_list_account_webhooks(Context), Rest};

m_get([ {kz_webhook_info, [{webhook_id, WebhookId}]} | Rest ], Context) ->
    {kazoo_util:kz_webhook_info(WebhookId, Context), Rest};

m_get([ kz_callflows_numbers | Rest ], Context) ->
    {kazoo_util:kz_callflows_numbers(Context), Rest};

m_get([ kz_spare_numbers | Rest ], Context) ->
    {kazoo_util:kz_spare_numbers(Context), Rest};

m_get([ outbound_routing_strategy | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {outbound_routing_strategy, [{account_id, AccountId}]} | Rest ], Context);

m_get([ {outbound_routing_strategy, [{account_id, 'undefined'}]} | Rest ], _Context) ->
    {['undefined', 'undefined'], Rest};
m_get([ {outbound_routing_strategy, [{account_id, AccountId}]} | Rest ], Context) ->
    CF = kazoo_util:kz_callflow_by_number(<<"no_match">>, AccountId, Context),
    {[modkazoo_util:get_value([<<"flow">>, <<"module">>], CF), modkazoo_util:get_value([<<"flow">>, <<"data">>, <<"hunt_account_id">>], CF)], Rest};

m_get([ kz_list_account_resources | Rest ], Context) ->
    {kazoo_util:kz_list_account_resources(Context), Rest};

m_get([ {kz_resource_info, [{resource_id, 'undefined'}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {kz_resource_info, [{resource_id, ResourceId}]} | Rest ], Context) ->
    {kazoo_util:kz_resource_info(ResourceId, Context), Rest};

m_get([ kz_list_account_notifications | Rest ], Context) ->
    {kazoo_util:kz_list_account_notifications(Context), Rest};

m_get([ {kz_notification_info, [{notification_id, 'undefined'}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {kz_notification_info, [{notification_id, TemplateId}]} | Rest ], Context) ->
    {kazoo_util:kz_notification_info(TemplateId, Context), Rest};

m_get([ {kz_notification_template, [{notification_id, 'undefined'}, {context_type, _}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {kz_notification_template, [{notification_id, _}, {context_type, 'undefined'}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {kz_notification_template, [{notification_id, TemplateId}, {context_type, ContextType}]} | Rest ], Context) ->
    {kazoo_util:kz_notification_template(ContextType, TemplateId, Context), Rest};

m_get([ kz_list_account_lists | Rest ], Context) ->
    {kazoo_util:kz_list_account_lists(Context), Rest};

m_get([ {kz_get_account_list, [{list_id, 'undefined'}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {kz_get_account_list, [{list_id, ListId}]} | Rest ], Context) ->
    {kazoo_util:kz_get_account_list(ListId, Context), Rest};

m_get([ {kz_list_account_list_entries, [{list_id, ListId}]} | Rest ], Context) ->
    {kazoo_util:kz_list_account_list_entries(ListId, Context), Rest};

m_get([ {kz_conference_participants, [{conference_id, ConferenceId}]} | Rest ], Context) ->
    {kazoo_util:kz_conference_participants(ConferenceId,Context), Rest};

m_get([ {kz_conference_participant, [{participant_id, ParticipantId}, {conference_id, ConferenceId}]} | Rest ], Context) ->
    {kazoo_util:kz_conference_participant(ParticipantId,ConferenceId,Context), Rest};

m_get([ notifications_smtplog | Rest ], Context) ->
    {kazoo_util:notifications_smtplog(Context), Rest};

m_get([ {notifications_smtplog_by_id, [{notifications_smtplog_id, LogId}]} | Rest ], Context) ->
    {kazoo_util:notifications_smtplog_by_id(LogId, Context), Rest};

m_get([ rs_customer_update_subject | Rest ], Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_subject.tpl",
    case file:read_file(Filename) of
        {'ok', Data} -> {Data, Rest};
        _ -> {m_vars:get_value('mod_kazoo', 'sender_name', Context), Rest}
    end;

m_get([ rs_customer_update_html | Rest ], Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_html.tpl",
    case file:read_file(Filename) of
        {'ok', Data} ->
            {Data, Rest};
        _ ->
            {Html, Context} = z_template:render_to_iolist("rs_customer_update_html.tpl", [], Context),
            {Html, Rest}
    end;

m_get([ rs_customer_update_text | Rest ], Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_text.tpl",
    case file:read_file(Filename) of
        {'ok', Data} ->
            {Data, Rest};
        _ ->
            {Text, Context} = z_template:render_to_iolist("rs_customer_update_text.tpl", [], Context),
            {Text, Rest}
    end;

m_get([ list_system_dialplans_names | Rest ], Context) ->
    {kazoo_util:list_system_dialplans_names(Context), Rest};

m_get([ {cf_notes_get, [{type, Type}]} | Rest ], Context) ->
    {cf_builder:cf_notes_get(Type, Context), Rest};

m_get([ kz_account_access_lists | Rest ], Context) ->
    {kazoo_util:kz_account_access_lists('get', [], Context), Rest};

m_get([ {kz_device_access_lists,[{device_id, DeviceId}]} | Rest ], Context) ->
    {kazoo_util:kz_device_access_lists('get', DeviceId, [], Context), Rest};

m_get([ limits | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {limits,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {limits,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {limits,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {limits,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_limits('get', AccountId, [], Context), Rest};

m_get([ {allotments,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {allotments,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {allotments,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_allotments('get', AccountId, [], Context), Rest};

m_get([ {allotments_consumed,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {allotments_consumed,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {allotments_consumed,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:kz_allotments_consumed('get', AccountId, [], Context), Rest};

m_get([ numbers_countries_list | Rest ], Context) ->
    case m_vars:get_value('mod_kazoo', 'numbers_countries_list', Context) of
        'undefined' -> {[<<"US">>], Rest};
        Countries -> {binary:split(Countries, <<",">>, ['global']), Rest}
    end;

m_get([ all_tasks | Rest ], Context) ->
    {kazoo_util:all_tasks(Context), Rest};

m_get([ account_tasks | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {account_tasks,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {account_tasks,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {account_tasks,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {account_tasks,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:account_tasks('get', AccountId, [], Context), Rest};

m_get([ {metaflows,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {metaflows,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {metaflows,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:metaflows('get', AccountId, [], Context), Rest};

m_get([ {queues,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {queues,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {queues,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:queues('get', AccountId, [], Context), Rest};

m_get([ {queue,[{queue_id, 'undefined'}, {account_id, _AccountId}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {queue,[{queue_id, QueueId}, {account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {queue,[{queue_id, QueueId}, {account_id, AccountId}]} | Rest ], Context);
m_get([ {queue,[{queue_id, QueueId}, {account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:queue('get', QueueId, AccountId, [], Context), Rest};

m_get([ {queue_roster,[{queue_id, 'undefined'}, {account_id, _AccountId}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {queue_roster,[{queue_id, QueueId}, {account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {queue_roster,[{queue_id, QueueId}, {account_id, AccountId}]} | Rest ], Context);
m_get([ {queue_roster,[{queue_id, QueueId}, {account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:queue_roster('get', QueueId, AccountId, [], Context), Rest};

m_get([ acdc_call_stats | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    {kazoo_util:acdc_call_stats(AccountId, Context), Rest};

m_get([ {agents,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {agents,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {agents,[{account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:agents('get', AccountId, [], Context), Rest};

m_get([ {agents_status,[{agent_id, 'undefined'}, {account_id, _AccountId}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {agents_status,[{agent_id, AgentId}, {account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {agents_status,[{agent_id, AgentId}, {account_id, AccountId}]} | Rest ], Context);
m_get([ {agents_status,[{agent_id, AgentId}, {account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:agents_status('get', AgentId, AccountId, [], Context), Rest};

m_get([ {agents_queue_status,[{agent_id, 'undefined'}, {account_id, _AccountId}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {agents_queue_status,[{agent_id, AgentId}, {account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    m_get([ {agents_queue_status,[{agent_id, AgentId}, {account_id, AccountId}]} | Rest ], Context);
m_get([ {agents_queue_status,[{agent_id, AgentId}, {account_id, AccountId}]} | Rest ], Context) ->
    {kazoo_util:agents_queue_status('get', AgentId, AccountId, [], Context), Rest};

m_get([ maybe_masked | Rest ], Context) ->
    {kazoo_util:maybe_masked(Context), Rest};

m_get([ _VR | Rest ], _Context) ->
    ?PRINT(_VR),
    ?PRINT(Rest),
    {undefined, Rest};
m_get(_V, _Context) ->
    ?PRINT(_V),
    {undefined, []}.
