-module(kazoo_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([kz_admin_creds/1
    ,kz_user_creds/4
    ,crossbar_admin_request/4
    ,crossbar_admin_request/5
    ,kz_get_acc_doc/1
    ,kz_get_acc_doc_by_account_id/2
    ,kz_account_doc_field/2
    ,kz_account_doc_field/3
    ,kz_get_user_doc/1
    ,kz_get_user_doc/2
    ,kz_get_user_doc/3
    ,kz_user_doc_field/2
    ,kz_user_doc_field/3
    ,kz_device_doc_field/3
    ,kz_media_doc_field/3
    ,create_kazoo_account/1
    ,create_kazoo_user/9
    ,kz_create_default_callflow/2
    ,kz_create_default_callflow_sec/3
    ,update_kazoo_user/1
    ,kz_list_account_users/1
    ,kz_list_account_users/2
    ,kz_list_account_devices/1
    ,kz_list_account_cdr/3
    ,kz_list_account_cdr_page/3
    ,kz_list_account_cdr_reduced/3
    ,kz_list_user_cdr/3
    ,kz_fetch_cdr_details/2
    ,kz_cdr_list_reduce/2
    ,kz_list_account_children/1
    ,kz_list_account_channels/1
    ,kz_list_account_channels/2
    ,kz_channel_info/2
    ,kz_channel_info/3
    ,kz_channel_action/3
    ,kz_channel_action/4
    ,kz_channel_hangup/3
    ,kz_channel_transfer/4
    ,kz_channel_eavesdrop/5
    ,kz_list_user_devices/1
    ,kz_get_device_doc/2
    ,kz_set_device_doc/4
    ,kz_list_account_vmboxes/1
    ,kz_list_user_vmboxes/1
    ,kz_list_user_vmbox_details/2
    ,kz_purge_voicemails/3
    ,kz_purge_voicemail/4
    ,kz_vmessage_download_link/3
    ,is_kazoo_account_admin/1
    ,set_vm_message_folder/4
    ,password_recovery/3
    ,current_account_credit/1
    ,current_account_credit/2
    ,kz_check_device_registration/2
    ,kz_recording_download_link/2
    ,kz_get_device_registration_details/2
    ,azrates/1
    ,azrates_refresh/1
    ,rate_number/2
    ,kz_list_incoming_faxes/1
    ,kz_list_incoming_faxes/3
    ,kz_incoming_fax_download_link/2
    ,kz_incoming_fax/2
    ,kz_incoming_fax_attachment_pdf/2
    ,kz_incoming_fax_attachment_tiff/2
    ,kz_incoming_fax_delete/2
    ,kz_account_numbers/1
    ,kz_account_numbers/2
    ,kz_account_numbers_info/1
    ,kz_account_numbers_info/2
    ,kz_send_fax/7
    ,kz_list_outgoing_faxes/1
    ,kz_list_transactions/1
    ,kz_list_subscriptions/1
    ,kz_get_subscription/2
    ,kz_bt_customer/1
    ,bt_delete_card/2
    ,make_payment/3
    ,topup_submit/4
    ,topup_disable/2
    ,kz_set_user_doc/3
    ,kz_set_user_doc/4
    ,kz_toggle_user_doc/2
    ,kz_toggle_user_doc/3
    ,kz_toggle_device_doc/3
    ,kz_set_acc_doc/3
    ,kz_set_acc_doc/4
    ,trigger_innoui_widget/2
    ,ui_element_state/2
    ,set_accounts_address/4
    ,lookup_numbers/2
    ,rs_add_number/3
    ,purchase_number/2
    ,deallocate_number/2
    ,deallocate_number/3
    ,current_service_plans/1
    ,add_service_plan/3
    ,valid_card_exists/1
    ,is_creditable/1
    ,process_purchase_number/2
    ,get_user_timezone/1
    ,may_be_get_timezone/1
    ,is_service_plan_applied/1
    ,get_account_realm/1
    ,get_account_realm/2
    ,delete_account/2
    ,delete_user/2
    ,delete_device/2
    ,kz_list_classifiers/1
    ,add_device/1
    ,add_group/1
    ,kz_list_account_groups/1
    ,kz_list_account_blacklists/1
    ,kz_list_account_callflows/1
    ,kz_list_account_callflows/2
    ,kz_get_account_callflow/2
    ,kz_get_account_callflow/3
    ,delete_group/2
    ,kz_get_group_doc/2
    ,kz_set_group_doc/4
    ,modify_group/1
    ,modify_group/2
    ,cf_add_number/2
    ,cf_add_pattern/2
    ,cf_delete_number/2
    ,cf_edit_name/2
    ,cf_contact_list_exclude/2
    ,cf_set_session/4
    ,cf_save/2
    ,cf_delete/2
    ,kz_list_account_media/1
    ,kz_get_media_doc/2
    ,cf_build_ring_group_endpoints/1
    ,cf_build_page_group_endpoints/1
    ,cf_calculate_ring_group_timeout/1
    ,kz_list_account_menus/1
    ,kz_menu/3
    ,kz_menu/1
    ,cf_child/2
    ,cf_load_to_session/2
    ,cf_may_be_add_child/4
    ,cf_delete_element/2
    ,cf_park_element/2
    ,cf_get_element_by_id/2
    ,cf_handle_drop/2
    ,cf_choose_new_switch/3
    ,cf_set_new_switch/3
    ,kz_list_account_temporal_rules/1
    ,kz_get_temporal_rule/2
    ,cf_time_of_the_day/1
    ,cf_delete_time_of_the_day_rule/2
    ,upload_media/1
    ,kz_delete_prompt/2
    ,kz_get_account_prompt/2
    ,kz_get_account_prompt_attachment/2
    ,cf_get_module_info/3
    ,kz_list_account_conferences/1
    ,kz_list_account_c2calls/1
    ,kz_vmbox/1
    ,kz_vmbox/3
    ,kz_conference/1
    ,kz_conference/3
    ,kz_conference_details/2
    ,dedup_kz_conference_details/2
    ,kz_c2call/1
    ,kz_c2call/3
    ,kz_c2call_hyperlink/2
    ,start_outbound_conference/2
    ,add_conf_participant/2
    ,do_conference_action/4
    ,kz_get_featurecode_by_name/2
    ,toggle_featurecode_voicemail_check/1
    ,toggle_featurecode_voicemail_direct/1
    ,toggle_featurecode_park_and_retrieve/1
    ,toggle_featurecode_park_valet/1
    ,toggle_featurecode_park_retrieve/1
    ,toggle_featurecode_intercom/1
    ,toggle_featurecode_privacy/1
    ,toggle_featurecode_hotdesk_enable/1
    ,toggle_featurecode_hotdesk_disable/1
    ,toggle_featurecode_hotdesk_toggle/1
    ,toggle_featurecode_call_forward_activate/1
    ,toggle_featurecode_call_forward_deactivate/1
    ,toggle_featurecode_call_forward_toggle/1
    ,toggle_featurecode_call_forward_update/1
    ,set_featurecode_dynamic_cid/2
    ,delete_featurecode_dynamic_cid/1
    ,toggle_blacklist_member/2
    ,kz_get_account_blacklist/2
    ,set_blacklist_doc/4
    ,kz_delete_blacklist/2
    ,may_be_check_cid_children_clean/1
    ,rs_delete_account/2
    ,toggle_all_calls_recording/1
    ,kz_cccp_creds_list/1
    ,add_cccp_doc/4
    ,add_cccp_autodial/4
    ,del_cccp_doc/2
    ,kz_find_account_by_number/2
    ,kz_admin_find_accountname_by_number/2
    ,kz_get_registrations_by_accountid/2
    ,list_account_trunks/1
    ,list_trunks_realm/2
    ,kz_registration_details_by_username/2
    ,kz_trunk/4
    ,kz_trunk_server/1
    ,kz_trunk_server_details/3
    ,kz_trunk_server_delete/3
    ,kz_trunk_server_numbers/1
    ,sync_trunkstore_realms/2
    ,ts_trunk_disable/3
    ,ts_trunk_enable/3
    ,kz_list_account_webhooks/1
    ,kz_webhook_info/2
    ,kz_webhook_delete/2
    ,kz_webhook_toggle/2
    ,kz_flush_registration_by_username/2
    ,kz_flush_registration_by_username/3
    ,kz_webhook/1
    ,filter_custom_fields/2
    ,kz_current_context_reseller/1
    ,kz_current_context_reseller_id/1
    ,kz_current_context_superadmin/1
    ,kz_callflows_numbers/1
    ,kz_callflows_numbers/2
    ,kz_spare_numbers/1
    ,kz_spare_numbers/2
    ,kz_callflow_by_number/2
    ,kz_callflow_by_number/3
    ,set_global_carrier_routing/2
    ,set_reseller_based_routing/3
    ,set_account_based_routing/2
    ,kz_list_account_resources/1
    ,kz_resource_info/2
    ,kz_resource_info/3
    ,kz_resource_delete/2
    ,kz_resource_delete/3
    ,toggle_resource/2
    ,toggle_resource/3
    ,resource/1
    ,super_account_id/1
    ,kz_list_account_notifications/1
    ,kz_notification_info/2
    ,kz_notification_info/3
    ,kz_notification_template/3
    ,kz_notification_template/4
    ,kz_save_notification_template/5
    ,kz_delete_notification_template/3
    ,kz_list_account_lists/1
    ,account_list/1
    ,delete_account_list/2
    ,kz_get_account_list/2
    ,kz_list_account_list_entries/2
    ,kz_account_list_add_entry/3
    ,delete_account_list_entry/3
    ,email_sender_name/1
    ,sendmail_test_notification/4
    ,notifications_smtplog/1
    ,kz_notifications/1
    ,kz_notification_toggle/3
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

%% Define API calls
-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(API_AUTH, <<"/api_auth">>).
-define(USER_AUTH, <<"/user_auth">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(PHONE_NUMBERS, <<"/phone_numbers">>).
-define(IDENTIFY, <<"/identify">>).
-define(REGISTRATIONS, <<"/registrations">>).
-define(FAXES, <<"/faxes">>).
-define(FAXES_OUTGOING, <<"/faxes/outgoing/">>).
-define(FAXES_INCOMING, <<"/faxes/incoming/">>).
-define(ATTACHMENT, <<"/attachment">>).
-define(CONNECT, <<"/connect">>).
-define(CONNECTIVITY, <<"/connectivity">>).
-define(CLASSIFIERS, <<"/classifiers">>).
-define(USERS, <<"/users">>).
-define(CCCPS, <<"/cccps">>).
-define(AUTODIAL, <<"/autodial">>).
-define(CALLFLOWS, <<"/callflows">>).
-define(DEVICES, <<"/devices">>).
-define(VMBOXES, <<"/vmboxes">>).
-define(CDRS, <<"/cdrs">>).
-define(MESSAGES, <<"/messages">>).
-define(RAW, <<"/raw">>).
-define(FILTER_OWNER, <<"filter_owner_id=">>).
-define(CREATED_FROM, <<"created_from=">>).
-define(CREATED_TO, <<"created_to=">>).
-define(AUTH_TOKEN, <<"auth_token=">>).
-define(RECOVERY, <<"/recovery">>).
-define(BRAINTREE, <<"/braintree">>).
-define(CREDITS, <<"/credits">>).
-define(STATUS, <<"/status">>).
-define(RATES, <<"/v1/rates">>).
-define(THIRD_PARTY_RECORDING, <<"/third_party_couch/call_recordings">>).
-define(NUMBER, <<"/number">>).
-define(CUSTOMER, <<"/customer">>).
-define(TRANSACTIONS, <<"/transactions">>).
-define(SUBSCRIPTIONS, <<"/subscriptions">>).
-define(CARDS, <<"/cards">>).
-define(PREFIX, <<"prefix=">>).
-define(QUANTITY, <<"quantity=">>).
-define(COLLECTION, <<"/collection">>).
-define(ACTIVATE, <<"/activate">>).
-define(SERVICE_PLANS, <<"/service_plans">>).
-define(CURRENT, <<"/current">>).
-define(GROUPS, <<"/groups">>).
-define(CHANNELS, <<"/channels">>).
-define(MEDIA, <<"/media">>).
-define(MENUS, <<"/menus">>).
-define(TEMPORAL_RULES, <<"/temporal_rules">>).
-define(CONFERENCES, <<"/conferences">>).
-define(DETAILS, <<"/details">>).
-define(BLACKLISTS, <<"/blacklists">>).
-define(LISTS, <<"/lists">>).
-define(ENTRIES, <<"/entries">>).
-define(CHILDREN, <<"/children">>).
-define(PAGE_SIZE, <<"page_size=">>).
-define(START_KEY, <<"start_key=">>).
-define(WEBHOOKS, <<"/webhooks">>).
-define(NO_PAGINATION, <<"&paginate=false">>).
-define(RESOURCES, <<"/resources">>).
-define(NOTIFICATIONS, <<"/notifications">>).
-define(PREVIEW, <<"/preview">>).
-define(SMTPLOG, <<"/smtplog">>).
-define(QUEUES, <<"/queues">>).
-define(EAVESDROP, <<"/eavesdrop">>).
-define(CLICKTOCALL, <<"/clicktocall">>).

-define(MK_TIME_FILTER(CreatedFrom, CreatedTo), <<?CREATED_FROM/binary, CreatedFrom/binary, <<"&">>/binary, ?CREATED_TO/binary, CreatedTo/binary>>).

-define(MENU_KEYS_LIST, [<<"_">>,<<"0">>,<<"1">>,<<"2">>,<<"3">>,<<"4">>,<<"5">>,<<"6">>,<<"7">>,<<"8">>,<<"9">>]).

-define(MK_DEVICE_SIP, 
{[{<<"data">>,
   {[{<<"enabled">>,true},
     {<<"media">>,
      {[{<<"peer_to_peer">>,<<"auto">>},
        {<<"audio">>,{[{<<"codecs">>,[<<"PCMU">>,<<"PCMA">>]}]}},
        {<<"video">>,{[{<<"codecs">>,[]}]}},
        {<<"fax">>,{[{<<"option">>,<<"true">>}]}},
        {<<"fax_option">>,true}]}},
     {<<"sip">>,
      {[{<<"method">>,<<"password">>},
        {<<"invite_format">>,<<"username">>},
        {<<"username">>,modkazoo_util:rand_hex_binary(5)},
        {<<"password">>,modkazoo_util:rand_hex_binary(5)},
        {<<"expire_seconds">>,<<"360">>}]}},
     {<<"contact_list">>,{[{<<"exclude">>,false}]}},
     {<<"call_forward">>,
      {[{<<"enabled">>,false},
        {<<"require_keypress">>,false},
        {<<"keep_caller_id">>,false}]}},
     {<<"music_on_hold">>,{[]}},
     {<<"device_type">>,<<"softphone">>},
     {<<"provision">>,{[]}},
     {<<"name">>,modkazoo_util:rand_hex_binary(3)},
     {<<"ignore_completed_elsewhere">>,false},
     {<<"suppress_unregister_notifications">>,true}]}}]}).

-define(MK_GROUP, 
{[{<<"data">>,
   {[{<<"music_on_hold">>,{[]}}
     ,{<<"resources">>,{[]}}
   ]}
  }
]}).

-define(EMPTY_CALLFLOW, 
{[{<<"flow">>,
   {[{<<"children">>,{[]}}
     ,{<<"data">>,{[]}}
     ]}}
 ,{<<"numbers">>,[]}
 ,{<<"patterns">>,[]}
]}).

-define(EMPTY_TS_SERVER,
{[{<<"DIDs">>,{[]}},
      {<<"options">>,
       {[{<<"enabled">>,true},
         {<<"inbound_format">>,<<"e164">>},
         {<<"international">>,false},
         {<<"caller_id">>,{[]}},
         {<<"e911_info">>,{[]}},
         {<<"failover">>,{[]}},
         {<<"media_handling">>,<<"bypass">>}]}},
      {<<"permissions">>,{[{<<"users">>,[]}]}},
      {<<"monitor">>,{[{<<"monitor_enabled">>,false}]}},
      {<<"server_type">>,<<"FreePBX">>}
]}).

-define(EMPTY_RESOURCE,
{[{<<"weight_cost">>,<<"50">>},
  {<<"enabled">>,false},
  {<<"gateways">>,
   [{[{<<"prefix">>,<<>>},
      {<<"codecs">>,[<<"PCMA">>]},
      {<<"progress_timeout">>,<<"7">>},
      {<<"server">>,<<>>},
      {<<"username">>,<<>>},
      {<<"password">>,<<>>},
      {<<"realm">>,<<>>},
      {<<"format_from_uri">>,false},
      {<<"suffix">>,<<>>},
      {<<"channel_selection">>,<<"ascending">>},
      {<<"custom_sip_headers">>,{[]}},
      {<<"emergency">>,false},
      {<<"enabled">>,true},
      {<<"endpoint_type">>,<<"sip">>},
      {<<"force_port">>,false},
      {<<"invite_format">>,<<"route">>},
      {<<"port">>,5060},
      {<<"skype_rr">>,false}]}]},
  {<<"rules">>,[]},
  {<<"cid_rules">>,[]},
  {<<"caller_id_options">>,{[{<<"type">>,<<"external">>}]}},
  {<<"type">>,<<"local">>},
  {<<"name">>,<<>>},
  {<<"emergency">>,false},
  {<<"grace_period">>,5},
  {<<"flags">>,[<<"fax">>]}
]}).

-define(MK_DATABAG(JObj), {[{<<"data">>, JObj}]}).
-define(DEFAULT_RESOURCE_RULES, [<<"^\\+?(\\d*)$">>]).
-define(DEFAULT_RESOURCE_CIDRULES, []).

-define(NOTIFY_PREVIEW,
{[{<<"to">>, {[{<<"type">>, <<"specified">>}
              ,{<<"email_addresses">>,[]}
             ]}
  },
  {<<"from">>, <<"noreply@nowhere.com">>},
  {<<"subject">>, <<"Testing NOTIFICATION">>},
  {<<"html">>, <<>>},
  {<<"plain">>, <<>>},
  {<<"enabled">>, 'true'}
]}).

-define(CONFERENCE_ACTION(Action, ParticipantId),
{[{<<"action">>, z_convert:to_binary(Action)}
 ,{<<"participant">>, z_convert:to_binary(ParticipantId)}
]}).

kz_admin_creds(Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, ?V1/binary, ?API_AUTH/binary>>),
    API_Key = m_config:get_value('mod_kazoo', 'kazoo_super_duper_api_key', Context),
    DataBag = {[{<<"data">>, {[{<<"api_key">>, API_Key}]}}]},
    Payload = jiffy:encode(DataBag),

    {'ok', _, _, Body} = ibrowse:send_req(URL, req_headers('undefined'), 'put', Payload, [{'inactivity_timeout', 10000}]),

    {JsonData} = jiffy:decode(Body),
    {AccountData} = proplists:get_value(<<"data">>, JsonData),
    Account_Id = proplists:get_value(<<"account_id">>, AccountData),
    Auth_Token = proplists:get_value(<<"auth_token">>, JsonData),
    {'ok', {'account_id', Account_Id}, {'auth_token', Auth_Token}, {'crossbar', Crossbar_URL}}. 

kz_user_creds(Login, Password, Account, Context) ->
    try
        Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
        URL = z_convert:to_list(<<Crossbar_URL/binary, ?V1/binary, ?USER_AUTH/binary>>),
        Creds = io_lib:format("~s:~s", [Login, Password]),
        Md5Hash = iolist_to_binary([io_lib:format("~2.16.0b", [C]) || <<C>> <= erlang:md5(Creds)]),
        DataBag = {[{<<"data">>, {[{<<"credentials">>, Md5Hash}, {<<"account_name">>, Account}]}}]},
        Payload = jiffy:encode(DataBag),
        {'ok', _, _, Body} = ibrowse:send_req(URL, req_headers('undefined'), 'put', Payload, [{'inactivity_timeout', 10000}]),
        {JsonData} = jiffy:decode(Body),
        {AccountData} = proplists:get_value(<<"data">>, JsonData),
        Owner_Id = proplists:get_value(<<"owner_id">>, AccountData),
        Account_Id = proplists:get_value(<<"account_id">>, AccountData),
        Account_Name = proplists:get_value(<<"account_name">>, AccountData),
        Auth_Token = proplists:get_value(<<"auth_token">>, JsonData),
        {'ok', {'owner_id', Owner_Id}, {'account_id', Account_Id}, {'auth_token', Auth_Token}, {'crossbar', Crossbar_URL}, {'account_name', Account_Name}}
    catch
        _:_ -> <<"Auth exception">>
    end.

kz_get_acc_doc(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    kz_get_acc_doc_by_account_id(Account_Id, Context).

kz_get_acc_doc_by_account_id('undefined', _Context) ->
    <<>>;
kz_get_acc_doc_by_account_id(Account_Id, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(Account_Id))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_adminget_acc_doc_by_account_id('undefined', _Context) ->
    <<>>;
kz_adminget_acc_doc_by_account_id(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary>>,
    {'ok', _, _, Body} = crossbar_admin_request('get', API_String, [], Context),
    modkazoo_util:get_value(<<"data">>, jiffy:decode(Body)).

kz_set_acc_doc(K, V, Context) ->
    kz_set_acc_doc(K, V, z_context:get_session('kazoo_account_id', Context), Context).

kz_set_acc_doc(K, V, AccountId, Context) ->
    CurrDoc = kz_get_acc_doc_by_account_id(AccountId, Context),
    NewDoc = modkazoo_util:set_value(K, V, CurrDoc),
    case AccountId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context);
        'true' -> []
    end.

kz_get_user_doc(Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    kz_get_user_doc(OwnerId, Context).

kz_get_user_doc(OwnerId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_get_user_doc(OwnerId, AccountId, Context).

kz_get_user_doc(OwnerId, AccountId, Context) ->
    case AccountId =:= 'undefined' orelse OwnerId =:= 'undefined' orelse OwnerId =:= 'null' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?USERS/binary, <<"/">>/binary, (z_convert:to_binary(OwnerId))/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

kz_set_user_doc(K, V, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    kz_set_user_doc(K, V, OwnerId, Context).

kz_set_user_doc(K, V, OwnerId, Context) ->
    CurrDoc = kz_get_user_doc(OwnerId, Context),
    NewDoc = modkazoo_util:set_value(K, V, CurrDoc),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    case Account_Id =:= 'undefined' orelse OwnerId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?USERS/binary, <<"/">>/binary, OwnerId/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context);
        'true' -> []
    end.

kz_toggle_user_doc(K, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    kz_toggle_user_doc(K, OwnerId, Context).

kz_toggle_user_doc(K, OwnerId, Context) ->
    case kz_user_doc_field(K, OwnerId, Context) of
        'true' -> kz_set_user_doc(K, 'false', OwnerId, Context);
        _ -> kz_set_user_doc(K, 'true', OwnerId, Context)
    end.

kz_toggle_device_doc(K, DeviceId, Context) ->
    case kz_device_doc_field(K, DeviceId, Context) of
        'true' -> kz_set_device_doc(K, 'false', DeviceId, Context);
        _ -> kz_set_device_doc(K, 'true', DeviceId, Context)
    end.

kz_get_device_doc(DeviceId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    case Account_Id =:= 'undefined' orelse DeviceId =:= 'undefoned' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary, <<"/">>/binary, (z_convert:to_binary(DeviceId))/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

kz_set_device_doc(K, V, DeviceId, Context) ->
    CurrDoc = kz_get_device_doc(DeviceId, Context),
    NewDoc = case V of
        'undefined' -> modkazoo_util:delete_key(K, CurrDoc);
         _ -> modkazoo_util:set_value(K, V, CurrDoc)
    end,
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    case Account_Id =:= 'undefined' orelse DeviceId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary, <<"/">>/binary, (z_convert:to_binary(DeviceId))/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context);
        'true' -> []
    end.

crossbar_noauth_request(Verb, API_String, DataBag, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, API_String/binary>>),
    Payload = case DataBag of
                  [] -> [];
                   _ -> jiffy:encode(DataBag)
              end,
    case ibrowse:send_req(URL, req_headers('undefined'), Verb, Payload, [{'inactivity_timeout', 10000}]) of
        {'ok', ReturnCode, _, Body} ->
            case ReturnCode of
                [50,_,_] ->    %  50 = "2"
                    {JsonData} = jiffy:decode(Body),
                    proplists:get_value(<<"data">>, JsonData);
                _ -> <<"">>
            end;
        E -> 
            lager:info("crossbar_noauth_request URL: ~p", [URL]),
            lager:info("crossbar_noauth_request Error: ~p", [E]),
            <<"">>
    end.

req_headers(Token) ->
    req_headers("application/json", Token).

req_headers(ContentType, Token) ->
    modkazoo_util:filter_undefined(
        [{"Content-Type", ContentType}
         ,{"X-Auth-Token", z_convert:to_list(Token)}
         ,{"User-Agent", z_convert:to_list(erlang:node())}
        ]).

crossbar_account_send_request(Verb, API_String, DataBag, Context) ->
    crossbar_account_send_request(Verb, API_String, "application/json", DataBag, Context).

crossbar_account_send_request(Verb, API_String, ContextType, DataBag, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, API_String/binary>>),
    Payload = case DataBag of
                  [] -> [];
                  _ ->
                      case ContextType of
                          "application/json" -> jiffy:encode(DataBag);
                          _ -> DataBag
                      end
              end,
    ibrowse:send_req(URL, req_headers(ContextType, AuthToken), Verb, Payload, [{'inactivity_timeout', 10000}]).

crossbar_account_send_raw_request_body(Verb, API_String, Headers, Data, Context) ->
    case crossbar_account_send_raw_request(Verb, API_String, Headers, Data, Context) of
        {'ok', _ReturnCode, _, Body} -> Body;
        E -> 
            lager:info("crossbar_account_send_raw_request_body Error: ~p", [E]),
            lager:info("crossbar_account_send_raw_request_body Error Verb: ~p", [Verb]),
            lager:info("crossbar_account_send_raw_request_body Error API_String: ~p", [API_String]),
            lager:info("crossbar_account_send_raw_request_body Error Data: ~p", [Data]),
            <<>>
    end.
        
crossbar_account_send_raw_request(Verb, API_String, Headers, Data, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, API_String/binary>>),
    ibrowse:send_req(URL, req_headers(AuthToken)++Headers, Verb, Data, [{'inactivity_timeout', 10000}]).

crossbar_account_request(Verb, API_String, DataBag, Context) ->
    crossbar_account_request(Verb, API_String, DataBag, Context, <<>>).

crossbar_account_request(Verb, API_String, DataBag, Context, Default) ->
    case crossbar_account_send_request(Verb, API_String, DataBag, Context) of
        {'ok', ReturnCode, _, Body} ->
            case ReturnCode of
                [50,_,_] ->
                    {JsonData} = jiffy:decode(Body),
                    proplists:get_value(<<"data">>, JsonData);
                _ -> 
                    case ReturnCode of
                        "401" -> z_notifier:notify({kazoo_notify, "no_auth",'undefined','undefined','undefined'}, Context);
                        _ -> 'ok'
                    end,
                    lager:info("crossbar_account_request API String: ~p:~p", [Verb,API_String]),
                    lager:info("crossbar_account_request RC: ~p:~p", [ReturnCode,Body]),
                    lager:info("crossbar_account_request DataBag: ~p", [DataBag]),
                    lager:info("crossbar_account_request Verb: ~p", [Verb]),
                    Default
            end;
        E -> 
            lager:info("crossbar_account_request Error: ~p", [E]),
            lager:info("crossbar_account_request Error Verb: ~p", [Verb]),
            lager:info("crossbar_account_request Error API_String: ~p", [API_String]),
            lager:info("crossbar_account_request Error DataBag: ~p", [DataBag]),
            Default
    end.

crossbar_account_attachment_request(Verb, API_String, DataBag, Context) ->
    case crossbar_account_send_request(Verb, API_String, DataBag, Context) of
        {'ok', ReturnCode, _, Body} ->
            case ReturnCode of
                [50,_,_] -> Body;
                _ -> <<"">>
            end;
        E -> 
            lager:info("crossbar_account_request Error: ~p", [E]),
            <<"">>
    end.

crossbar_admin_request(Verb, API_String, DataBag, Context) ->
    crossbar_admin_request(Verb, API_String, DataBag, 10000, Context).
crossbar_admin_request(Verb, API_String, DataBag, Timeout, Context) ->
    {'ok', {'account_id', _}, {'auth_token', AuthToken}, {'crossbar', CrossbarURL}} = kz_admin_creds(Context),
    URL = z_convert:to_list(<<CrossbarURL/binary, API_String/binary>>),
    Payload = case DataBag of
                  [] -> [];
                   _ -> jiffy:encode(DataBag)
              end,
    ibrowse:send_req(URL, req_headers(AuthToken), Verb, Payload, [], Timeout).

kz_account_doc_field(Field, Context) ->
    kz_account_doc_field(Field, z_context:get_session(kazoo_account_id, Context), Context).

kz_account_doc_field(Field, 'undefined', Context) ->
    kz_account_doc_field(Field, z_context:get_session(kazoo_account_id, Context), Context);
kz_account_doc_field(Field, AccountId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_acc_doc_by_account_id(AccountId, Context));
kz_account_doc_field(Field, AccountId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([z_convert:to_binary(X) || X <- Field], kz_get_acc_doc_by_account_id(AccountId, Context));
kz_account_doc_field(Field, AccountId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_acc_doc_by_account_id(AccountId, Context));
kz_account_doc_field(Field, AccountId, Context) when is_list(Field) ->
    modkazoo_util:get_value(z_convert:to_binary(Field), kz_get_acc_doc_by_account_id(AccountId, Context)).

kz_user_doc_field(Field, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    kz_user_doc_field(Field, OwnerId, Context).

kz_user_doc_field(Field, OwnerId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_user_doc(OwnerId, Context));
kz_user_doc_field(Field, OwnerId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([z_convert:to_binary(X) || X <- Field], kz_get_user_doc(OwnerId, Context));
kz_user_doc_field(Field, OwnerId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_user_doc(OwnerId, Context));
kz_user_doc_field(Field, OwnerId, Context) when is_list(Field) ->
    modkazoo_util:get_value(z_convert:to_binary(Field), kz_get_user_doc(OwnerId, Context)).

kz_device_doc_field(Field, DeviceId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_device_doc(DeviceId, Context));
kz_device_doc_field(Field, DeviceId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([z_convert:to_binary(X) || X <- Field], kz_get_device_doc(DeviceId, Context));
kz_device_doc_field(Field, DeviceId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_device_doc(DeviceId, Context));
kz_device_doc_field(Field, DeviceId, Context) when is_list(Field) ->
    modkazoo_util:get_value(z_convert:to_binary(Field), kz_get_device_doc(DeviceId, Context)).

kz_media_doc_field(Field, MediaId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_media_doc(MediaId, Context));
kz_media_doc_field(Field, MediaId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([z_convert:to_binary(X) || X <- Field], kz_get_media_doc(MediaId, Context));
kz_media_doc_field(Field, MediaId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_media_doc(MediaId, Context));
kz_media_doc_field(Field, MediaId, Context) when is_list(Field) ->
    modkazoo_util:get_value(z_convert:to_binary(Field), kz_get_media_doc(MediaId, Context)).

create_kazoo_account(Context) ->
    Firstname = z_convert:to_binary(z_context:get_q("firstname", Context)),
    Surname = z_convert:to_binary(z_context:get_q("surname", Context)),
    Username = modkazoo_util:to_lower_binary(z_context:get_q("username", Context)),
    Companyname = z_convert:to_binary(z_context:get_q("companyname", Context)),
    Email = z_convert:to_binary(z_context:get_q("email", Context)),
    Phonenumber = z_convert:to_binary(z_context:get_q("phonenumber", Context)),
    DefaultRealm = m_config:get_value('mod_kazoo', 'kazoo_default_realm', Context),
    Accountname = case valid_account_name(Companyname) of
      'false' -> z_convert:to_binary(modkazoo_util2:translit(z_convert:to_list(<<Firstname/binary, <<" ">>/binary, Surname/binary>>)));
      'true' -> z_convert:to_binary(modkazoo_util2:translit(z_convert:to_list(Companyname)))
    end,
    ResellerId = case z_context:get_session('kazoo_account_id', Context) of
        'undefined' -> 
            {'ok', {'account_id', AdminAccountId}, {'auth_token', _}, {'crossbar', _}} = kz_admin_creds(Context),
            AdminAccountId;
        AccountId -> AccountId
    end,
    DataBag = {[{<<"data">>,
                  {[{<<"call_restriction">>,{[]}}
                    ,{<<"notifications">>,
                     {[{<<"voicemail_to_email">>,{[]}}
                       ,{<<"fax_to_email">>,{[]}}
                       ,{<<"deregister">>,{[]}}]}}
                    ,{<<"contact">>,{[{<<"billing">>,{[{<<"email">>,Email},{<<"number">>,Phonenumber}]}}]}}
                    ,{<<"provision">>,{[]}}
                    ,{<<"apps">>,[]}
                    ,{<<"name">>,Accountname}
                    ,{<<"language">>,case m_config:get_value('mod_kazoo', 'default_kazoo_language', Context) of
                                         'undefined' -> <<"en-en">>;
                                          Lang -> z_convert:to_binary(Lang)
                                      end
                     }
                    ,{<<"timezone">>,case m_config:get_value('mod_kazoo', 'default_kazoo_timezone', Context) of
                                         'undefined' -> <<"Europe/London">>;
                                          Lang -> z_convert:to_binary(Lang)
                                      end
                     }
                    ,{<<"realm">>,<<(modkazoo_util:normalize_account_name(Accountname))/binary, DefaultRealm/binary>>}
                    ,{<<"available_apps">>,[<<"voip">>,<<"pbxs">>]}
                    ,{<<"billing_id">>,ResellerId}
                  ]}
              }]},
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ResellerId/binary>>,
    case z_context:get_session(kazoo_auth_token, Context) of
        'undefined' -> {'ok', _, _, Body} = crossbar_admin_request('put', API_String, DataBag, Context);
        _ -> {'ok', _, _, Body} = crossbar_account_send_raw_request('put', API_String, [], jiffy:encode(DataBag), Context)
    end,
    CreatedUserAccountId = modkazoo_util:get_value([<<"data">>,<<"id">>], jiffy:decode(Body)),
    UserPassword = modkazoo_util:rand_hex_binary(10),
    create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, CreatedUserAccountId, Context),
    send_signup_email(Accountname, Username, Firstname, Surname, Email, UserPassword, Context),
    {'new_account_id', CreatedUserAccountId}.
 
valid_account_name(Name) when size(Name) < 3 -> 'false';
valid_account_name(_) -> 'true'.

kz_account_create_callflow(Routines, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, ?EMPTY_CALLFLOW, Routines)),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary>>,
    crossbar_account_request('put', API_String, DataBag, Context).

kz_create_default_callflow_sec(Seconds,AccountId, Context) ->
    timer:sleep(Seconds),
    kz_create_default_callflow(AccountId, Context).

kz_admin_create_callflow(AccountId, Routines, Context) ->
    DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, ?EMPTY_CALLFLOW, Routines)),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary>>,
    crossbar_admin_request('put', API_String, DataBag, Context).

kz_create_default_callflow(AccountId, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"no_match">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"module">>], <<"offnet">>, J) end],
    kz_admin_create_callflow(AccountId, Routines, Context).

update_kazoo_user(Context) ->
    CallForwardEnabled = modkazoo_util:on_to_true(z_context:get_q("call_forward_enabled", Context)),
    ForwardTo = z_convert:to_binary(z_context:get_q("ring-number-txt", Context)),
    RingVoip = not modkazoo_util:on_to_true(z_context:get_q("ring-device-checkbox", Context)),
    KeepCallerID = modkazoo_util:on_to_true(z_context:get_q("call_forward_keep_caller_id", Context)),
    VmToEmail = modkazoo_util:on_to_true(z_context:get_q("vm-to-email-checkbox", Context)),
    ToEmail = z_convert:to_binary(z_context:get_q("vm-to-email-txt", Context)),
    Timezone = z_convert:to_binary(z_context:get_q("user_timezone", Context)),
    z_context:set_session('user_timezone', Timezone, Context),
    CurrentDoc = kz_get_user_doc(Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"enabled">>], CallForwardEnabled, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"number">>], ForwardTo, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"substitute">>], RingVoip, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"keep_caller_id">>], KeepCallerID, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"vm_to_email_enabled">>], VmToEmail, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"email">>], ToEmail, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"timezone">>], Timezone, J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrentDoc, Routines),
    Owner_Id = z_context:get_session('kazoo_owner_id', Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?USERS/binary, <<"/">>/binary, Owner_Id/binary>>,
    crossbar_account_request('post', API_String, {[{<<"data">>, NewDoc}]}, Context),
    Context.

create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, AccountId, Context) ->
    create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, <<"admin">>, AccountId, Context).

create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, PrivLevel, AccountId, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    z_convert:to_binary(Surname),
    DataBag = {[{<<"data">>,
                  {[{<<"apps">>,
                     {[{<<"voip">>,
                        {[{<<"label">>,<<"VoIP Services">>},
                          {<<"icon">>,<<"device">>},
                          {<<"api_url">>,<<Crossbar_URL/binary, "/v1">>}]}}]}},
                    {<<"call_forward">>,
                     {[{<<"substitute">>,false},
                       {<<"enabled">>,false},
                       {<<"require_keypress">>,false},
                       {<<"keep_caller_id">>,false},
                       {<<"direct_calls_only">>,false}]}},
                    {<<"username">>, Username},
                    {<<"first_name">>, Firstname},
                    {<<"last_name">>, Surname},
                    {<<"email">>, Email},
                    {<<"contact_phonenumber">>, Phonenumber},
                    {<<"password">>, UserPassword},
                    {<<"priv_level">>,PrivLevel},
                    {<<"vm_to_email_enabled">>,true},
                    {<<"fax_to_email_enabled">>,true},
                    {<<"verified">>,false},
                    {<<"timezone">>,<<"Europe/London">>},
                    {<<"record_call">>,false}
                   ]}
               }]},
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?USERS/binary>>,
    crossbar_admin_request('put', API_String, DataBag, Context).

email_sender_name(Context) ->
    case z_context:get_session('kazoo_account_id', Context) of
        'undefined' -> m_config:get_value('mod_kazoo', 'sender_name', Context);
        ResellerId ->
            case kz_account_doc_field(<<"sender_name">>, ResellerId, Context) of
                'undefined' -> m_config:get_value('mod_kazoo', 'sender_name', Context);
                SenderName -> lager:info("SenderName: ~p", [SenderName]), SenderName
            end
    end.

send_signup_email(Accountname, Username, Firstname, Surname, Email, Password, Context) ->
    {ClientIP, _}  = webmachine_request:peer(z_context:get_reqdata(Context)),
    SalesEmail = m_config:get_value('mod_kazoo', sales_email, Context),
    SenderName = email_sender_name(Context),
    case z_context:get_q("signup_file", Context) of
        {upload, SignUploadFilename, SignUploadTmp, _, _} ->
            false = modkazoo_util2:check_file_size_exceeded(signup_file, SignUploadTmp, 15000000),
            SignUploadFilenameVar = [{signup_file, SignUploadFilename}],
            {ok, FileData} = file:read_file(SignUploadTmp),
            {ok, FileIdnProps} = z_media_identify:identify(SignUploadTmp, Context),
            SignUpload = [#upload{tmpfile=SignUploadTmp, data=FileData, filename=modkazoo_util2:translit(SignUploadFilename), mime=proplists:get_value(mime, FileIdnProps)}];
        _ ->
            SignUpload = [],
            SignUploadFilenameVar = []
    end,


    Vars = [{email, Email}
            ,{sender_name, SenderName}
            ,{accountname, Accountname}
            ,{username, Username}
            ,{firstname, Firstname}
            ,{surname, Surname}
            ,{password, Password}
            ,{clientip, ClientIP}
            ,{comments, z_convert:to_binary(z_context:get_q("comments", Context))}
            ,{phonenumber, z_convert:to_binary(z_context:get_q("phonenumber", Context))}
           ] ++ SignUploadFilenameVar,

    Attachments = SignUpload,

    case z_context:get_q("notify_signed_up",Context) of
        'undefined' -> 
            E_SignUp = #email{
                to=kz_user_doc_field(<<"email">>, Context),
                from=SalesEmail,
                html_tpl="_email_signup_greeting.tpl",
                vars=Vars,
                attachments=Attachments
            },
            z_email:send(E_SignUp, Context);
        _ -> 
            E_SignUp = #email{
                to=Email,
                from=SalesEmail,
                html_tpl="_email_signup_greeting.tpl",
                vars=Vars,
                attachments=Attachments
            },
            z_email:send(E_SignUp, Context)
    end,

    E_SignUp_Copy = #email{
        to=SalesEmail,
        from=SalesEmail,
        html_tpl="_email_signup_greeting.tpl",
        vars=Vars,
        attachments=Attachments
    },
    z_email:send(E_SignUp_Copy, Context).

kz_list_account_users(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_account_users(AccountId, Context).

kz_list_account_users(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?USERS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_devices(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_devices(Context) ->
    Owner_Id = z_context:get_session('kazoo_owner_id', Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary, <<"?">>/binary, ?FILTER_OWNER/binary, Owner_Id/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_vmboxes(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_vmboxes(Context) ->
    Owner_Id = z_context:get_session('kazoo_owner_id', Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary, <<"?">>/binary, ?FILTER_OWNER/binary, Owner_Id/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_vmbox_details(VMBoxId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary, <<"/">>/binary, (z_convert:to_binary(VMBoxId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_purge_voicemails(VMBoxId, DaysTo, Context) ->
    Candidates = modkazoo_util:get_value(<<"messages">>, kz_list_user_vmbox_details(VMBoxId, Context)),
    FilterTS = calendar:datetime_to_gregorian_seconds(calendar:universal_time()) - (z_convert:to_integer(DaysTo) * 86400),
    MediaIds = [modkazoo_util:get_value(<<"media_id">>, X) || X <- Candidates,
                (FilterTS > (z_convert:to_integer(modkazoo_util:get_value(<<"timestamp">>, X)))) andalso (modkazoo_util:get_value(<<"folder">>, X) =/= <<"deleted">>)],
    lists:foldl(fun(MediaId, Delay) -> spawn(?MODULE, kz_purge_voicemail, [VMBoxId, MediaId, Delay, Context]), Delay + 1 end, 0, MediaIds),
    length(MediaIds) + 2.

kz_purge_voicemail(VMBoxId, MediaId, Delay, Context) ->
    timer:sleep(Delay * ?MILLISECONDS_IN_SECOND),
    set_vm_message_folder(<<"deleted">>, VMBoxId, MediaId, Context).

kz_list_account_cdr(CreatedFrom, CreatedTo, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CDRS/binary, <<"?">>/binary, 
                   ?MK_TIME_FILTER((z_convert:to_binary(CreatedFrom)), (z_convert:to_binary(CreatedTo)))/binary, ?NO_PAGINATION/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_cdr_page(_StartKey, PageSize, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?CDRS/binary, <<"?">>/binary,
                   ?PAGE_SIZE/binary, (z_convert:to_binary(PageSize))/binary>>,
 %                  ?START_KEY/binary, (z_convert:to_binary(StartKey))/binary, <<"&">>/binary, ?PAGE_SIZE/binary, (z_convert:to_binary(PageSize))/binary>>,
 %  Docs to implement pagination: https://github.com/2600hz/kazoo/blob/master/applications/crossbar/doc/basics.md#pagination                 
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_cdr(CreatedFrom, CreatedTo, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?USERS/binary, <<"/">>/binary, OwnerId/binary, ?CDRS/binary, <<"?">>/binary, 
                   ?MK_TIME_FILTER((z_convert:to_binary(CreatedFrom)), (z_convert:to_binary(CreatedTo)))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_fetch_cdr_details(CdrId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?CDRS/binary, <<"/">>/binary, (z_convert:to_binary(CdrId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_vmessage_download_link(VMBoxId, MediaId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary, <<"/">>/binary, (z_convert:to_binary(VMBoxId))/binary,
                   ?MESSAGES/binary, <<"/">>/binary, (z_convert:to_binary(MediaId))/binary, ?RAW/binary, <<"?">>/binary,
                   ?AUTH_TOKEN/binary, (z_context:get_session(kazoo_auth_token, Context))/binary>>,
    <<(m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context))/binary, API_String/binary>>. 
    
kz_recording_download_link(CallId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?THIRD_PARTY_RECORDING/binary, <<"/">>/binary, (z_convert:to_binary(CallId))/binary,
                   ?ATTACHMENT/binary, <<"?">>/binary, ?AUTH_TOKEN/binary, (z_context:get_session(kazoo_auth_token, Context))/binary>>,
    <<(m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context))/binary, API_String/binary>>. 

kz_cdr_list_reduce(CdrList, Context) when is_list(CdrList) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    [ kz_cdr_element_reduce(Element, Timezone, Context) || Element <- CdrList ];
kz_cdr_list_reduce(_,_) ->
    [].

kz_cdr_element_reduce({CdrElement}, Timezone, Context) ->
    FilterFun = fun ({<<"timestamp">>,_}) -> true;
                    ({<<"calling_from">>,_}) -> true;
                    ({<<"dialed_number">>,_}) -> true;
                    ({<<"duration_seconds">>,_}) -> true;
                    ({<<"billing_seconds">>,_}) -> true;
                    ({<<"recording_url">>,_}) -> true;
                    ({<<"id">>,_}) -> true;
                    ({<<"call_id">>,_}) -> true;
                    (_) -> false end,
    T = z_convert:to_integer(proplists:get_value(<<"unix_timestamp">>,CdrElement)),
    ?JSON_WRAPPER(lists:filter(FilterFun, CdrElement)
      ++[{<<"kz_recording_download_link">>, kz_recording_download_link(proplists:get_value(<<"id">>,CdrElement), Context)}]
      ++[{<<"filtered_call_date">>, localtime:local_to_local(calendar:now_to_universal_time({T div 1000000, T rem 1000000, 0}), "UTC", Timezone)}]).

kz_list_account_cdr_reduced(CreatedFrom, CreatedTo, Context) ->
    kz_cdr_list_reduce(kz_list_account_cdr(CreatedFrom, CreatedTo, Context), Context).
    
kz_incoming_fax_download_link(DocId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?FAXES_INCOMING/binary, (z_convert:to_binary(DocId))/binary,
                   ?ATTACHMENT/binary, <<"?">>/binary, ?AUTH_TOKEN/binary, (z_context:get_session(kazoo_auth_token, Context))/binary>>,
    <<(m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context))/binary, API_String/binary>>. 

is_kazoo_account_admin(Context) ->
    case z_context:get_session('kazoo_account_admin', Context) of
        'true' -> 'true';
        _ -> 'false'
    end.

set_vm_message_folder(Folder, VMBoxId, MediaId, Context) ->
    CurrVMBox = kz_list_user_vmbox_details(VMBoxId, Context),
    Messages = [update_folder1(Message, Folder, MediaId, modkazoo_util:get_value(<<"media_id">>, Message))
                || Message <- modkazoo_util:get_value(<<"messages">>, CurrVMBox, [])],
    NewVMBox = modkazoo_util:set_value(<<"messages">>, Messages, CurrVMBox),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary, <<"/">>/binary, (z_convert:to_binary(VMBoxId))/binary>>,
    crossbar_account_request('post', API_String, {[{<<"data">>, NewVMBox}]}, Context).

update_folder1(Message, Folder, MediaId, MediaId) ->
    modkazoo_util:set_value(<<"folder">>, z_convert:to_binary(Folder), Message);
update_folder1(Message, _, _, _) ->
    Message.

password_recovery(Username, AccountName, Context) ->
    API_String = <<?V1/binary, ?USER_AUTH/binary, ?RECOVERY/binary>>,
    DataBag = {[{<<"data">>,
                  {[{<<"username">>, z_convert:to_binary(Username)}
                    ,{<<"account_name">>, z_convert:to_binary(AccountName)}
                  ]}
              }]},
    crossbar_noauth_request('put', API_String, DataBag, Context). 

current_account_credit(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    current_account_credit(AccountId, Context).

current_account_credit(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?BRAINTREE/binary, ?CREDITS/binary>>, 
    crossbar_account_request('get', API_String, [], Context).

kz_check_device_registration(DeviceId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary, ?STATUS/binary>>, 
    DevicesStatus = crossbar_account_request('get', API_String, [], Context),
    lists:member({[{<<"device_id">>,z_convert:to_binary(DeviceId)},{<<"registered">>,true}]}, DevicesStatus).

kz_get_registrations_by_accountid(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?REGISTRATIONS/binary>>, 
    crossbar_account_request('get', API_String, [], Context).

kz_get_device_registration_details(DeviceId, Context) ->
    Username = modkazoo_util:get_value([<<"sip">>, <<"username">>], kz_get_device_doc(DeviceId, Context)),
    kz_registration_details_by_username(Username, Context).

kz_registration_details_by_username(Username, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    Registrations = kz_get_registrations_by_accountid(AccountId, Context),
    get_reg_details(Username, Registrations).

get_reg_details(_, []) -> <<"">>;
get_reg_details(Username, [Registration|T]) -> 
    case modkazoo_util:get_value(<<"username">>, Registration) of
        Username -> Registration;
        _ -> get_reg_details(Username, T)
    end.

kz_flush_registration_by_username(Username, Context) ->
    kz_flush_registration_by_username(Username, z_context:get_session('kazoo_account_id', Context), Context).

kz_flush_registration_by_username(Username, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?REGISTRATIONS/binary, <<"/">>/binary, (z_convert:to_binary(Username))/binary>>, 
    crossbar_account_request('delete', API_String, [], Context).

azrates(Context) ->
    {{Year,Month,Day},{Hour,_,_}} = erlang:localtime(),
    RatesFile = m_config:get_value('mod_kazoo', 'rates_file', Context),
    case filelib:last_modified(RatesFile) of
        {{Year,Month,Day},{Hour,_,_}} -> 'ok';
        _ -> spawn('kazoo_util', 'azrates_refresh', [Context])
    end,
    {ok, Rates} = file:read_file(RatesFile),
    jiffy:decode(Rates).

azrates_refresh(Context) ->
    API_String = <<?RATES/binary>>, 
    {'ok', _, _, Body} = crossbar_admin_request('get', API_String, [], 120000, Context),
    {JsonData} = jiffy:decode(Body),
    RateList = lists:reverse(proplists:get_value(<<"data">>, JsonData)),
    TabId = ets:new(rates, [bag]),
    ets:insert(TabId, lists:map(fun ({[{<<"name">>,_Name},{<<"cost">>,Cost},{<<"prefix">>,Prefix},{<<"description">>,Description},{<<"surcharge">>,Surcharge}]}) -> 
                                                                                                                          {Prefix,Description,Cost,Surcharge} end, RateList)),
    DescriptionPriceTuples = lists:usort(ets:match(TabId,{'_','$1','$2','$3'})),
    CombinedRL = lists:map(fun ([Description, Cost, Surcharge]) -> {[{<<"prefix">>, ets:match(TabId, {'$1',Description,Cost,Surcharge})}
                                                          ,{<<"cost">>, Cost}, {<<"description">>, Description},{<<"surcharge">>,Surcharge}]} end, DescriptionPriceTuples),
    file:write_file(m_config:get_value('mod_kazoo', 'rates_file', Context), jiffy:encode(CombinedRL)).

rate_number(Number, Context) ->
    API_String = <<?RATES/binary, ?NUMBER/binary, <<"/">>/binary, (z_convert:to_binary(Number))/binary>>, 
    case crossbar_admin_request('get', API_String, [], Context) of
        {'ok',"200", _, Body} -> 
            crossbar_admin_request('get', API_String, [], Context),
            {JsonData} = jiffy:decode(Body),
            {'ok', proplists:get_value(<<"data">>, JsonData)};
        E -> E
    end.

kz_list_incoming_faxes(Context) ->
    UserId = z_context:get_session('kazoo_owner_id', Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_incoming_faxes(UserId, AccountId, Context).

kz_list_incoming_faxes(UserId, AccountId, Context) ->
    API_String =  case UserId of
                      'undefined' -> <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?FAXES_INCOMING/binary>>;
                      _ -> <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?FAXES_INCOMING/binary, <<"?">>/binary, ?FILTER_OWNER/binary, UserId/binary>>
                  end,
    Fun = fun({I}, {J}) ->
                   II = proplists:get_value(<<"timestamp">>, I),
                   JJ = proplists:get_value(<<"timestamp">>, J),
                   II =< JJ
    end,
    lists:reverse(lists:sort(Fun, z_convert:to_list(crossbar_account_request('get', API_String, [], Context)))).

kz_incoming_fax(DocId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?FAXES_INCOMING/binary, (z_convert:to_binary(DocId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_incoming_fax_delete(DocId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?FAXES_INCOMING/binary, (z_convert:to_binary(DocId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_incoming_fax_attachment_pdf(DocId, Context) ->
    TiffFile = list_to_binary(["/tmp/", DocId, ".tiff"]),
    PDFFile = list_to_binary(["/tmp/", DocId, ".pdf"]),
    case file:read_file(PDFFile) of
        {'ok', PDFBin} -> PDFBin;
        _ ->
            case kz_incoming_fax_attachment_tiff(DocId, Context) of
                <<>> -> <<>>;
                Body ->
                    _ = file:write_file(TiffFile, Body),
                    Cmd = io_lib:format("tiff2pdf -o ~s ~s &> /dev/null && echo -n \"success\"", [PDFFile, TiffFile]),
                    _ = os:cmd(Cmd),
                    _ = file:delete(TiffFile),
                    case file:read_file(PDFFile) of
                        {'ok', PDFBin} -> PDFBin;
                        _ -> <<>>
                    end
            end
    end.

kz_incoming_fax_attachment_tiff(DocId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?FAXES_INCOMING/binary, (z_convert:to_binary(DocId))/binary, ?ATTACHMENT/binary>>,
    crossbar_account_attachment_request('get', API_String, [], Context).

kz_account_numbers_info(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_account_numbers_info(AccountId, Context).

kz_account_numbers_info(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?PHONE_NUMBERS/binary>>,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> [<<"">>];
        Result -> Result
    end.

kz_account_numbers(Context) ->
    modkazoo_util:get_keys(<<"numbers">>,kz_account_numbers_info(Context)).

kz_account_numbers(AccountId, Context) ->
    modkazoo_util:get_keys(<<"numbers">>,kz_account_numbers_info(AccountId, Context)).

kz_send_fax(Account_Id, FaxTo, FaxFrom, Url, Attempts, FaxHeader, Context) ->
    DataBag = {[{<<"data">>,
                           {[{<<"document">>,
                                 {[{<<"url">>, Url},
                                   {<<"method">>, <<"get">>}]
                                 }
                             },
                             {<<"retries">>, Attempts},
                             {<<"from_name">>, list_to_binary(z_convert:to_list(FaxHeader))},
                             {<<"from_number">>, FaxFrom},
                             {<<"to_name">>, FaxTo},
                             {<<"to_number">>, FaxTo}
                            ]
                    }
                }]
              },
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?FAXES/binary>>,
    RequestAnswer = crossbar_account_request('put', API_String, DataBag, Context),
    RequestAnswer.

kz_list_outgoing_faxes(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_context:get_session('kazoo_account_id', Context))/binary, ?FAXES_OUTGOING/binary>>,
    [{[{<<"a">>, TimeStamp}, A, B, C, D]} || {[A, B, C, D, {<<"created">>,TimeStamp}=_E]} <- crossbar_account_request('get', API_String, [], Context)].

kz_list_transactions(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_context:get_session('kazoo_account_id', Context))/binary, ?BRAINTREE/binary, ?TRANSACTIONS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_subscriptions(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_context:get_session('kazoo_account_id', Context))/binary, ?TRANSACTIONS/binary, ?SUBSCRIPTIONS/binary>>,
    lager:info("kz_list_subscriptions: ~p", [crossbar_account_request('get', API_String, [], Context)]),
    crossbar_account_request('get', API_String, [], Context).

kz_get_subscription(SubscriptionId, [H|T]) ->
    case modkazoo_util:get_value(<<"id">>, H) of
        SubscriptionId -> H;
        _ -> kz_get_subscription(SubscriptionId, T)
    end;
kz_get_subscription(_, _) -> <<>>.

kz_bt_customer(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_context:get_session('kazoo_account_id', Context))/binary, ?BRAINTREE/binary, ?CUSTOMER/binary>>,
    crossbar_account_request('get', API_String, [], Context).

bt_delete_card(CardId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_context:get_session('kazoo_account_id', Context))/binary, ?BRAINTREE/binary, ?CARDS/binary, <<"/">>/binary, CardId/binary>>,
    crossbar_account_request('delete', API_String, [], Context).
    
make_payment(Amount, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?BRAINTREE/binary, ?CREDITS/binary>>, 
    DataBag = {[{<<"data">>,{[{<<"amount">>, z_convert:to_binary(Amount)}]}}]},
    lager:info("Make payment attempt. AccountId: ~p. Amount: ~p.",[AccountId, Amount]),
    crossbar_account_request('put', API_String, DataBag, Context).

topup_submit(Threshold, Amount, AccountId, Context) ->
    CurrDoc = kz_get_acc_doc_by_account_id(AccountId, Context),
    TopUp = {[{<<"threshold">>,z_convert:to_integer(Threshold)},{<<"amount">>,z_convert:to_integer(Amount)}]},
    NewDoc = modkazoo_util:set_value(<<"topup">>, TopUp, CurrDoc),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary>>,
    crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context),
    Context.

topup_disable(AccountId, Context) ->
    CurrDoc = kz_get_acc_doc_by_account_id(AccountId, Context),
    NewDoc = modkazoo_util:delete_key(<<"topup">>, CurrDoc),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary>>,
    crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context),
    Context.
   
ui_element_state(ElementName,Context) ->
    case z_context:get_session(z_convert:to_atom(ElementName), Context) of
        'true' -> 'true';
        'false' -> 'false';
        'undefined' ->
            case z_convert:to_atom(kz_user_doc_field([<<"inno_ui">>,z_convert:to_binary(ElementName)], Context)) of
                'true' -> 
                    z_context:set_session(z_convert:to_atom(ElementName), 'true', Context),
                    'true';
                'false' ->
                    z_context:set_session(z_convert:to_atom(ElementName), 'false', Context),
                    'false';
                _ ->
                    case m_config:get_value('mod_kazoo', z_convert:to_atom(ElementName), Context) of
                        <<"true">> ->
                            z_context:set_session(z_convert:to_atom(ElementName), 'true', Context),
                            'true';
                        _ ->
                            z_context:set_session(z_convert:to_atom(ElementName), 'false', Context),
                            'false'
                    end
            end
    end.

trigger_innoui_widget(ElementName, Context) ->
    case z_context:get_session(z_convert:to_atom(ElementName), Context) of 
        'true' -> 
            z_context:set_session(z_convert:to_atom(ElementName), 'false', Context),
            kz_set_user_doc([<<"inno_ui">>,z_convert:to_binary(ElementName)], 'false', Context);
        _ -> 
            z_context:set_session(z_convert:to_atom(ElementName), 'true', Context),
            kz_set_user_doc([<<"inno_ui">>,z_convert:to_binary(ElementName)], 'true', Context)
    end. 

set_accounts_address(Line1, Line2, Line3, Context) ->
    kz_set_acc_doc([<<"account_address">>,<<"line1">>], Line1, Context),
    kz_set_acc_doc([<<"account_address">>,<<"line2">>], Line2, Context),
    kz_set_acc_doc([<<"account_address">>,<<"line3">>], Line3, Context).
    
lookup_numbers(AreaCode, Context) ->
    API_String = <<?V2/binary, ?PHONE_NUMBERS/binary, <<"?">>/binary, ?PREFIX/binary, AreaCode/binary, <<"&">>/binary, ?QUANTITY/binary, <<"100">>/binary>>,
    crossbar_account_request('get', API_String, [], Context).

rs_add_number(Num, AccountId, Context) ->
    Number = case z_convert:to_binary(Num) of 
        <<$+, BNum/binary>> -> BNum;
        BNum -> BNum
    end,
    _ = crossbar_account_request('put', <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?PHONE_NUMBERS/binary, <<"/">>/binary, Number/binary>>,[],Context),
    _ = crossbar_account_request('put', <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?PHONE_NUMBERS/binary, <<"/">>/binary, Number/binary, ?ACTIVATE/binary>>,[],Context).

purchase_number(Number, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?PHONE_NUMBERS/binary, ?COLLECTION/binary, ?ACTIVATE/binary>>,
    DataBag = {[{<<"data">>, {[{<<"numbers">>, [Number]}]}},{<<"accept_charges">>, true}]},
    crossbar_account_request('put', API_String, DataBag, Context).

process_purchase_number(Number, Context) ->
    case kazoo_util:purchase_number(Number, Context) of
        <<>> ->
            Context1 = z_render:update("onnet_allocated_numbers_tpl" ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], Context),Context),
            Context2 = z_render:update("onnet_widget_monthly_fees_tpl" ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current month services"}], Context1),Context1),
            z_render:growl_error(?__("Something wrong happened.", Context2), Context2);
        _ ->
            may_be_add_service_plan(m_config:get_value('mod_kazoo', 'signup_service_plan', Context), z_context:get_session('kazoo_account_id', Context), Context),
            Context1 = z_render:update("onnet_allocated_numbers_tpl" ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], Context),Context),
            Context2 = z_render:update("onnet_widget_monthly_fees_tpl" ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current month services"}], Context1),Context1),
            Context3 = z_render:update("onnet_widget_order_additional_number_tpl" ,z_template:render("onnet_widget_order_additional_number.tpl", [], Context2),Context2),
            z_render:growl(?__("Number ", Context3)++z_convert:to_list(Number)++?__(" successfully allocated.", Context3), Context3)
    end.

deallocate_number(<<"+", Number/binary>>, Context) ->
    deallocate_number(<<"%2B", Number/binary>>, Context);
deallocate_number(Number, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    deallocate_number(Number, AccountId, Context).

deallocate_number(<<"+", Number/binary>>, AccountId, Context) ->
    deallocate_number(<<"%2B", Number/binary>>, AccountId, Context);
deallocate_number(Number, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?PHONE_NUMBERS/binary, <<"/">>/binary, (z_convert:to_binary(Number))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

current_service_plans(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?SERVICE_PLANS/binary, ?CURRENT/binary>>,
    crossbar_account_request('get', API_String, [], Context).

add_service_plan(PlanId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?SERVICE_PLANS/binary, <<"/">>/binary, (z_convert:to_binary(PlanId))/binary>>,
    DataBag = {[{<<"data">>, {[{<<"id">>, z_convert:to_binary(PlanId)}]}}]},
    crossbar_admin_request('post', API_String, DataBag, Context).

is_service_plan_applied(Context) ->
    case modkazoo_util:get_value(<<"plans">>, current_service_plans(Context)) of
        'undefined' -> 'false';
        {[]} -> 'false';
        _ -> 'true'
    end.

may_be_add_service_plan(PlanId, AccountId, Context) ->
    case is_service_plan_applied(Context) of
        'false' -> add_service_plan(PlanId, AccountId, Context);
        'true' -> 'ok'
    end.

valid_card_exists(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?BRAINTREE/binary, ?CARDS/binary>>,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> 'false';
        Cards -> lists:member('false',[modkazoo_util:get_value(<<"expired">>,Card) || Card <- Cards])
    end.

is_creditable(Context) ->
    valid_card_exists(Context).

kz_get_user_timezone(Context) ->
    case kz_user_doc_field(<<"timezone">>, Context) of
        'undefined' -> kz_account_doc_field(<<"timezone">>, Context);
        Timezone -> Timezone
    end.

get_user_timezone(Context) ->
    case z_context:get_session('user_timezone', Context) of
        'undefined' ->
            Timezone = kz_get_user_timezone(Context),
            z_context:set_session('user_timezone', Timezone, Context),
            Timezone;
        Timezone -> Timezone
    end.

may_be_get_timezone(Context) ->
    case kz_get_user_timezone(Context) of
        'undefined' -> <<"UTC">>;
        Timezone -> Timezone
    end.

get_account_realm(Context) ->
    case z_context:get_session('account_realm', Context) of
        'undefined' ->
            Realm = kz_account_doc_field(<<"realm">>, Context),
            z_context:set_session('account_realm', Realm, Context),
            Realm;
        Realm -> Realm
    end.

get_account_realm(AccountId, Context) ->
    kz_account_doc_field(<<"realm">>, AccountId, Context).

delete_account(AccountId,Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

delete_user(UserId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse UserId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?USERS/binary, <<"/">>/binary, UserId/binary>>,
            crossbar_account_request('delete', API_String, [], Context);
        'true' -> []
    end.

delete_device(DeviceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse DeviceId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?DEVICES/binary, <<"/">>/binary, DeviceId/binary>>,
            crossbar_account_request('delete', API_String, [], Context);
        'true' -> []
    end.

kz_list_classifiers(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?PHONE_NUMBERS/binary, ?CLASSIFIERS/binary>>,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> [<<"">>];
        Result -> Result
    end.

add_device(Context) ->
    Props = modkazoo_util:filter_empty(
        [{[<<"data">>,<<"sip">>,<<"username">>],z_context:get_q("sipusername",Context)}
        ,{[<<"data">>,<<"sip">>,<<"password">>],z_context:get_q("sippassword",Context)}
        ,{[<<"data">>,<<"call_forward">>,<<"enabled">>], case z_context:get_q("cellphonenumber",Context) of 'undefined' -> false; _ -> true end}
        ,{[<<"data">>,<<"call_forward">>,<<"number">>],z_context:get_q("cellphonenumber",Context)}
        ,{[<<"data">>,<<"name">>],z_context:get_q("name",Context)}
        ,{[<<"data">>,<<"owner_id">>],z_context:get_q("device_owner_id",Context)}
        ,{[<<"data">>,<<"device_type">>],z_context:get_q("device_type",Context)}
        ]),
    DataBag = lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,z_convert:to_binary(V),J) end, ?MK_DEVICE_SIP, Props),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?DEVICES/binary>>,
    _ = crossbar_account_request('put', API_String, DataBag, Context),
    Context.

kz_list_account_groups(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_blacklists(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?BLACKLISTS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_callflows(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_account_callflows(AccountId, Context).

kz_list_account_callflows(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CALLFLOWS/binary>>,
    crossbar_account_request('get', API_String, [], Context, []).

kz_get_account_callflow(CallflowId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_get_account_callflow(CallflowId, AccountId, Context).

kz_get_account_callflow(CallflowId, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CALLFLOWS/binary, <<"/">>/binary, (z_convert:to_binary(CallflowId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_children(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CHILDREN/binary>>,
    lists:reverse(crossbar_account_request('get', API_String, [], Context)).

kz_list_account_channels(Context) ->
    kz_list_account_channels(z_context:get_session('kazoo_account_id', Context), Context).

kz_list_account_channels('undefined', Context) ->
    kz_list_account_channels(z_context:get_session('kazoo_account_id', Context), Context);
kz_list_account_channels(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CHANNELS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_channel_info(CallId, Context) ->
    kz_channel_info(CallId, z_context:get_session('kazoo_account_id', Context), Context).

kz_channel_info(CallId, 'undefined', Context) ->
    kz_channel_info(CallId, z_context:get_session('kazoo_account_id', Context), Context);
kz_channel_info(CallId, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CHANNELS/binary, <<"/">>/binary , (z_convert:to_binary(CallId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_channel_action(CallId, DataBag, Context) ->
    kz_channel_action(CallId, DataBag, z_context:get_session('kazoo_account_id', Context), Context).

kz_channel_action(CallId, DataBag, 'undefined', Context) ->
    kz_channel_action(CallId, DataBag, z_context:get_session('kazoo_account_id', Context), Context);
kz_channel_action(CallId, DataBag, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CHANNELS/binary, <<"/">>/binary , (z_convert:to_binary(CallId))/binary>>,
    crossbar_account_request('post', API_String, DataBag, Context).

kz_channel_hangup(CallId, AccountId, Context) ->
    DataBag = {[{<<"data">>, {[{<<"action">>, <<"hangup">>}]}}]},
    kz_channel_action(CallId, DataBag, AccountId, Context).

kz_channel_transfer(Target, CallId, AccountId, Context) ->
    DataBag = {[{<<"data">>, {[{<<"action">>, <<"transfer">>}, {<<"target">>, z_convert:to_binary(Target)}, {<<"takeback_dtmf">>, <<"*1">>}]}}]},
    kz_channel_action(CallId, DataBag, AccountId, Context).

kz_channel_eavesdrop(Id, Mode, CallId, AccountId, Context) ->
    DataBag = {[{<<"data">>, {[{<<"call_id">>, z_convert:to_binary(CallId)}, {<<"mode">>, z_convert:to_binary(Mode)}, {<<"id">>, z_convert:to_binary(Id)}]}}]},
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?QUEUES/binary, ?EAVESDROP/binary>>,
    crossbar_account_request('put', API_String, DataBag, Context).

add_group(Context) ->
    Endpoints = lists:foldr(fun(T,J) -> case T of
                                           {_,[]} -> []++J; 
                                           {"user",Id} ->  J++[{z_convert:to_binary(Id),{[{<<"type">>,<<"user">>}]}}];
                                           {"device",Id} ->  J++[{z_convert:to_binary(Id),{[{<<"type">>,<<"device">>}]}}];
                                           _ -> []++J 
                                       end 
                               end, [], z_context:get_q_all(Context)),
    Props = modkazoo_util:filter_empty(
        [{[<<"data">>,<<"name">>],z_convert:to_binary(z_context:get_q("name",Context))}
        ,{[<<"data">>,<<"endpoints">>],{Endpoints}}
        ]),
    DataBag = lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, ?MK_GROUP, Props),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary>>,
    _ = crossbar_account_request('put', API_String, DataBag, Context),
    Context.

modify_group(Context) ->
    modify_group(z_context:get_q("group_id",Context), Context).

modify_group(GroupId, Context) ->
    Endpoints = lists:foldr(fun(T,J) -> case T of
                                           {_,[]} -> []++J; 
                                           {"user",Id} ->  J++[{z_convert:to_binary(Id),{[{<<"type">>,<<"user">>}]}}];
                                           {"device",Id} ->  J++[{z_convert:to_binary(Id),{[{<<"type">>,<<"device">>}]}}];
                                           _ -> []++J 
                                       end 
                               end, [], z_context:get_q_all(Context)),
    Props = modkazoo_util:filter_empty(
        [{[<<"data">>,<<"name">>],z_convert:to_binary(z_context:get_q("name",Context))}
        ,{[<<"data">>,<<"endpoints">>],{Endpoints}}
        ]),
    DataBag = lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, kz_get_group_doc(GroupId, Context), Props),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, <<"/">>/binary, (z_convert:to_binary(GroupId))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context);
        'true' -> []
    end.

delete_group(GroupId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, <<"/">>/binary, (z_convert:to_binary(GroupId))/binary>>,
            crossbar_account_request('delete', API_String, [], Context);
        'true' -> []
    end.

kz_get_group_doc(GroupId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, <<"/">>/binary, (z_convert:to_binary(GroupId))/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

kz_set_group_doc(K, V, GroupId, Context) ->
    CurrDoc = kz_get_group_doc(GroupId, Context),
    NewDoc = modkazoo_util:set_value(K, V, CurrDoc),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, <<"/">>/binary, (z_convert:to_binary(GroupId))/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context);
        'true' -> []
    end.

cf_add_number(Number, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context) of
        'undefined' -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    Numbers = modkazoo_util:get_value([<<"numbers">>], CurrentCallflow) ++ [z_convert:to_binary(Number)],
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"numbers">>], Numbers, CurrentCallflow), Context).

cf_add_pattern(Pattern, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context) of
        'undefined' -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    Patterns = modkazoo_util:get_value([<<"patterns">>], CurrentCallflow) ++ [z_convert:to_binary(Pattern)],
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"patterns">>], Patterns, CurrentCallflow), Context).

cf_delete_number(Number, Context) ->
    case z_context:get_session('current_callflow', Context) of
        'undefined' -> 'undefined';
        CurrentCallflow -> 
            Numbers = modkazoo_util:get_value([<<"numbers">>], CurrentCallflow) -- [z_convert:to_binary(Number)],
            Patterns = modkazoo_util:get_value([<<"patterns">>], CurrentCallflow) -- [z_convert:to_binary(Number)],
            Routines = [fun(J) -> modkazoo_util:set_value([<<"numbers">>], Numbers, J) end
                        ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], Patterns, J) end],
            NewCallflow = lists:foldl(fun(F, J) -> F(J) end, CurrentCallflow, Routines),
            z_context:set_session('current_callflow', NewCallflow, Context)
    end.

cf_edit_name(Name, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context) of
        'undefined' -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"name">>], z_convert:to_binary(Name), CurrentCallflow), Context).
    

cf_contact_list_exclude(Value, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context) of
        'undefined' -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    case Value of
        "on" -> z_context:set_session('current_callflow', modkazoo_util:set_value([<<"contact_list">>, <<"exclude">>], 'true', CurrentCallflow), Context);
        _ -> z_context:set_session('current_callflow', modkazoo_util:set_value([<<"contact_list">>, <<"exclude">>], 'false', CurrentCallflow), Context)
    end.
    
cf_set_session('current_callflow', K, V, Context) ->
    modkazoo_util:set_session_jobj('current_callflow', K, V, ?EMPTY_CALLFLOW, Context).

cf_save('current_callflow', Context) ->
    CurrentCallflow = z_context:get_session('current_callflow', Context),
    DataBag = ?MK_DATABAG(CurrentCallflow),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case modkazoo_util:get_value(<<"id">>,CurrentCallflow) of
        'undefined' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary>>,
            case crossbar_account_request('put', API_String, DataBag, Context) of
                <<>> -> z_render:growl_error(?__("Something wrong happened.", Context), Context); 
                Result ->
                    cf_set_session('current_callflow', <<"id">>, modkazoo_util:get_value(<<"id">>,Result), Context),
                    mod_signal:emit({update_cf_builder_area, []}, Context),
                    z_render:growl(?__("Callflow saved", Context), Context)
            end;
        Id ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            case crossbar_account_request('post', API_String, ?MK_DATABAG(z_context:get_session('current_callflow', Context)), Context) of
                <<>> -> z_render:growl_error(?__("Something wrong happened.", Context), Context);
                _ ->
                    mod_signal:emit({update_cf_builder_area, []}, Context),
                    z_render:growl(?__("Callflow saved", Context), Context)
            end
    end.

cf_delete('current_callflow', Context) ->
    CurrentCallflow = z_context:get_session('current_callflow', Context),
    case modkazoo_util:get_value(<<"id">>,CurrentCallflow) of
        'undefined' ->
            z_context:set_session('current_callflow', 'undefined', Context);
        Id ->
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('delete', API_String, [], Context),
            z_context:set_session('current_callflow', 'undefined', Context)
    end.


kz_list_account_media(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MEDIA/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_media_doc(MediaId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse MediaId =:= 'undefined' orelse MediaId =:= 'null' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?MEDIA/binary, <<"/">>/binary, (z_convert:to_binary(MediaId))/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

cf_build_page_group_endpoints(Context) ->
    lists:map(fun (EndpointId) ->
                  {[{<<"endpoint_type">>,z_convert:to_binary(z_context:get_q(EndpointId++"_type", Context))}
                   ,{<<"id">>,z_convert:to_binary(EndpointId)}]}
              end, z_context:get_q_all("sortable_element", Context)).

cf_build_ring_group_endpoints(Context) ->
    lists:map(fun (EndpointId) -> cf_form_endpoint(EndpointId, Context) end, z_context:get_q_all("sortable_element", Context)).

cf_form_endpoint(EndpointId, Context) ->
    {[{<<"endpoint_type">>,z_convert:to_binary(z_context:get_q(EndpointId++"_type", Context))}
     ,{<<"id">>,z_convert:to_binary(EndpointId)}
     ,{<<"delay">>,z_convert:to_binary(z_context:get_q(EndpointId++"_delay", Context))}
     ,{<<"timeout">>,z_convert:to_binary(z_context:get_q(EndpointId++"_timeout", Context))}]}.

cf_calculate_ring_group_timeout(Context) ->
    Timeouts = lists:map(fun (EndpointId) -> z_convert:to_integer(z_context:get_q(EndpointId++"_delay", Context))
                                            +z_convert:to_integer(z_context:get_q(EndpointId++"_timeout", Context))
                              end
                         ,z_context:get_q_all("sortable_element", Context)),
    case z_context:get_q("strategy", Context) of
        "simultaneous" -> lists:max(Timeouts); 
        "single" -> lists:foldl(fun(X, Sum) -> X + Sum end, 0, Timeouts)
    end.

kz_list_account_menus(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MENUS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_menu(Context) ->
    Id = z_context:get_q("menu_id",Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    Props = [{<<"name">>, z_convert:to_binary(z_context:get_q("name", Context))}
            ,{<<"retries">>, z_convert:to_binary(z_context:get_q("retries", Context))}
            ,{<<"timeout">>, z_convert:to_binary(z_context:get_q("timeout", Context))}
            ,{<<"max_extension_length">>, z_convert:to_binary(z_context:get_q("max_extension_length", Context))}
            ,{<<"media">>, {[{<<"exit_media">>, not(modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context)))}
                            ,{<<"invalid_media">>, not(modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context)))}
                            ,{<<"transfer_media">>, not(modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context)))}
                            ,{<<"greeting">>, z_convert:to_binary(z_context:get_q("greeting", Context))}]}}
            ,{<<"record_pin">>, z_convert:to_binary(z_context:get_q("record_pin", Context))}
            ,{<<"allow_record_from_offnet">>, modkazoo_util:on_to_true(z_context:get_q("allow_record_from_offnet", Context))}
            ,{<<"hunt">>, modkazoo_util:on_to_true(z_context:get_q("hunt", Context))}
            ,{<<"suppress_media">>, modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context))}
            ,{<<"hunt_allow">>, z_convert:to_binary(z_context:get_q("hunt_allow", Context))}
            ,{<<"hunt_deny">>, z_convert:to_binary(z_context:get_q("hunt_deny", Context))}
            ,{<<"id">>, z_convert:to_binary(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MENUS/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MENUS/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_menu(Verb, MenuId,Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MENUS/binary, <<"/">>/binary, (z_convert:to_binary(MenuId))/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

kz_list_account_temporal_rules(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?TEMPORAL_RULES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_temporal_rule(RuleId,Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?TEMPORAL_RULES/binary, <<"/">>/binary, (z_convert:to_binary(RuleId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

cf_child([{tool_name,ToolName},{drop_id,DropId},{drop_parent,DropParent},{branch_id,BranchId},{switch,Switch}],Context) ->
    PathToChildren = case BranchId of
        "flow0" -> "flow-root";
        _ -> DropId++"-children"
    end,
    ElementId = case BranchId of
        "flow0" -> DropId;
        _ -> DropId++"-children-"++Switch
    end,
    lager:info("Drop Switch: ~p",[Switch]),
    lager:info("Drop PathToChildren: ~p",[PathToChildren]),
    lager:info("Drop ElementId: ~p",[ElementId]),
    lager:info("Drop DropParent: ~p",[DropParent]),
    lager:info("Element doesn't exist: ~p",[cf_child_not_exists(ElementId, Context)]),
    'true' = cf_child_not_exists(ElementId, Context),
    case ToolName of
        "branch_recovery" ->
            case z_context:get_session('cf_park_slot1', Context) of
                'undefined' -> 
                    Context2 = z_render:dialog_close(Context),
                    z_render:growl(?__("No saved brunch", Context2), Context2);
                ParkedBranch ->
                    _ = kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-"), ParkedBranch, Context),
                    mod_signal:emit({update_cf_builder_area, []}, Context),
                    z_render:dialog_close(Context)
            end;
        _ ->
            Context1 = z_render:insert_bottom(PathToChildren
                                     ,z_template:render("_cf_child.tpl",[{tool_name,ToolName}
                                                                        ,{element_id, ElementId}
                                                                        ,{drop_parent,DropParent}
                                                                        ,{switch,Switch}]
                                                        ,Context)
                                     ,Context),
            kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["module"], z_convert:to_binary(ToolName), Context),
            kazoo_util:cf_set_session('current_callflow', z_string:split(ElementId,"-")++["children"], {[]}, Context),
            z_render:dialog(?__("Select ",Context1), "_cf_select_"++ToolName++".tpl", [{element_id, ElementId},{tool_name,ToolName}], Context1)
    end.

cf_child_not_exists(ElementId, Context) ->
    'undefined' == modkazoo_util:get_value(cf_element_path(ElementId++"-module"), z_context:get_session('current_callflow', Context)).

cf_load_to_session(CallflowId,Context) ->
    lager:info("CallflowId: ~p",[CallflowId]),
    case CallflowId of
        [] -> 'ok';
        'undefined' -> 'ok';
        "new" -> z_context:set_session('current_callflow', ?EMPTY_CALLFLOW, Context);
        _ -> z_context:set_session('current_callflow', kz_get_account_callflow(CallflowId, Context), Context)
    end.

cf_may_be_add_child(BranchId,DropId,DropParent,Context) ->
    case BranchId of
        "flow0" -> cf_may_be_add_root_child(Context);
        _ -> cf_may_be_add_desc_child(BranchId,DropId,DropParent,Context)
    end.

cf_may_be_add_root_child(Context) ->
    lager:info("=============== Root child ======================="),
    case modkazoo_util:get_value([<<"flow">>,<<"module">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> Context;
        ModuleName ->
            lager:info("may_be_add_child ModuleName: ~p",[ModuleName]),
            [KzElementId, KzElementName] = cf_get_module_info(ModuleName,[<<"flow">>],Context),
            z_render:insert_bottom("flow-root",z_template:render("_cf_child.tpl",[{tool_name,z_convert:to_list(ModuleName)}
                                                                                 ,{element_id,"flow"}
                                                                                 ,{kz_element_id, KzElementId}
                                                                                 ,{kz_element_name, KzElementName}
                                                                                 ,{drop_parent,"root"}],Context),Context)
    end.

cf_may_be_add_desc_child(BranchId,DropId,DropParent,Context) ->
    lager:info("================ May be Descendant Child ======================"),
    lager:info("cf_may_be_add_desc_child BranchId: ~p",[BranchId]),
    lager:info("cf_may_be_add_desc_child DropId: ~p",[DropId]),
    lager:info("cf_may_be_add_desc_child DropParent: ~p",[DropParent]),
    ElementPath = lists:map(fun (K) -> z_convert:to_binary(K) end, z_string:split(BranchId,"-")),
    lager:info("cf_may_be_add_desc_child ElementPath: ~p",[ElementPath]),
    case modkazoo_util:get_value(ElementPath++[<<"children">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> Context;
        {[]} -> Context;
        Children ->
            lists:foldl(fun(Switch, ContextAcc) -> cf_add_desc_child(BranchId,DropId,DropParent,Switch,ContextAcc) end, Context, modkazoo_util:get_keys(Children))
    end.

cf_add_desc_child(BranchId,DropId,DropParent,Switch,Context) ->
    lager:info("================ Add Descendant Child ======================"),
    lager:info("cf_add_desc_child BranchId: ~p",[BranchId]),
    lager:info("cf_add_desc_child DropId: ~p",[DropId]),
    lager:info("cf_add_desc_child DropParent: ~p",[DropParent]),
    lager:info("cf_add_desc_child Swicth: ~p",[Switch]),
    PathToChildren = BranchId++"-children",
    lager:info("cf_add_desc_child PathToChildren: ~p",[PathToChildren]),
    ElementId = PathToChildren++"-"++z_convert:to_list(Switch),
    lager:info("cf_add_desc_child ElementId: ~p",[ElementId]),
    ElementPath = lists:map(fun (K) -> z_convert:to_binary(K) end, z_string:split(BranchId,"-")),
    ParentModuleName = modkazoo_util:get_value(ElementPath++[<<"module">>],z_context:get_session('current_callflow', Context)),
    lager:info("cf_add_desc_child ParentModuleName: ~p",[ParentModuleName]),
    ModulePath = ElementPath++[<<"children">>,Switch],
    lager:info("cf_add_desc_child ModulePath: ~p",[ModulePath]),
    ModuleName = modkazoo_util:get_value(ModulePath++[<<"module">>],z_context:get_session('current_callflow', Context)),
    lager:info("cf_add_desc_child ModuleName: ~p",[ModuleName]),
    [KzElementId, KzElementName] = cf_get_module_info(ModuleName,ModulePath,Context),
    z_render:insert_bottom(PathToChildren ,z_template:render("_cf_child.tpl",[{tool_name,z_convert:to_list(ModuleName)}
                                                                             ,{element_id, ElementId}
                                                                             ,{kz_element_id, KzElementId}
                                                                             ,{kz_element_name, KzElementName}
                                                                             ,{drop_parent,z_convert:to_list(ParentModuleName)}
                                                                             ,{switch,Switch}],Context),Context).

cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"user">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            UserDoc = kz_get_user_doc(Id, Context),
            [Id,<<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary,<<" ">>/binary,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"device">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' ->
            DeviceDoc = kz_get_device_doc(Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,DeviceDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"voicemail">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            VMBoxDoc = kz_list_user_vmbox_details(Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,VMBoxDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"play">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            MediaDoc = kz_get_account_prompt(Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,MediaDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"menu">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            MenuDoc = kz_menu('get', Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,MenuDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"temporal_route">> ->
    Name = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"timezone">>],z_context:get_session('current_callflow', Context)), 
    ['undefined', Name];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"record_call">> ->
    Format = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"format">>],z_context:get_session('current_callflow', Context)), 
    [Format, Format];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"callflow">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            CallflowDoc = kz_get_account_callflow(Id, Context),
            case modkazoo_util:get_value(<<"name">>,CallflowDoc) of
                'undefined' -> [Id,lists:nth(1,modkazoo_util:get_value(<<"numbers">>,CallflowDoc))];
                Name -> [Id, Name]
            end;
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"receive_fax">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"owner_id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            UserDoc = kz_get_user_doc(Id, Context),
            [Id,<<(modkazoo_util:get_value_bin(<<"first_name">>,UserDoc))/binary,<<" ">>/binary,(modkazoo_util:get_value_bin(<<"last_name">>,UserDoc))/binary>>];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"ring_group">> ->
    Name = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"name">>],z_context:get_session('current_callflow', Context)),
    ['undefined', Name];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"page_group">> ->
    Name = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"name">>],z_context:get_session('current_callflow', Context)),
    ['undefined', Name];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"check_cid">> ->
    case modkazoo_util:get_value(ModulePath++[<<"data">>,<<"use_absolute_mode">>],z_context:get_session('current_callflow', Context)) of
        'true' -> ['undefined', <<"Exact numbers">>];
        'false' -> ['undefined', <<"Regex match">>];
        _ -> ['undefined', undefined]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"prepend_cid">> ->
    CallerIdNamePrefix = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"caller_id_name_prefix">>],z_context:get_session('current_callflow', Context)),
    CallerIdNumberPrefix = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"caller_id_number_prefix">>],z_context:get_session('current_callflow', Context)),
    ['undeined',[CallerIdNamePrefix ,CallerIdNumberPrefix]];
%    ['undeined',<<CallerIdNamePrefix/binary,<<" ">>/binary,CallerIdNumberPrefix/binary>>];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"conference">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            Doc = kz_conference('get', Id,Context),
            [Id,case modkazoo_util:get_value(<<"name">>,Doc) of 'undefined' -> <<"Conference Server">>; Name -> Name end];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"eavesdrop">> ->
    Callflow = z_context:get_session('current_callflow', Context),
    case lists:foldl(fun(X,J) ->
                                     case modkazoo_util:get_value(ModulePath++[<<"data">>,X],Callflow) of 'undefined' -> J++[]; Id -> J++[{Id,X}] end end
                                ,[]
                                ,[<<"device_id">>,<<"user_id">>,<<"group_id">>]) of
        [] -> ['undefined','undefined'];
        [{Id,Type}|_] -> 
            case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],Callflow) of
                'undefined' -> [Id,kz_get_name(Id, Type, Context)];
                Name -> [Id,Name]
            end
    end;
cf_get_module_info(_ModuleName,_ModulePath,_Context) ->
    ['undefined','undefined'].

kz_get_name(Id, Type, Context) ->
    case Type of
        <<"device_id">> -> modkazoo_util:get_value(<<"name">>,kz_get_device_doc(Id, Context));
        <<"group_id">> -> modkazoo_util:get_value(<<"name">>,kz_get_device_doc(Id, Context));
        <<"user_id">> -> 
            UserDoc = kz_get_user_doc(Id, Context),
            <<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary,<<" ">>/binary,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>
    end.
    
cf_delete_element(ElementId,Context) ->
    modkazoo_util:delete_session_jobj_key('current_callflow', cf_element_path(ElementId), Context).
    
cf_park_element(ElementId,Context) ->
    ParkCandidate = modkazoo_util:get_value(cf_element_path(ElementId), z_context:get_session('current_callflow', Context)),
    z_context:set_session('cf_park_slot1', ParkCandidate, Context),
    z_render:growl(?__("Branch saved", Context), Context).

cf_element_path(ElementId) ->
    lists:map(fun (K) -> z_convert:to_binary(K) end, z_string:split(ElementId,"-")).

cf_get_element_by_id(ElementId, Context) ->
    modkazoo_util:get_value(cf_element_path(ElementId), z_context:get_session('current_callflow', Context)). 

cf_handle_drop({drop,{dragdrop,{drag_args,[{tool_name,ToolName}]},mod_kazoo,_},{dragdrop,{drop_args,[{drop_id,DropId},{drop_parent,DropParent}]},mod_kazoo,BranchId}},Context) ->
    lager:info("Drop DropParent: ~p",[DropParent]),
    case z_convert:to_list(DropParent) of
        "check_cid" ->
            lager:info("Drop BranchId: ~p",[BranchId]),
            [KeysList,AddOn] = case modkazoo_util:get_value(cf_element_path(BranchId)++[<<"data">>,<<"use_absolute_mode">>], z_context:get_session('current_callflow', Context)) of
                           'false' -> [[<<"nomatch">>,<<"match">>],[]];
                           'true' -> [[<<"nomatch">>],[<<"caller_id">>]] 
                       end,
            case cf_available_keys(KeysList,cf_element_path(BranchId),AddOn,Context) of
                [] -> z_render:growl_error(?__("No routing keys left.",Context), Context); 
                AvailableKeys ->
                    z_render:dialog(?__("Choose route option",Context)
                                         ,"_cf_select_option_check_cid.tpl"
                                         ,[{tool_name,ToolName},{drop_id,DropId},{drop_parent,DropParent},{branch_id,BranchId},{available_keys,AvailableKeys}]
                                         ,Context)
            end;
        "menu" ->
            lager:info("Drop BranchId: ~p",[BranchId]),
            z_render:dialog(?__("Menu option",Context)
                                 ,"_cf_select_option.tpl"
                                 ,[{tool_name,ToolName},{drop_id,DropId},{drop_parent,DropParent},{branch_id,BranchId},{available_keys,cf_available_keys(?MENU_KEYS_LIST,cf_element_path(BranchId),Context)}]
                                 ,Context);
        "temporal_route" ->
            lager:info("Drop BranchId: ~p",[BranchId]),
            KeysList = [<<"_">>]++lists:map(fun(X) -> modkazoo_util:get_value(<<"id">>,X) end, kz_list_account_temporal_rules(Context)),
            z_render:dialog(?__("Menu option",Context)
                                 ,"_cf_select_option_temporal_route.tpl"
                                 ,[{tool_name,ToolName}
                                  ,{drop_id,DropId}
                                  ,{drop_parent,DropParent}
                                  ,{branch_id,BranchId}
                                  ,{available_keys,cf_available_keys(KeysList,cf_element_path(BranchId),Context)}]
                                 ,Context);
        _ ->
            Switch = case BranchId of
                "flow0" -> "";
                _ -> "_"
            end,
            kazoo_util:cf_child([{tool_name,ToolName},{drop_id,DropId},{drop_parent,DropParent},{branch_id,BranchId},{switch,Switch}],Context)
    end.

cf_available_keys(KeysList,ElementPath,Context) ->
    cf_available_keys(KeysList,ElementPath,[],Context).

cf_available_keys(KeysList,ElementPath,AddOn,Context) ->
    AllocatedKeys = case modkazoo_util:get_value(ElementPath++[<<"children">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> [];
        {[]} -> [];
        Children ->
            modkazoo_util:get_keys(Children)
    end,
    lists:filter(fun(X) -> 'true' =/= lists:member(X,AllocatedKeys) end, KeysList)++AddOn.

cf_choose_new_switch(ExistingElementId,DropParent,Context) ->
    case DropParent of
        "check_cid" ->
            lager:info("Drop ExistingElementId: ~p",[ExistingElementId]),
            lager:info("Drop TL: ~p",[lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))]),
            lager:info("Switch: ~p",[hd(lists:reverse(cf_element_path(ExistingElementId)))]),
            [KeysList,AddOn] = case modkazoo_util:get_value(lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))++[<<"data">>,<<"use_absolute_mode">>]
                                                   ,z_context:get_session('current_callflow', Context)) of
                           'false' -> [[<<"nomatch">>,<<"match">>],[]];
                           'true' -> [[<<"nomatch">>],[<<"caller_id">>]]
                       end,
            z_render:dialog(?__("Choose route option",Context)
                                 , "_cf_select_option_check_cid.tpl"
                                 ,[{existing_element_id,ExistingElementId}
                                 ,{switch,hd(lists:reverse(cf_element_path(ExistingElementId)))}
                                  ,{available_keys,cf_available_keys(KeysList,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId))))),AddOn,Context)}]
                                 ,Context);
        "menu" ->
            z_render:dialog(?__("Menu option",Context)
                               , "_cf_select_option.tpl"
                               ,[{existing_element_id,ExistingElementId}
                                ,{kz_element_id,hd(lists:reverse(modkazoo_util:split_b(ExistingElementId,"-")))}
                                ,{available_keys,cf_available_keys(?MENU_KEYS_LIST,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId))))),Context)}]
                            ,Context);
        "temporal_route" ->
            KeysList = [<<"_">>]++lists:map(fun(X) -> modkazoo_util:get_value(<<"id">>,X) end, kz_list_account_temporal_rules(Context)),
            z_render:dialog(?__("Menu option",Context)
                                 ,"_cf_select_option_temporal_route.tpl"
                               ,[{existing_element_id,ExistingElementId}
                                ,{kz_element_id,hd(lists:reverse(modkazoo_util:split_b(ExistingElementId,"-")))}
                          %      ,{available_keys,cf_available_keys(KeysList,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId))))),Context)}]
                                ,{available_keys,KeysList}]
                            ,Context)
    end.

cf_set_new_switch(ExistingElementId,NewSwitch,Context) ->
    Callflow = z_context:get_session('current_callflow', Context),
    Element = cf_get_element_by_id(ExistingElementId, Context),
    Callflow1 = modkazoo_util:delete_key(cf_element_path(ExistingElementId), Callflow),
    Callflow2 = modkazoo_util:set_value(lists:reverse(tl(lists:reverse(cf_element_path(ExistingElementId))))++[NewSwitch],Element,Callflow1),
    z_context:set_session('current_callflow', Callflow2, Context).

cf_time_of_the_day(Context) ->
    [TimeWindowStart, TimeWindowStop] = z_string:split(z_context:get_q("time",Context),";"),
    Wdays = lists:filter(fun(Wd) -> case Wd of [] -> false; _ -> true end end, z_context:get_q_all("wdays",Context)),
    Days = z_context:get_q("days",Context),
    [StartDay,StartMonth,StartYear] = z_string:split(z_context:get_q("start_date",Context),"/"),
    StartDate = calendar:datetime_to_gregorian_seconds({{z_convert:to_integer(StartYear),z_convert:to_integer(StartMonth),z_convert:to_integer(StartDay)},{0,0,0}}),
    Id = z_context:get_q("id",Context),
    Props = [{<<"time_window_start">>, z_convert:to_binary(TimeWindowStart)}
            ,{<<"time_window_stop">>, z_convert:to_binary(TimeWindowStop)}
            ,{<<"wdays">>, case Wdays of 'undefined' -> 'undefined'; _ -> lists:map(fun(Wday) -> z_convert:to_binary(Wday) end, Wdays) end}
            ,{<<"days">>, case Days of 'undefined' -> 'undefined'; _ -> lists:map(fun(Day) -> z_convert:to_binary(Day) end, [Days]) end}
            ,{<<"interval">>, z_convert:to_binary(z_context:get_q("interval",Context))}
            ,{<<"cycle">>, z_convert:to_binary(z_context:get_q("cycle",Context))}
            ,{<<"name">>, z_convert:to_binary(z_context:get_q("name",Context))}
            ,{<<"type">>, z_convert:to_binary(z_context:get_q("type",Context))}
            ,{<<"start_date">>, StartDate}
            ,{<<"id">>, z_convert:to_binary(Id)}
            ,{<<"enabled">>, z_convert:to_atom(z_context:get_q("enabled",Context))}
            ,{<<"ordinal">>, z_convert:to_binary(z_context:get_q("ordinal",Context))}
            ,{<<"month">>, z_convert:to_binary(z_context:get_q("month",Context))}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?TEMPORAL_RULES/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?TEMPORAL_RULES/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

cf_delete_time_of_the_day_rule(RuleId,Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?TEMPORAL_RULES/binary, <<"/">>/binary, (z_convert:to_binary(RuleId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

upload_media(Context) ->
    try
        PromptName = case z_context:get_q("promptname", Context) of
            [] ->
               throw(no_name_entered);
            PromptNameStr ->
               z_convert:to_binary(PromptNameStr)
        end,
        case z_context:get_q("promptfile", Context) of
            {upload, UploadFilename, UploadTmp, _, _} ->
                false = modkazoo_util:check_file_size_exceeded(promptfile, UploadTmp, 15000000),
                Result = set_media_doc(z_context:get_q("prompt_id", Context), PromptName, z_convert:to_binary(UploadFilename), Context),
                set_media_attachment(modkazoo_util:get_value(<<"id">>, Result), UploadFilename, UploadTmp, Context);
            _ ->
                case z_context:get_q("existing_description", Context) of
                    'undefined' -> throw(no_document_uploaded);
                    ExistingDescr ->  
                        set_media_doc(z_context:get_q("prompt_id", Context), PromptName, ExistingDescr, Context)
                end
        end,
        mod_signal:emit({update_admin_portal_media_list_tpl, []}, Context),
        z_render:dialog_close(Context)
    catch
        no_name_entered -> z_render:growl_error(?__("No name entered",Context), Context);
        no_document_uploaded -> z_render:growl_error(?__("No document chosen",Context), Context);
        error:{badmatch, {true, promptfile}} -> z_render:growl_error(?__("Maximum file size exceeded. Please try to upload smaller file.",Context), Context);
        E1:E2 ->
            lager:info("Error. E1: ~p E2: ~p", [E1, E2]),
            z_render:growl_error(?__("Something wrong happened.",Context), Context)
    end.

set_media_doc(Id, PromptName, Description, Context) ->
    Props =  [{<<"streamable">>,true}
             ,{<<"name">>, z_convert:to_binary(PromptName)}
             ,{<<"media_source">>, <<"upload">>}
             ,{<<"id">>, z_convert:to_binary(Id)}
             ,{<<"description">>, z_convert:to_binary(Description)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?MEDIA/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?MEDIA/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.
  
set_media_attachment(Id, UploadFilename, UploadTmp, Context) ->
    {ok, Data} = file:read_file(UploadTmp),
    {ok, IdnProps} = z_media_identify:identify(UploadTmp, UploadFilename, Context),
    Mime = proplists:get_value(mime, IdnProps),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String_Raw = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?MEDIA/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary, ?RAW/binary>>,
    Headers = [{"Content-Type",Mime}],
    crossbar_account_send_raw_request('post', API_String_Raw, Headers, Data, Context).

kz_delete_prompt(PromptId,Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MEDIA/binary, <<"/">>/binary, (z_convert:to_binary(PromptId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_get_account_prompt(PromptId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MEDIA/binary, <<"/">>/binary, (z_convert:to_binary(PromptId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_account_prompt_attachment(PromptId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?MEDIA/binary, <<"/">>/binary, (z_convert:to_binary(PromptId))/binary, ?RAW/binary>>,
    crossbar_account_attachment_request('get', API_String, [], Context).

kz_list_account_conferences(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CONFERENCES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_c2calls(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CLICKTOCALL/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_vmbox(Context) ->
    Id = z_context:get_q("vmbox_id",Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    Props = [{<<"name">>, z_convert:to_binary(z_context:get_q("name", Context))}
            ,{<<"mailbox">>, z_convert:to_binary(z_context:get_q("mailbox", Context))}
            ,{<<"pin">>, z_convert:to_binary(z_context:get_q("pin", Context))}
            ,{<<"owner_id">>, z_convert:to_binary(z_context:get_q("owner_id", Context))}
            ,{<<"media">>, case z_context:get_q("unavailable_message_id", Context) of [] -> 'undefined'; MessageId -> {[{<<"unavailable">>, z_convert:to_binary(MessageId)}]} end}
            ,{<<"timezone">>, z_convert:to_binary(z_context:get_q("vmbox_timezone", Context))}
            ,{<<"is_setup">>, modkazoo_util:on_to_true(z_context:get_q("is_setup", Context))}
            ,{<<"require_pin">>, modkazoo_util:on_to_true(z_context:get_q("require_pin", Context))}
            ,{<<"check_if_owner">>, modkazoo_util:on_to_true(z_context:get_q("check_if_owner", Context))}
            ,{<<"skip_greeting">>, modkazoo_util:on_to_true(z_context:get_q("skip_greeting", Context))}
            ,{<<"skip_instructions">>, modkazoo_util:on_to_true(z_context:get_q("skip_instructions", Context))}
            ,{<<"delete_after_notify">>, modkazoo_util:on_to_true(z_context:get_q("delete_after_notify", Context))}
            ,{<<"id">>, z_convert:to_binary(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_vmbox(Verb, VmboxId,Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?VMBOXES/binary, <<"/">>/binary, (z_convert:to_binary(VmboxId))/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

kz_conference(Context) ->
    Id = z_context:get_q("conference_id",Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    Numbers = lists:map(fun (K) -> re:replace(K, "[^A-Za-z0-9]", "", [global, {return, binary}]) end, z_string:split(z_context:get_q("numbers", Context),",")),
    Pins = lists:map(fun (K) -> re:replace(K, "[^A-Za-z0-9]", "", [global, {return, binary}]) end, z_string:split(z_context:get_q("pins", Context),",")),
    Props = [{<<"name">>, z_convert:to_binary(z_context:get_q("name", Context))}
            ,{<<"member">>, {[{<<"numbers">>, case Numbers of [<<>>] -> []; _ -> Numbers end}
                            ,{<<"pins">>, case Pins of [<<>>] -> []; _ -> Pins end}
                            ,{<<"join_muted">>, modkazoo_util:on_to_true(z_context:get_q("join_muted", Context))}
                            ,{<<"join_deaf">>, modkazoo_util:on_to_true(z_context:get_q("join_deaf", Context))}]}}
            ,{<<"owner_id">>, z_convert:to_binary(z_context:get_q("owner_id", Context))}
            ,{<<"play_name">>, modkazoo_util:on_to_true(z_context:get_q("play_name", Context))}
            ,{<<"moderator">>, {[{<<"numbers">>, []}
                            ,{<<"pins">>, []}
                            ,{<<"join_muted">>, 'false'}
                            ,{<<"join_deaf">>, 'false'}]}}
            ,{<<"conference_numbers">>, []}
            ,{<<"id">>, z_convert:to_binary(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CONFERENCES/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CONFERENCES/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_conference(Verb, ConferenceId,Context) ->
    kz_conference(Verb, ConferenceId, [], Context).

kz_conference(Verb, ConferenceId, DataBag, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CONFERENCES/binary, <<"/">>/binary, (z_convert:to_binary(ConferenceId))/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_conference_details(ConferenceId,Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CONFERENCES/binary, <<"/">>/binary, (z_convert:to_binary(ConferenceId))/binary, ?DETAILS/binary>>,
lager:info("IAM kz_conference_details: ~p", [crossbar_account_request('get', API_String, [], Context)]),
    crossbar_account_request('get', API_String, [], Context).

dedup_kz_conference_details(ConferenceId,Context) ->
    case kz_conference_details(ConferenceId,Context) of
        <<>> -> <<>>;
        Pts ->
            lists:foldl(fun(X,Acc) ->
                            case lists:member(modkazoo_util:get_value(<<"Participant-ID">>, X), modkazoo_util:props_get_values(<<"Participant-ID">>, Acc)) of
                                'true' -> Acc;
                                'false' -> Acc ++ [X]
                            end
                        end
                        ,[]
                        ,Pts)
    end.

start_outbound_conference(_ConferenceId, Context) ->
    SelectedList = z_context:get_q('selected_list', Context),
    BLegNumber = z_context:get_q('b_leg_number', Context),
    start_outbound_conference(_ConferenceId, SelectedList, BLegNumber, Context).

start_outbound_conference(_, [], _, Context) ->
    z_render:growl_error(?__("No participants list chosen.",Context), Context);
start_outbound_conference(_, _, [], Context) ->
    z_render:growl_error(?__("No callflow chosen.",Context), Context);
start_outbound_conference(_ConferenceId, ListId, BLegNumber, Context) ->
    [OutboundCID|_] = kz_account_numbers(Context),
    NumbersList = [modkazoo_util:get_value([<<"value">>,<<"number">>],JObj) || JObj <- kz_list_account_list_entries(ListId, Context)],
    [add_cccp_autodial(ParticipantNumber, BLegNumber, OutboundCID, Context) || ParticipantNumber <- NumbersList],
    z_render:growl(?__("Attempt sent.",Context), Context).

add_conf_participant(_ConferenceId, Context) ->
    ALegNumber = z_context:get_q('a_leg_number', Context),
    BLegNumber = z_context:get_q('b_leg_number', Context),
    add_conf_participant(_ConferenceId, ALegNumber, BLegNumber, Context).

do_conference_action(ParticipantId, Action, ConferenceId, Context) ->
    DataBag = ?MK_DATABAG(?CONFERENCE_ACTION(Action, ParticipantId)),
    kz_conference('post', ConferenceId, DataBag, Context).

add_conf_participant(_, [], _, Context) ->
    z_render:growl_error(?__("No participant number filled in.",Context), Context);
add_conf_participant(_, _, [], Context) ->
    z_render:growl_error(?__("No callflow chosen.",Context), Context);
add_conf_participant(_ConferenceId, ALegNumber, BLegNumber, Context) ->
    [OutboundCID|_] = kz_account_numbers(Context),
    add_cccp_autodial(ALegNumber, BLegNumber, OutboundCID, Context),
    mod_signal:emit({update_conference_participants_tpl, []}, Context),
    z_render:growl(?__("Attempt sent.",Context), Context).

kz_c2call(Context) ->
    Id = z_context:get_q("c2call_id",Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    Props = [{<<"name">>, z_convert:to_binary(z_context:get_q("name", Context))}
            ,{<<"auth_required">>, modkazoo_util:on_to_true(z_context:get_q("auth_required", Context))}
            ,{<<"dial_first">>, z_convert:to_binary(z_context:get_q("dial_first", Context))}
            ,{<<"extension">>, z_convert:to_binary(z_context:get_q("extension", Context))}
            ,{<<"caller_id_number">>, z_convert:to_binary(z_context:get_q("caller_id_number", Context))}
        %    ,{<<"outbound_callee_id_name">>, z_convert:to_binary(z_context:get_q("caller_id_number", Context))}
            ,{<<"outbound_callee_id_number">>, z_convert:to_binary(z_context:get_q("caller_id_number", Context))}
        %    ,{<<"retain_cid">>, 'false'}
            ,{<<"id">>, z_convert:to_binary(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CLICKTOCALL/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CLICKTOCALL/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_c2call(Verb, C2CallId,Context) ->
    kz_c2call(Verb, C2CallId, [], Context).

kz_c2call(Verb, C2CallId, DataBag, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CLICKTOCALL/binary, <<"/">>/binary, (z_convert:to_binary(C2CallId))/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_c2call_hyperlink(C2CallId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?CLICKTOCALL/binary, <<"/">>/binary, (z_convert:to_binary(C2CallId))/binary, ?CONNECT/binary>>,
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    <<Crossbar_URL/binary, API_String/binary>>.

kz_get_featurecode_by_name(FCName, Context) ->
    case lists:filter(fun(X) -> z_convert:to_binary(FCName) == modkazoo_util:get_value([<<"featurecode">>,<<"name">>],X) end, kz_list_account_callflows(Context)) of
        [] -> [];
        [H|_] -> H
    end.

kz_add_featurecode_voicemail_check(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"check">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"voicemail">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*97">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"voicemail[action=check]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"97">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_voicemail_direct(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"compose">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"voicemail">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*\\*([0-9]*)$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"voicemail[action=\"direct\"]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"\\*">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_park_and_retrieve(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"auto">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"park">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*3([0-9]*)$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"park_and_retrieve">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"3">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_park_valet(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"park">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"park">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*4">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"valet">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"4">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_park_retrieve(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"retrieve">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"retrieve">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*5([0-9]*)$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"retrieve">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"5">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_intercom(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"compose">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"intercom">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*0([0-9]*)$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"intercom">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"0">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_privacy(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"full">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"privacy">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*67([0-9]*)$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"privacy[mode=full]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"67">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_hotdesk_enable(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"login">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"hotdesk">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*11">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"hotdesk[action=login]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"11">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_hotdesk_disable(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"logout">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"hotdesk">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*12">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"hotdesk[action=logout]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"12">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_hotdesk_toggle(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"toggle">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"hotdesk">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*13">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"hotdesk[action=toggle]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"13">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_call_forward_activate(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"activate">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"call_forward">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*72">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"call_forward[action=activate]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"72">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_call_forward_deactivate(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"deactivate">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"call_forward">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*73">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"call_forward[action=deactivate]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"73">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_call_forward_toggle(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"toggle">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"call_forward">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*74([0-9]*)$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"call_forward[action=toggle]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"74">>, J) end],
    kz_account_create_callflow(Routines, Context).

kz_add_featurecode_call_forward_update(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"update">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"call_forward">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"*56">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"call_forward[action=update]">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"56">>, J) end],
    kz_account_create_callflow(Routines, Context).

set_featurecode_dynamic_cid(ListId, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"action">>], <<"lists">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"id">>], z_convert:to_binary(ListId), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"dynamic_cid">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*69([0-9]{2,})$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"69">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"dynamic_cid">>, J) end],
    kz_account_create_callflow(Routines, Context).

toggle_featurecode_voicemail_check(Context) ->
    case kz_get_featurecode_by_name(<<"voicemail[action=check]">>, Context) of
        [] -> kz_add_featurecode_voicemail_check(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_voicemail_direct(Context) ->
    case kz_get_featurecode_by_name(<<"voicemail[action=\"direct\"]">>, Context) of
        [] -> kz_add_featurecode_voicemail_direct(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_park_and_retrieve(Context) ->
    case kz_get_featurecode_by_name(<<"park_and_retrieve">>, Context) of
        [] -> kz_add_featurecode_park_and_retrieve(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_park_valet(Context) ->
    case kz_get_featurecode_by_name(<<"valet">>, Context) of
        [] -> kz_add_featurecode_park_valet(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_park_retrieve(Context) ->
    case kz_get_featurecode_by_name(<<"retrieve">>, Context) of
        [] -> kz_add_featurecode_park_retrieve(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_intercom(Context) ->
    case kz_get_featurecode_by_name(<<"intercom">>, Context) of
        [] -> kz_add_featurecode_intercom(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_privacy(Context) ->
    case kz_get_featurecode_by_name(<<"privacy[mode=full]">>, Context) of
        [] -> kz_add_featurecode_privacy(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_hotdesk_enable(Context) ->
    case kz_get_featurecode_by_name(<<"hotdesk[action=login]">>, Context) of
        [] -> kz_add_featurecode_hotdesk_enable(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_hotdesk_disable(Context) ->
    case kz_get_featurecode_by_name(<<"hotdesk[action=logout]">>, Context) of
        [] -> kz_add_featurecode_hotdesk_disable(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_hotdesk_toggle(Context) ->
    case kz_get_featurecode_by_name(<<"hotdesk[action=toggle]">>, Context) of
        [] -> kz_add_featurecode_hotdesk_toggle(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_activate(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=activate]">>, Context) of
        [] -> kz_add_featurecode_call_forward_activate(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_deactivate(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=deactivate]">>, Context) of
        [] -> kz_add_featurecode_call_forward_deactivate(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_toggle(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=toggle]">>, Context) of
        [] -> kz_add_featurecode_call_forward_toggle(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_update(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=update]">>, Context) of
        [] -> kz_add_featurecode_call_forward_update(Context);
        JObj -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

delete_featurecode_dynamic_cid(Context) ->
    JObj = kz_get_featurecode_by_name(<<"dynamic_cid">>, Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

toggle_blacklist_member(BlacklistId,Context) ->
    Blacklists = case kazoo_util:kz_account_doc_field(<<"blacklists">>, Context) of
        'undefined' -> [];
        Value -> Value
    end,
    case lists:member(BlacklistId, Blacklists) of
        'true' -> kz_set_acc_doc(<<"blacklists">>, lists:usort(Blacklists)--[BlacklistId,<<"undefined">>], Context); 
        'false' -> kz_set_acc_doc(<<"blacklists">>, lists:usort(Blacklists++[BlacklistId])--[<<"undefined">>], Context) 
    end.

kz_get_account_blacklist(BlacklistId, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?BLACKLISTS/binary, <<"/">>/binary, (z_convert:to_binary(BlacklistId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

set_blacklist_doc(Id, Name, Nums, Context) ->
    Props =  [{<<"name">>, z_convert:to_binary(Name)}
             ,{<<"id">>, z_convert:to_binary(Id)}
             ,{<<"numbers">>, ?JSON_WRAPPER(lists:map(fun(X) -> {z_convert:to_binary(modkazoo_util:cleanout(X)), ?EMPTY_JSON_OBJECT} end, Nums))}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?BLACKLISTS/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?BLACKLISTS/binary, <<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_delete_blacklist(BlacklistId,Context) ->
    kz_set_acc_doc(<<"blacklists">>, lists:usort(kazoo_util:kz_account_doc_field(<<"blacklists">>, Context))--[BlacklistId,<<"undefined">>], Context),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?BLACKLISTS/binary, <<"/">>/binary, (z_convert:to_binary(BlacklistId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

may_be_check_cid_children_clean(Context) ->
    ElementId = z_context:get_q("element_id", Context),
    case z_convert:to_atom(z_context:get_q("selected", Context))
          ==
         modkazoo_util:get_value(modkazoo_util:split_b(ElementId,"-")++[<<"data">>,<<"use_absolute_mode">>], z_context:get_session('current_callflow', Context))
         of
        'true' -> 'ok';
        'false' -> check_cid_children_clean(Context)
    end. 

check_cid_children_clean(Context) ->
    CurrentCallflow = z_context:get_session('current_callflow', Context),
    ElementId = z_context:get_q("element_id", Context),
    case z_context:get_q("selected", Context) of
        "true" ->
            case modkazoo_util:get_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>,<<"match">>], z_context:get_session('current_callflow', Context)) of
                'undefined' -> 'ok';
                _ -> z_context:set_session('current_callflow', modkazoo_util:delete_key(modkazoo_util:split_b(ElementId,"-")++[<<"children">>,<<"match">>], CurrentCallflow), Context),
                     mod_signal:emit({update_cf_builder_area, []}, Context)
            end;
        "false" ->
            case modkazoo_util:get_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>,<<"nomatch">>], z_context:get_session('current_callflow', Context)) of
                'undefined' -> 
                    z_context:set_session('current_callflow', modkazoo_util:set_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>], ?EMPTY_JSON_OBJECT, CurrentCallflow), Context),
                    mod_signal:emit({update_cf_builder_area, []}, Context);
                NoMatch -> 
                    Childless = modkazoo_util:set_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>], ?EMPTY_JSON_OBJECT, CurrentCallflow),
                    z_context:set_session('current_callflow', modkazoo_util:set_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>,<<"nomatch">>], NoMatch, Childless), Context),
                    mod_signal:emit({update_cf_builder_area, []}, Context)
            end
    end.

rs_delete_account(AccountId,Context) ->
    _ = delete_account(AccountId,Context),
    z_context:add_script_session([<<"z_reload();">>], Context),
    Context.

toggle_all_calls_recording(Context) ->
    RecState = case kz_account_doc_field([<<"preflow">>,<<"always">>],Context) of
        'undefined' -> [];
        [] -> [];
        <<>> -> [];
        Value -> Value
    end,
    case RecState of
        [] ->
            kz_set_acc_doc([<<"preflow">>,<<"always">>], record_call_doc_id(Context), Context);
        _ ->
            kz_set_acc_doc([<<"preflow">>,<<"always">>], <<>>, Context)
    end.

record_call_doc_id(Context) ->
    Cfs = kz_list_account_callflows(Context),
    case lists:filter(fun(X) -> [<<"record_call">>] =:= modkazoo_util:get_value(<<"numbers">>,X) end, Cfs) of
        [] ->
            _ = create_record_call_callflow(Context),
            NewCf = lists:filter(fun(X) -> [<<"record_call">>] =:= modkazoo_util:get_value(<<"numbers">>,X) end, Cfs),
            modkazoo_util:get_value(<<"id">>,NewCf);
        [Cf|_] -> 
            modkazoo_util:get_value(<<"id">>,Cf)
    end.

create_record_call_callflow(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"name">>], <<"record_call">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"record_call">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"contact_list">>, <<"exclude">>], true, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"module">>], <<"record_call">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"action">>], <<"start">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"url">>], <<>>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"format">>], <<"mp3">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"time_limit">>], <<"6000">>, J) end],
    DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, ?EMPTY_CALLFLOW, Routines)),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CALLFLOWS/binary>>,
    crossbar_account_request('put', API_String, DataBag, Context).

kz_cccp_creds_list(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CCCPS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

add_cccp_doc(Field1, Field2, Field3, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CCCPS/binary>>,
    DataBag = {[{<<"data">>, {[Field1, Field2, Field3, {<<"active">>, true}]}}]},
    crossbar_account_request('put', API_String, DataBag, Context).

add_cccp_autodial(ALegNumber, BLegNumber, OutboundCID, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CCCPS/binary, ?AUTODIAL/binary>>,
    DataBag = ?MK_DATABAG({[{<<"a_leg_number">>, z_convert:to_binary(ALegNumber)}
               ,{<<"b_leg_number">>, z_convert:to_binary(BLegNumber)}
               ,{<<"outbound_cid">>, z_convert:to_binary(OutboundCID)}
               ,{<<"callback_delay">>, 1}]}),
    crossbar_account_request('put', API_String, DataBag, Context).

del_cccp_doc(DocId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?CCCPS/binary, <<"/">>/binary, (z_convert:to_binary(DocId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_find_account_by_number(Number, Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, Account_Id/binary, ?PHONE_NUMBERS/binary, <<"/">>/binary, (z_convert:to_binary(Number))/binary, ?IDENTIFY/binary>>,
    modkazoo_util:get_value(<<"account_id">>, crossbar_account_request('get', API_String, [], Context)).

kz_admin_find_accountname_by_number(Number, Context) ->
    modkazoo_util:get_value(<<"name">>,kz_adminget_acc_doc_by_account_id(kz_admin_get_account_by_number(Number, Context),Context)).

kz_admin_get_account_by_number(Number, Context) ->
    {'ok', {'account_id', AccountId}, {'auth_token', AuthToken}, {'crossbar', CrossbarURL}} = kz_admin_creds(Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?PHONE_NUMBERS/binary, <<"/">>/binary, (z_convert:to_binary(Number))/binary, ?IDENTIFY/binary>>,
    URL = z_convert:to_list(<<CrossbarURL/binary, API_String/binary>>),
    {'ok', _, _, Body} = ibrowse:send_req(URL, req_headers(AuthToken), 'get', [], [], 10000),
    modkazoo_util:get_value([<<"data">>,<<"account_id">>], jiffy:decode(Body)).

list_account_trunks(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    list_account_trunks(AccountId, Context).

list_account_trunks(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CONNECTIVITY/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_trunk_server(Context) ->
    TrunkId = case z_context:get_q("trunk_id",Context) of
             'undefined' ->
                 case list_account_trunks(Context) of
                     [] ->
                         DataBag = ?MK_DATABAG({[{<<"account">>,
                                                  {[{<<"credits">>,{[{<<"prepay">>,<<"0.00">>}]}},
                                                    {<<"trunks">>,<<"0">>},
                                                    {<<"inbound_trunks">>,<<"0">>},
                                                    {<<"auth_realm">>,get_account_realm(Context)}]}},
                                                 {<<"servers">>,[]}]}),
                         _ = kz_trunk('put', <<>>, DataBag, Context),
                         [CreatedTrunkId|_] = list_account_trunks(Context),
                         CreatedTrunkId;
                     ExistingTrunkId -> ExistingTrunkId
                 end;
             ContextId -> ContextId
         end,
    CurrTrunkDoc = kz_trunk('get', TrunkId, [], Context),
    Servers = modkazoo_util:get_value(<<"servers">>, CurrTrunkDoc),
    NewServers = case z_context:get_q("server_index",Context) of
        'undefined' -> Servers ++ [update_trunk_server(?EMPTY_TS_SERVER, Context)];
        Ind ->
            Index = z_convert:to_integer(Ind),
            lists:sublist(Servers, Index-1) ++ [update_trunk_server(lists:nth(Index, Servers), Context)] ++ lists:nthtail(Index, Servers)
    end,
    NewTrunkDoc = modkazoo_util:set_value(<<"servers">>, NewServers, CurrTrunkDoc),
    kz_trunk('post', TrunkId, ?MK_DATABAG(NewTrunkDoc), Context).

kz_trunk_server_details('undefined', _, _) ->
    [];
kz_trunk_server_details(_, 'undefined', _) ->
    [];
kz_trunk_server_details(TrunkId, Index, Context) ->
    lists:nth(Index, modkazoo_util:get_value(<<"servers">>, kz_trunk('get', TrunkId, [], Context))).

kz_trunk_server_delete(TrunkId, Index, Context) ->
    CurrTrunkDoc = kz_trunk('get', TrunkId, [], Context),
    Servers = modkazoo_util:get_value(<<"servers">>, CurrTrunkDoc),
    NewServers = lists:sublist(Servers, Index-1) ++ lists:nthtail(Index, Servers),
    NewTrunkDoc = modkazoo_util:set_value(<<"servers">>, NewServers, CurrTrunkDoc),
    kz_trunk('post', TrunkId, ?MK_DATABAG(NewTrunkDoc), Context).

kz_trunk_server_numbers(Context) ->
    case z_context:get_q("trunk_id",Context) of
        'undefined' -> ok;
        TrunkId ->
            TS_Numbers = case z_context:get_q_all("ts_number",Context) of
                [] -> {[]};
                NumbersList -> ?JSON_WRAPPER(lists:map(fun(Number) -> {z_convert:to_binary(Number), ?EMPTY_JSON_OBJECT} end, NumbersList))
            end,
            Index = z_convert:to_integer(z_context:get_q("server_index",Context)),
            CurrTrunkDoc = kz_trunk('get', TrunkId, [], Context),
            Servers = modkazoo_util:get_value(<<"servers">>, CurrTrunkDoc),
            NewServers = lists:sublist(Servers, Index-1) ++ [modkazoo_util:set_value(<<"DIDs">>, TS_Numbers, lists:nth(Index, Servers))] ++ lists:nthtail(Index, Servers),
            NewTrunkDoc = modkazoo_util:set_value(<<"servers">>, NewServers, CurrTrunkDoc),
            kz_trunk('post', TrunkId, ?MK_DATABAG(NewTrunkDoc), Context)
    end.

kz_trunk(Verb, TrunkId, DataBag, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_trunk(Verb, TrunkId, AccountId, DataBag, Context).

kz_trunk(Verb, TrunkId, AccountId, DataBag, Context) ->
    case Verb of
        'get' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CONNECTIVITY/binary, <<"/">>/binary, (z_convert:to_binary(TrunkId))/binary>>,
            crossbar_account_request(Verb, API_String, [], Context);
        'put' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CONNECTIVITY/binary>>,
            crossbar_account_request(Verb, API_String, DataBag, Context);
        'post' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CONNECTIVITY/binary, <<"/">>/binary, (z_convert:to_binary(TrunkId))/binary>>,
            crossbar_account_request(Verb, API_String, DataBag, Context);
        _ -> 'ok'
    end.

get_trunk_doc_field(K, TrunkId, AccountId, Context) ->
    modkazoo_util:get_value(K, kz_trunk('get', TrunkId, AccountId, [], Context)).

set_trunk_doc_field(K, V, TrunkId, AccountId, Context) ->
    TrunkDoc = kz_trunk('get', TrunkId, AccountId, [], Context),
    kz_trunk('post', TrunkId, AccountId, ?MK_DATABAG(modkazoo_util:set_value(K, V, TrunkDoc)), Context).

list_trunks_realm(AccountId, Context) ->
    [get_trunk_doc_field([<<"account">>,<<"auth_realm">>], TrunkId, AccountId, Context) || TrunkId <- list_account_trunks(AccountId, Context)].

sync_trunkstore_realm(TrunkId, AccountId, Context) ->
    AccountRealm = kazoo_util:get_account_realm(AccountId, Context),
    set_trunk_doc_field([<<"account">>,<<"auth_realm">>], AccountRealm, TrunkId, AccountId, Context).

sync_trunkstore_realms(AccountId, Context) ->
    AccountRealm = get_account_realm(AccountId, Context),
    [sync_trunkstore_realm(TrunkId, AccountId, Context) || TrunkId <- list_account_trunks(AccountId, Context)
                                                          ,get_trunk_doc_field([<<"account">>,<<"auth_realm">>], TrunkId, AccountId, Context) =/= AccountRealm].

ts_trunk_disable(Ind, TrunkId, Context) ->
    ts_server_set_field([<<"options">>,<<"enabled">>], 'false', Ind, TrunkId, Context).

ts_trunk_enable(Ind, TrunkId, Context) ->
    ts_server_set_field([<<"options">>,<<"enabled">>], 'true', Ind, TrunkId, Context).

ts_server_set_field(K, V, Ind, TrunkId, Context) ->
    Index = z_convert:to_integer(Ind),
    CurrTrunkDoc = kz_trunk('get', TrunkId, [], Context),
    Servers = modkazoo_util:get_value(<<"servers">>, CurrTrunkDoc),
    NewServers = lists:sublist(Servers, Index-1) ++ [modkazoo_util:set_value(K, V, lists:nth(Index, Servers))] ++ lists:nthtail(Index, Servers),
    NewTrunkDoc = modkazoo_util:set_value(<<"servers">>, NewServers, CurrTrunkDoc),
    kz_trunk('post', TrunkId, ?MK_DATABAG(NewTrunkDoc), Context).

update_trunk_server(Server, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"options">>,<<"enabled">>], 'true', J) end
                ,fun(J) -> modkazoo_util:set_value([<<"options">>,<<"inbound_format">>], z_convert:to_binary(z_context:get_q("inbound_format",Context)), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"auth">>,<<"auth_method">>], z_convert:to_binary(z_context:get_q("auth_method",Context)), J) end
                ,fun(J) -> case z_context:get_q("auth_user",Context) of 'undefined' -> J; User -> modkazoo_util:set_value([<<"auth">>,<<"auth_user">>], z_convert:to_binary(User), J) end end
                ,fun(J) -> case z_context:get_q("auth_password",Context) of 'undefined' -> J; Pwd -> modkazoo_util:set_value([<<"auth">>,<<"auth_password">>], z_convert:to_binary(Pwd), J) end end
                ,fun(J) -> case z_context:get_q("ipaddress",Context) of 'undefined' -> J; Ip -> modkazoo_util:set_value([<<"auth">>,<<"ip">>], z_convert:to_binary(Ip), J) end end
                ,fun(J) -> case z_context:get_q("ipaddress",Context) of 'undefined' -> J; Ip -> modkazoo_util:set_value([<<"options">>,<<"ip">>], z_convert:to_binary(Ip), J) end end
                ,fun(J) -> modkazoo_util:set_value([<<"server_name">>], z_convert:to_binary(z_context:get_q("server_name",Context)), J) end],
    lists:foldl(fun(F, J) -> F(J) end, Server, Routines).

kz_list_account_webhooks(Context) ->
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?WEBHOOKS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_webhook_info(WebhookId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?WEBHOOKS/binary, <<"/">>/binary, (z_convert:to_binary(WebhookId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_webhook_delete(WebhookId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?WEBHOOKS/binary, <<"/">>/binary, (z_convert:to_binary(WebhookId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_webhook_toggle(WebhookId, Context) ->
    CurrDoc = kz_webhook_info(WebhookId, Context),
    NewDoc = case modkazoo_util:get_value(<<"enabled">>, CurrDoc) of
        'true' -> modkazoo_util:set_value(<<"enabled">>, 'false', CurrDoc);
        'false' -> modkazoo_util:set_value(<<"enabled">>, 'true', CurrDoc)
    end,
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(z_context:get_session('kazoo_account_id', Context)))/binary, ?WEBHOOKS/binary
                                                                                                          ,<<"/">>/binary, (z_convert:to_binary(WebhookId))/binary>>,
    crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context).

kz_webhook(Context) ->
    CurrDoc = case z_context:get_q("webhook_id", Context) of
        'undefined' -> ?EMPTY_JSON_OBJECT;
         WebhookId -> kz_webhook_info(WebhookId, Context)
    end,
    Routines = [fun(J) -> modkazoo_util:set_value(<<"name">>, modkazoo_util:get_q_bin("name",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"hook">>, modkazoo_util:get_q_bin("hook",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"enabled">>, modkazoo_util:get_q_atom("enabled",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"http_verb">>, modkazoo_util:get_q_bin("http_verb",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"retries">>, modkazoo_util:get_q_integer("retries",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"uri">>, modkazoo_util:get_q_bin("uri",Context), J) end
               ] ++ [filter_custom_fields(Pair, Context) || Pair <- z_context:get_q_all(Context)],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, modkazoo_util:delete_key(<<"custom_data">>,CurrDoc), Routines),
    case z_context:get_q("webhook_id", Context) of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(z_context:get_session('kazoo_account_id', Context)))/binary, ?WEBHOOKS/binary>>,
            crossbar_account_request('put', API_String, ?MK_DATABAG(NewDoc), Context);
        Id ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(z_context:get_session('kazoo_account_id', Context)))/binary, ?WEBHOOKS/binary
                                                                                                          ,<<"/">>/binary, (z_convert:to_binary(Id))/binary>>,
            crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context)
    end.

filter_custom_fields({"custom_key_" ++ T, Key}, Context) ->
    fun(J) -> modkazoo_util:set_value([<<"custom_data">>,z_convert:to_binary(Key)], modkazoo_util:get_q_bin(T,Context), J) end;
filter_custom_fields(_, _Context) ->
    fun(J) -> J end.

kz_current_context_reseller(Context) ->
    modkazoo_util:get_value(<<"is_reseller">>, kazoo_util:kz_get_acc_doc(Context)).

kz_current_context_reseller_id(Context) ->
    modkazoo_util:get_value(<<"reseller_id">>, kazoo_util:kz_get_acc_doc(Context)).

kz_current_context_superadmin(Context) ->
    modkazoo_util:get_value(<<"superduper_admin">>, kazoo_util:kz_get_acc_doc(Context)).

kz_callflows_numbers(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_callflows_numbers(AccountId, Context).

kz_callflows_numbers(AccountId, Context) ->
    lists:foldl(fun(X,Acc) -> modkazoo_util:get_value([<<"numbers">>],X) ++ Acc end, [], kz_list_account_callflows(AccountId, Context)).

kz_spare_numbers(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_spare_numbers(AccountId, Context).

kz_spare_numbers(AccountId, Context) ->
    UsedNumbers = kz_callflows_numbers(AccountId, Context),
    lists:filter(fun(X) -> 'true' =/= lists:member(X, UsedNumbers) end, kz_account_numbers(AccountId, Context)).

kz_callflow_by_number(Number, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_callflow_by_number(Number, AccountId, Context).

kz_callflow_by_number(Number, AccountId, Context) ->
    case lists:filter(fun(X) -> modkazoo_util:get_value([<<"numbers">>],X) == [Number] end, kz_list_account_callflows(AccountId, Context)) of
        [CF|_] -> kz_get_account_callflow(modkazoo_util:get_value(<<"id">>, CF), AccountId, Context);
        _ -> ?EMPTY_JSON_OBJECT
    end.

set_global_carrier_routing(AccountId, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>], ?EMPTY_JSON_OBJECT, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"module">>], <<"offnet">>, J) end],
    set_no_match_routing(Routines, AccountId, Context).

set_reseller_based_routing(ResellerId, AccountId, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"hunt_account_id">>], ResellerId, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"module">>], <<"resources">>, J) end],
    set_no_match_routing(Routines, AccountId, Context).

set_account_based_routing(AccountId, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>], ?EMPTY_JSON_OBJECT, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"module">>], <<"resources">>, J) end],
    set_no_match_routing(Routines, AccountId, Context).

set_no_match_routing(Routines, AccountId, Context) ->
    CurrDoc = kz_callflow_by_number(<<"no_match">>, AccountId, Context),
    DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, CurrDoc, Routines)),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?CALLFLOWS/binary, <<"/">>/binary, (modkazoo_util:get_value(<<"id">>, CurrDoc))/binary>>,
    crossbar_account_request('post', API_String, DataBag, Context).

kz_list_account_resources(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary>>
    end,
    crossbar_account_request('get', API_String, [], Context).
    
kz_resource_info(ResourceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_resource_info(ResourceId, AccountId, Context).

kz_resource_info(ResourceId, AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>
    end,
    crossbar_account_request('get', API_String, [], Context).
    
kz_resource_delete(ResourceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_resource_delete(ResourceId, AccountId, Context).

kz_resource_delete(ResourceId, AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>
    end,
    crossbar_account_request('delete', API_String, [], Context).

toggle_resource(ResourceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    toggle_resource(ResourceId, AccountId, Context).

toggle_resource(ResourceId, AccountId, Context) ->
    CurrDoc = kz_resource_info(ResourceId, AccountId, Context),
    NewDoc = case modkazoo_util:get_value(<<"enabled">>, CurrDoc) of
        'false' -> modkazoo_util:set_value(<<"enabled">>, 'true', CurrDoc);
        'true' -> modkazoo_util:set_value(<<"enabled">>, 'false', CurrDoc)
    end,
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>
    end,
    crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context).
    
resource(Context) ->
    ResourceId = modkazoo_util:get_q_bin("resource_id",Context),
    PropsGateway = modkazoo_util:filter_empty(
        [{[<<"server">>],modkazoo_util:get_q_bin("server",Context)}
        ,{<<"port">>,modkazoo_util:get_q_bin("port",Context)}
        ,{<<"username">>,modkazoo_util:get_q_bin("username",Context)}
        ,{<<"password">>,modkazoo_util:get_q_bin("password",Context)}
        ,{<<"prefix">>,modkazoo_util:get_q_bin("prefix",Context)}
        ,{<<"suffix">>,modkazoo_util:get_q_bin("suffix",Context)}
        ,{<<"progress_timeout">>,modkazoo_util:get_q_bin("progress_timeout",Context)}
        ,{<<"realm">>,modkazoo_util:get_q_bin("realm",Context)}
        ,{<<"format_from_uri">>,modkazoo_util:on_to_true(z_context:get_q("format_from_uri",Context))}
        ,{<<"codecs">>,lists:foldl(fun(Codec,J) -> case Codec of [] -> J; _ -> J ++ [z_convert:to_binary(Codec)] end end, [], z_context:get_q_all("codecs",Context))}
        ]),
    PropsResource = modkazoo_util:filter_empty(
        [{<<"name">>,modkazoo_util:get_q_bin("name",Context)}
        ,{<<"weight_cost">>,modkazoo_util:get_q_bin("weight_cost",Context)}
        ,{[<<"caller_id_options">>,<<"type">>],modkazoo_util:get_q_bin("caller_id_options_type",Context)}]) ++
        [{<<"rules">>,case modkazoo_util:get_q_bin("rules",Context) of <<>> -> ?DEFAULT_RESOURCE_RULES; Rules -> [Rules] end}
        ,{<<"cid_rules">>,case modkazoo_util:get_q_bin("cid_rules",Context) of <<>> -> ?DEFAULT_RESOURCE_CIDRULES; Rules -> [Rules] end}
        ,{<<"flags">>,case z_context:get_q("flags", Context) of
                          'undefined' -> [];
                          [] -> [];
                           Flags -> lists:map(fun (K) -> re:replace(K, "[^A-Za-z0-9]", "", [global, {return, binary}]) end, z_string:split(Flags,","))
                      end
         }
        ],
    [Gateway, Resource] = case ResourceId of
        <<>> ->
            [CurrGateway|_] = modkazoo_util:get_value(<<"gateways">>,?EMPTY_RESOURCE),
            [lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, CurrGateway, PropsGateway),
             lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, ?EMPTY_RESOURCE, PropsResource)];
        _ ->
            CurrResource = kz_resource_info(ResourceId, Context),
            [CurrGateway|_] = modkazoo_util:get_value(<<"gateways">>,CurrResource),
            [lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, CurrGateway, PropsGateway),
             lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, CurrResource, PropsResource)]
    end,
    DataBag = ?MK_DATABAG(modkazoo_util:set_value(<<"gateways">>,[Gateway],Resource)),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case ResourceId of
        <<>> ->
            API_String = case kz_current_context_superadmin(Context) of
                'true' -> <<?V2/binary, ?RESOURCES/binary>>; 
                'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary>>
            end,
            _ = crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = case kz_current_context_superadmin(Context) of
                'true' -> <<?V2/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>; 
                'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, <<"/">>/binary, (z_convert:to_binary(ResourceId, Context))/binary>>
            end,
            _ = crossbar_account_request('post', API_String, DataBag, Context)
    end.

super_account_id(Context) ->
    case z_context:get_session('super_account_id', Context) of
        'undefined' ->
            {'ok', {'account_id', SuperAccountId}, {'auth_token', _}, {'crossbar', _}} = kazoo_util:kz_admin_creds(Context),
            z_context:set_session('super_account_id', SuperAccountId, Context),
            SuperAccountId;
        AccountId ->
             AccountId
    end.

kz_list_account_notifications(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary>>
    end,
    crossbar_account_request('get', API_String, [], Context).

kz_notification_info(NotificationId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_notification_info(NotificationId, AccountId, Context).

kz_notification_info(NotificationId, AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>
    end,
    crossbar_account_request('get', API_String, [], Context).

kz_delete_notification_template(NotificationId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_notification_template(ContextType, NotificationId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_notification_template(ContextType, NotificationId, AccountId, Context).

kz_notification_template(ContextType, NotificationId, AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>
    end,
    crossbar_account_send_raw_request_body('get', API_String, [{"Accept", ContextType}], [], Context).

kz_save_notification_template(ContextType, NotificationId, AccountId, MessageBody, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>
    end,
    crossbar_account_send_request('post', API_String, ContextType, MessageBody, Context).

kz_list_account_lists(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

account_list(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    ListId = z_context:get_q("list_id", Context),
    CurrDoc = case ListId of
        'undefined' -> ?EMPTY_JSON_OBJECT;
         _ -> kz_get_account_list(ListId, Context)
    end,
    Routines = [fun(J) -> modkazoo_util:set_value(<<"name">>, modkazoo_util:get_q_bin("list_name",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"description">>, modkazoo_util:get_q_bin("list_description",Context), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"list_type">>, modkazoo_util:get_q_bin("list_type",Context), J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrDoc, Routines),
    case ListId of
        'undefined' ->
            API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary>>,
            crossbar_account_request('put', API_String, ?MK_DATABAG(NewDoc), Context);
        _ ->
            API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary>>,
            crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context)
    end.

delete_account_list(ListId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

delete_account_list_entry(EntryId, ListId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary,
                                                                   ?ENTRIES/binary, <<"/">>/binary, (z_convert:to_binary(EntryId, Context))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_get_account_list(ListId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_list_entries(ListId,Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary, ?ENTRIES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_account_list_add_entry(ListType, ListId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    EntryId = z_context:get_q("entry_id", Context),
    CurrDoc = case EntryId of
        'undefined' -> ?EMPTY_JSON_OBJECT;
         _ -> kz_get_account_list_entry(EntryId, ListId, Context)
    end,
    Routines = list_routines(ListType, Context),
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrDoc, Routines),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary, ?ENTRIES/binary>>,
    case EntryId of
        'undefined' ->
            API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary, ?ENTRIES/binary>>,
            crossbar_account_request('put', API_String, ?MK_DATABAG(NewDoc), Context);
        _ ->
            API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?LISTS/binary, <<"/">>/binary, (z_convert:to_binary(ListId, Context))/binary,
                                                                           ?ENTRIES/binary, <<"/">>/binary, (z_convert:to_binary(EntryId, Context))/binary>>,
            crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context)
    end.

list_routines(<<"phone_book">>, Context) ->
    [fun(J) -> modkazoo_util:set_value(<<"number">>, re:replace(z_context:get_q("list_entry_number", Context), "[^0-9]", "", [global, {return, binary}]), J) end
     ,fun(J) -> modkazoo_util:set_value(<<"displayname">>, modkazoo_util:get_q_bin("list_entry_displayname",Context), J) end
    ];
list_routines(<<"dynamic_cid">>, Context) ->
    [fun(J) -> modkazoo_util:set_value(<<"cid_key">>, modkazoo_util:get_q_bin("cid_key", Context), J) end
     ,fun(J) -> modkazoo_util:set_value(<<"cid_name">>, modkazoo_util:get_q_bin("cid_name",Context), J) end
     ,fun(J) -> modkazoo_util:set_value(<<"cid_number">>, modkazoo_util:get_q_bin("cid_number",Context), J) end
    ];
list_routines(_, Context) ->
    list_routines(<<"phone_book">>, Context).

kz_get_account_list_entry(_EntryId, _ListId, _Context) ->
    ?EMPTY_JSON_OBJECT.

sendmail_test_notification(Email, AccountId, NotificationId, Context) ->
    CurrNotifyDoc = kz_notification_info(NotificationId, Context),
    Plain = z_convert:to_binary(kz_notification_template("text/plain", NotificationId, AccountId, Context)),
    HTML = kz_notification_template("text/html", NotificationId, AccountId, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"to">>,<<"email_addresses">>], [z_convert:to_binary(Email)], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"to">>,<<"type">>], <<"specified">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"template_charset">>], <<"utf-8">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"enabled">>], 'true', J) end
                ,fun(J) -> modkazoo_util:set_value(<<"from">>, z_convert:to_binary(Email), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"reply_to">>, z_convert:to_binary(Email), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"plain">>, Plain, J) end
                ,fun(J) -> modkazoo_util:set_value(<<"html">>, base64:encode(HTML), J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrNotifyDoc, Routines),
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary, ?PREVIEW/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary, ?PREVIEW/binary>>
    end,
    _ = crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            _ = kz_save_notification_template("text/html", NotificationId, AccountId, HTML, Context),
            _ = kz_save_notification_template("text/plain", NotificationId, AccountId, Plain, Context);
        _ -> 'ok'
    end.

notifications_smtplog(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, ?SMTPLOG/binary>>,
    {'ok', _, _, Body} = crossbar_account_send_request('get', API_String, "text/plain", [], Context),
    modkazoo_util:get_value(<<"data">>,jiffy:decode(Body)). 

kz_notifications(Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    NotificationId = z_context:get_q("notification_id", Context),
    CurrNotifyDoc = kz_notification_info(NotificationId, Context),
    Plain = z_convert:to_binary(kz_notification_template("text/plain", NotificationId, AccountId, Context)),
    HTML = kz_notification_template("text/html", NotificationId, AccountId, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"to">>,<<"email_addresses">>], emails_list("input_to", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"to">>,<<"type">>], modkazoo_util:get_q_bin("to", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"cc">>,<<"email_addresses">>], emails_list("input_cc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"cc">>,<<"type">>], modkazoo_util:get_q_bin("cc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"bcc">>,<<"email_addresses">>], emails_list("input_bcc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"bcc">>,<<"type">>], modkazoo_util:get_q_bin("bcc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"from">>], modkazoo_util:get_q_bin("from", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"subject">>], modkazoo_util:get_q_bin("subject", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"template_charset">>], <<"utf-8">>, J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrNotifyDoc, Routines),
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>
    end,
    _ = crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            _ = kz_save_notification_template("text/html", NotificationId, AccountId, HTML, Context),
            _ = kz_save_notification_template("text/plain", NotificationId, AccountId, Plain, Context);
        _ -> 'ok'
    end.

emails_list(Field, Context) ->
    case z_context:get_q(Field, Context) of
        'undefined' -> [];
        List -> lists:map(fun (K) -> re:replace(K, "[^A-Za-z0-9@_.-]", "", [global, {return, binary}]) end, z_string:split(List,","))
    end.

kz_notification_toggle(State, NotificationId, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    CurrNotifyDoc = kz_notification_info(NotificationId, Context),
    Plain = z_convert:to_binary(kz_notification_template("text/plain", NotificationId, AccountId, Context)),
    HTML = kz_notification_template("text/html", NotificationId, AccountId, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"enabled">>], State, J) end],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrNotifyDoc, Routines),
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>
    end,
    _ = crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            _ = kz_save_notification_template("text/html", NotificationId, AccountId, HTML, Context),
            _ = kz_save_notification_template("text/plain", NotificationId, AccountId, Plain, Context);
        _ -> 'ok'
    end.
