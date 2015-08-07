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

m_find_value({kz_doc_field, [{type,Type}, {doc_id, DocId}, {field, Field}]}, _M, Context) ->
    case Type of
        "user" -> kazoo_util:kz_user_doc_field(Field, DocId, Context);
        "device" -> kazoo_util:kz_device_doc_field(Field, DocId, Context);
        E -> lager:info("kz_doc_field Error: ~p",[E])
    end;

m_find_value(kz_list_account_users, _M, Context) ->
    kazoo_util:kz_list_account_users(Context);

m_find_value(kz_list_account_groups, _M, Context) ->
    kazoo_util:kz_list_account_groups(Context);

m_find_value(kz_list_account_channels, _M, Context) ->
    kazoo_util:kz_list_account_channels(Context);

m_find_value({kz_get_account_channel, [{call_id, CallId}]}, _M, Context) ->
    kazoo_util:kz_get_account_channel(CallId, Context);

m_find_value(kz_list_account_callflows, _M, Context) ->
    kazoo_util:kz_list_account_callflows(Context);

m_find_value({kz_get_account_callflow, [{callflow_id,CallflowId}]}, _M, Context) ->
    kazoo_util:kz_get_account_callflow(CallflowId, Context);

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

m_find_value(kz_list_account_cdr, _M, Context) ->
    kazoo_util:kz_list_account_cdr(modkazoo_util:month_ago_tstamp(), modkazoo_util:current_tstamp(), Context);

m_find_value(kz_list_user_cdr, _M, Context) ->
    kazoo_util:kz_list_user_cdr(modkazoo_util:month_ago_tstamp(), modkazoo_util:current_tstamp(), Context);

m_find_value(current_account_credit, _M, Context) ->
    modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(Context));

m_find_value({kz_check_device_registration, [{device_id, DeviceId}]}, _M, Context) ->
    kazoo_util:kz_check_device_registration(DeviceId, Context);

m_find_value({kz_get_device_registration_details, [{device_id, DeviceId}]}, _M, Context) ->
    kazoo_util:kz_get_device_registration_details(DeviceId, Context);

m_find_value(azrates, _M, Context) ->
    kazoo_util:azrates(Context);

m_find_value(kz_list_incoming_faxes, _M, Context) ->
    kazoo_util:kz_list_incoming_faxes(Context);

m_find_value(get_acc_numbers, _M, Context) ->
    lists:sort(z_convert:to_list(kazoo_util:kz_account_numbers(Context)));

m_find_value(get_acc_numbers_info, _M, Context) ->
    modkazoo_util:to_proplist(<<"numbers">>, kazoo_util:kz_account_numbers_info(Context));

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

m_find_value({kz_get_account_conference, [{conference_id, ConferenceId}]}, _M, Context) ->
    kazoo_util:kz_conference('get',ConferenceId, Context);

m_find_value({kz_get_featurecode_by_name, [{featurecode_name, FCName}]}, _M, Context) ->
    kazoo_util:kz_get_featurecode_by_name(FCName, Context);

m_find_value(_V, _VV, _Context) ->
    lager:info("m_find_value _V: ~p", [_V]),
    lager:info("m_find_value _VV: ~p", [_VV]),
    [_V,_VV,"m_kazoo_find_value_mismatch"].

m_to_list(_V, _Context) ->
    lager:info("m_to_list _V: ~p", [_V]),
    [_V,"m_to_list"].

m_value(#m{value=V}, _Context) -> V.

