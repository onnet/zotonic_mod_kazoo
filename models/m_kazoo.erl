-module(m_kazoo).
-author("kirill.sysoev@gmail.com").

-behaviour(gen_model).

%% interface functions
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
    m_find_value({kz_doc_field, [{type,Type}, {doc_id, _DocId}, {field, Field}, {account_id, z_context:get_session(kazoo_account_id, Context)}]}, _M, Context);

m_find_value({kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}, {account_id, AccountId}]}, _M, Context) ->
    case Type of
        "account" -> kazoo_util:kz_account_doc_field(Field, AccountId, Context);
        "user" -> kazoo_util:kz_user_doc_field(Field, DocId, Context);
        "device" -> kazoo_util:kz_device_doc_field(Field, DocId, Context);
        "media" -> kazoo_util:kz_media_doc_field(Field, DocId, Context);
        E -> lager:info("kz_doc_field Error: ~p",[E])
    end;

m_find_value({kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}]}, _M, Context) ->
    case Type of
        "account" -> kazoo_util:kz_account_doc_field(Field, Context);
        "user" -> kazoo_util:kz_user_doc_field(Field, DocId, Context);
        "device" -> kazoo_util:kz_device_doc_field(Field, DocId, Context);
        "media" -> kazoo_util:kz_media_doc_field(Field, DocId, Context);
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
    lists:map(fun (UserDoc) -> [z_convert:to_list(modkazoo_util:get_value(<<"id">>,UserDoc))
                               ,<<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary,<<" ">>/binary,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>] end,
              kazoo_util:kz_list_account_users(Context))  ++ [["","-No owner-"]];

m_find_value(kz_list_account_devices, _M, Context) ->
    kazoo_util:kz_list_account_devices(Context);

m_find_value(kz_list_account_devices_short, _M, Context) ->
    lists:map(fun (DeviceDoc) -> [z_convert:to_list(modkazoo_util:get_value(<<"id">>,DeviceDoc)),modkazoo_util:get_value(<<"name">>,DeviceDoc)] end, kazoo_util:kz_list_account_devices(Context))
        ++ [["","-No owner-"]];

m_find_value(kz_list_user_devices, _M, Context) ->
    kazoo_util:kz_list_user_devices(Context);

m_find_value(kz_list_account_vmboxes, _M, Context) ->
    kazoo_util:kz_list_account_vmboxes(Context);

m_find_value(kz_list_user_vmboxes, _M, Context) ->
    kazoo_util:kz_list_user_vmboxes(Context);

m_find_value({kz_list_user_vmbox_details, [{vmbox_id, VMBoxId}]}, _M, Context) ->
    kazoo_util:kz_list_user_vmbox_details(VMBoxId, Context);

m_find_value({kz_vmessage_download_link, [{vmbox_id, VMBoxId}, {media_id, MediaId}]}, _M, Context) ->
    kazoo_util:kz_vmessage_download_link(VMBoxId, MediaId, Context);

m_find_value({kz_recording_download_link, [{cdr_id, CallId}]}, _M, Context) ->
    kazoo_util:kz_recording_download_link(CallId, Context);

m_find_value({kz_incoming_fax_download_link, [{doc_id, DocId}]}, _M, Context) ->
    kazoo_util:kz_incoming_fax_download_link(DocId, Context);

m_find_value({kz_list_account_cdr,[{selected_day, 'undefined'}]}, _M, Context) ->
%    kazoo_util:kz_cdr_list_reduce(kazoo_util:kz_list_account_cdr_page(0, 100, Context), Context);
    kazoo_util:kz_list_account_cdr_reduced(modkazoo_util:today_begins_tstamp(Context), modkazoo_util:today_ends_tstamp(Context), Context);

m_find_value({kz_list_account_cdr,[{selected_day, SelectedDay}]}, _M, Context) ->
    [Day, Month, Year] = string:tokens(SelectedDay,"/"),
    Date = {z_convert:to_integer(Year), z_convert:to_integer(Month), z_convert:to_integer(Day)},
    kazoo_util:kz_list_account_cdr_reduced(modkazoo_util:day_begins_tstamp(Date, Context), modkazoo_util:day_ends_tstamp(Date, Context), Context);

m_find_value({kz_list_account_cdr_page, [{page_size, PageSize}]}, _M, Context) ->
    kazoo_util:kz_list_account_cdr_page(0, PageSize, Context);

m_find_value({kz_fetch_cdr_details, [{cdr_id, CDR_Id}]}, _M, Context) ->
    kazoo_util:kz_fetch_cdr_details(CDR_Id, Context);

m_find_value(kz_list_user_cdr, _M, Context) ->
    kazoo_util:kz_list_user_cdr(modkazoo_util:day_ago_tstamp(Context), modkazoo_util:current_tstamp(Context), Context);

m_find_value(current_account_credit, _M, Context) ->
    modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(Context));

m_find_value({current_account_credit, [{account_id, AccountId}]}, _M, Context) ->
    modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(AccountId, Context));

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
    modkazoo_util:to_proplist(<<"numbers">>, kazoo_util:kz_account_numbers_info(Context));

m_find_value({get_acc_numbers_info, [{account_id,AccountId}]}, _M, Context) ->
    modkazoo_util:to_proplist(<<"numbers">>, kazoo_util:kz_account_numbers_info(AccountId,Context));

m_find_value(kz_list_outgoing_faxes, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_list_outgoing_faxes(Context)));

m_find_value(kz_list_transactions, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_list_transactions(Context)));

m_find_value(bt_client_token, _M, Context) ->
    bt_util:bt_client_token(Context);

m_find_value(kz_bt_customer, _M, Context) ->
    kazoo_util:kz_bt_customer(Context);

m_find_value({ui_element_opened,[{element, ElementName}]}, _M, Context) ->
    kazoo_util:ui_element_state(ElementName, Context);

m_find_value(kz_current_services, _M, Context) ->
    kazoo_util:current_service_plans(Context);

m_find_value(kz_list_subscriptions, _M, Context) ->
    kazoo_util:kz_list_subscriptions(Context);

m_find_value({kz_get_subscription,[{subscription_id, SubscriptionId}]}, _M, Context) ->
    kazoo_util:kz_get_subscription(SubscriptionId, kazoo_util:kz_list_subscriptions(Context));

m_find_value(get_user_timezone, _M, Context) ->
    kazoo_util:get_user_timezone(Context);

m_find_value(tz_list, _M, _Context) ->
    ?TIMEZONES_LIST;

m_find_value(valid_card_exists, _M, Context) ->
    kazoo_util:valid_card_exists(Context);

m_find_value(is_service_plan_applied, _M, Context) ->
    kazoo_util:is_service_plan_applied(Context);

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
    lists:map(fun (MediaDoc) -> [z_convert:to_list(modkazoo_util:get_value(<<"id">>,MediaDoc)),modkazoo_util:get_value(<<"name">>,MediaDoc)] end, kazoo_util:kz_list_account_media(Context));

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
    kazoo_util:cf_get_element_by_id(ElementId, Context);

m_find_value({kz_get_account_prompt, [{prompt_id, PromptId}]}, _M, Context) ->
    kazoo_util:kz_get_account_prompt(PromptId, Context);

m_find_value({cf_get_module_info, [{module_name, ModuleName},{module_path,ModulePath}]}, _M, Context) ->
    kazoo_util:cf_get_module_info(z_convert:to_binary(ModuleName),lists:map(fun (K) -> z_convert:to_binary(K) end, z_string:split(ModulePath,"-")),Context);

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

m_find_value(kz_current_context_reseller, _M, Context) ->
    kazoo_util:kz_current_context_reseller(Context);

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

m_find_value({kz_conference_details, [{conference_id, ConferenceId}]}, _M, Context) ->
    kazoo_util:dedup_kz_conference_details(ConferenceId,Context);

m_find_value(notifications_smtplog, _M, Context) ->
    kazoo_util:notifications_smtplog(Context);

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
            {Html, Context} = z_template:render_to_iolist("rs_customer_udate_html.tpl", [], Context),
            Html
    end;

m_find_value(rs_customer_update_text, _M, Context) ->
    Filename = "/tmp/" ++ z_convert:to_list(z_context:get_session(kazoo_account_id, Context)) ++ "_text.tpl",
    case file:read_file(Filename) of
        {'ok', Data} ->
            Data;
        _ ->
            {Text, Context} = z_template:render_to_iolist("rs_customer_udate_text.tpl", [], Context),
            Text
    end;

m_find_value(_V, _VV, _Context) ->
    lager:info("m_find_value _V: ~p", [_V]),
    lager:info("m_find_value _VV: ~p", [_VV]),
    [_V,_VV,"m_kazoo_find_value_mismatch"].

m_to_list(_V, _Context) ->
    lager:info("m_to_list _V: ~p", [_V]),
    [_V,"m_to_list"].

m_value(#m{value=V}, _Context) -> V.

