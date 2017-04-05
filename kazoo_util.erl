-module(kazoo_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([kz_admin_creds/1
    ,kz_user_creds/3
    ,kz_user_creds/4
    ,kz_api_key_creds/2
    ,crossbar_admin_request/4
    ,crossbar_admin_request/5
    ,crossbar_account_request/4
    ,crossbar_account_send_raw_request/5
    ,crossbar_account_send_raw_request_body/5
    ,crossbar_account_send_raw_request_body/6
    ,crossbar_noauth_request_raw/4
    ,crossbar_noauth_request/4
    ,kz_get_acc_doc/1
    ,kz_get_acc_doc_by_account_id/2
    ,kz_get_acc_doc_by_account_id_and_authtoken/3
    ,kz_account_doc_field/2
    ,kz_account_doc_field/3
    ,kz_get_user_doc/1
    ,kz_get_user_doc/2
    ,kz_get_user_doc/3
    ,kz_get_user_doc_by_authtoken/4
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
    ,kz_list_account_cdr/5
    ,kz_list_account_cdr_page/3
    ,kz_list_account_cdr_reduced/3
    ,kz_list_user_cdr/3
    ,kz_list_user_cdr_reduced/3
    ,kz_fetch_cdr_details/2
    ,kz_cdr_legs/2
    ,kz_cdr_legs_localized/2
    ,kz_cdr_list_reduce/2
    ,kz_list_account_children/1
    ,kz_list_account_channels/1
    ,kz_list_account_channels/2
    ,kz_get_reseller_channels/2
    ,kz_channel_info/2
    ,kz_channel_info/3
    ,kz_channel_action/3
    ,kz_channel_action/4
    ,kz_channel_hangup/3
    ,kz_channel_transfer/4
    ,kz_channel_eavesdrop/5
    ,kz_list_user_devices/1
    ,kz_list_user_devices/2
    ,kz_get_device_doc/2
    ,kz_set_device_doc/4
    ,kz_list_account_vmboxes/1
    ,kz_list_user_vmboxes/1
    ,kz_list_user_vmbox_details/2
    ,kz_list_user_vmbox_messages/2
    ,kz_purge_voicemails/3
    ,kz_purge_voicemail/4
    ,kz_vmessage_download_link/3
    ,is_kazoo_account_admin/1
    ,set_vm_message_folder/4
    ,password_recovery/3
    ,password_reset_submit/2
    ,growl_redirect/4
    ,change_credentials/4
    ,current_account_credit/1
    ,current_account_credit/2
    ,kz_check_device_registration/2
    ,kz_kzattachment_link/5
    ,call_recording_attachment/4
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
    ,phone_number/2
    ,phone_number/5
    ,kz_account_numbers_info/1
    ,kz_account_numbers_info/2
    ,account_numbers_fix/2
    ,account_numbers_fix_plus/2
    ,kz_send_fax/7
    ,kz_list_outgoing_faxes/1
    ,kz_list_ledgers/5
    ,kz_ledgers_summary/4
    ,kz_list_transactions/1
    ,kz_list_transactions/2
    ,kz_list_transactions/3
    ,kz_list_transactions/4
    ,kz_list_transactions/5
    ,kz_bt_transactions/1
    ,kz_list_subscriptions/1
    ,kz_list_subscriptions/2
    ,kz_current_balance/2
    ,kz_transactions_credit/6
    ,kz_transactions_debit/5
    ,kz_get_subscription/2
    ,kz_bt_customer/1
    ,bt_delete_card/2
    ,make_payment/3
    ,topup_submit/4
    ,topup_disable/2
    ,kz_set_user_doc/3
    ,kz_set_user_doc/4
    ,kz_set_user_doc/6
    ,kz_toggle_account_doc/2
    ,kz_toggle_account_doc/3
    ,kz_toggle_user_doc/2
    ,kz_toggle_user_doc/3
    ,kz_toggle_device_doc/3
    ,kz_set_acc_doc/3
    ,kz_set_acc_doc/4
    ,trigger_innoui_widget/2
    ,ui_element_state/2
    ,lookup_numbers/3
    ,rs_add_number/3
    ,purchase_numbers/3
    ,deallocate_number/2
    ,deallocate_number/3
    ,service_plan/2
    ,service_plan/3
    ,service_plan/5
    ,service_plans/1
    ,service_plans/2
    ,available_service_plans/1
    ,available_service_plans/2
    ,current_service_plans/1
    ,current_service_plans/2
    ,sync_service_plans/2
    ,reconcile_service_plans/2
    ,add_service_plan/3
    ,admin_add_service_plan/3
    ,remove_service_plan_from_account/3
    ,valid_card_exists/1
    ,is_creditable/1
    ,process_purchase_numbers/3
    ,get_account_timezone/1
    ,get_user_timezone/1
    ,may_be_get_timezone/1
    ,is_service_plan_applied/1
    ,get_account_name/1
    ,get_account_name/2
    ,get_account_realm/1
    ,get_account_realm/2
    ,delete_account/2
    ,delete_user/2
    ,delete_device/2
    ,classify_number/2
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
    ,cf_notes_number_action/3
    ,cf_notes_get/2
    ,cf_notes_flush/1
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
    ,vmbox_messages/3
    ,vmbox_message/4
    ,kz_conference/1
    ,kz_conference/3
    ,kz_conference_participant/3
    ,kz_conference_participants/2
    ,dedup_kz_conference_participants/2
    ,kz_c2call/1
    ,kz_c2call/3
    ,kz_c2call_hyperlink/2
    ,start_outbound_conference/1
    ,add_conf_participant/1
    ,do_conference_action/3
    ,do_conference_participant_action/4
    ,maybe_update_conference_participants_headline/3
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
    ,set_featurecode_eavesdrop/3
    ,delete_featurecode/2
    ,toggle_blacklist_member/2
    ,kz_get_account_blacklist/2
    ,set_blacklist_doc/4
    ,kz_delete_blacklist/2
    ,may_be_check_cid_children_clean/1
    ,rs_delete_account/2
    ,toggle_all_calls_recording/1
    ,kz_cccp_creds_list/1
    ,add_cccp_doc/3
    ,add_cccp_autodial/5
    ,del_cccp_doc/2
    ,cccp_field_toggler/3
    ,kz_find_account_by_number/2
    ,kz_admin_find_accountname_by_number/2
    ,kz_admin_get_account_by_number/2
    ,kz_get_registrations_by_accountid/2
    ,kz_get_registrations_count_by_accountid/2
    ,kz_get_reseller_registrations/2
    ,kz_get_reseller_registrations_count/2
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
    ,kz_current_context_reseller_status/1
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
    ,notifications_smtplog_by_id/2
    ,kz_notifications/1
    ,kz_notification_toggle/3
    ,rs_kz_customer_update/3
    ,rs_kz_all_customers_update/2
    ,list_system_dialplans/1
    ,list_system_dialplans_names/1
    ,kz_toggle_reseller_status/2
    ,kz_toggle_account_status/2
    ,per_minute_calls/1
    ,credit_transactions/1
    ,debit_transactions/1
    ,kz_account_access_lists/3
    ,kz_device_access_lists/4
    ,kz_limits/4
    ,save_trunks_limits/5
    ,kz_allotments/4
    ,kz_allotments_consumed/4
    ,allotment_element_delete/3
    ,allotment_element_add/3
    ,allotment_element_set_field/5
    ,set_e911_number_service/4
    ,remove_e911_number_service/3
    ,is_trial_account/1
    ,is_trial_account/2
    ,services_status/4
    ,toggle_services_status/2
    ,all_tasks/1
    ,account_tasks/4
    ,account_tasks/5
    ,get_tasks_csv/4
    ,account_task/5
    ,add_new_task/1
    ,add_new_task_file/3
    ,metaflows/4
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

%% Define API calls
-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(API_AUTH, <<"/api_auth">>).
-define(USER_AUTH, <<"/user_auth">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ACCOUNTS(Context), <<"/accounts/", (z_context:get_session('kazoo_account_id', Context))/binary>>).
-define(PHONE_NUMBERS, <<"/phone_numbers">>).
-define(FIX, <<"/fix">>).
-define(IDENTIFY, <<"/identify">>).
-define(REGISTRATIONS, <<"/registrations">>).
-define(COUNT, <<"/count">>).
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
-define(DEVICES(DeviceId), <<"/devices/", (z_convert:to_binary(DeviceId))/binary>>).
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
-define(RECORDINGS, <<"/recordings">>).
-define(NUMBER, <<"/number">>).
-define(CUSTOMER, <<"/customer">>).
-define(TRANSACTIONS, <<"/transactions">>).
-define(SUBSCRIPTIONS, <<"/subscriptions">>).
-define(CREDIT, <<"/credit">>).
-define(DEBIT, <<"/debit">>).
-define(CARDS, <<"/cards">>).
-define(COUNTRY, <<"country=">>).
-define(PREFIX, <<"prefix=">>).
-define(QUANTITY, <<"quantity=">>).
-define(COLLECTION, <<"/collection">>).
-define(RESERVE, <<"/reserve">>).
-define(ACTIVATE, <<"/activate">>).
-define(SERVICE_PLANS, <<"/service_plans">>).
-define(CURRENT, <<"/current">>).
-define(GROUPS, <<"/groups">>).
-define(CHANNELS, <<"/channels">>).
-define(MEDIA, <<"/media">>).
-define(MENUS, <<"/menus">>).
-define(TEMPORAL_RULES, <<"/temporal_rules">>).
-define(CONFERENCES, <<"/conferences">>).
-define(PARTICIPANTS, <<"/participants">>).
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
-define(CUSTOMER_UPDATE, <<"/customer_update">>).
-define(PREVIEW, <<"/preview">>).
-define(SMTPLOG, <<"/smtplog">>).
-define(QUEUES, <<"/queues">>).
-define(EAVESDROP, <<"/eavesdrop">>).
-define(CLICKTOCALL, <<"/clicktocall">>).
-define(DIALPLANS, <<"/dialplans">>).
-define(MESSAGE, <<"/message">>).
-define(RESELLER, <<"/reseller">>).
-define(CURRENT_BALANCE, <<"/current_balance">>).
-define(AVAILABLE, <<"/available">>).
-define(SYNCHRONIZATION, <<"/synchronization">>).
-define(RECONCILIATION, <<"/reconciliation">>).
-define(INTERACTION, <<"/interaction">>).
-define(LEGS, <<"/legs">>).
-define(LEDGERS, <<"/ledgers">>).
-define(ACCESS_LISTS, <<"/access_lists">>).
-define(LIMITS, <<"/limits">>).
-define(ALLOTMENTS, <<"/allotments">>).
-define(CONSUMED, <<"/consumed">>).
-define(SERVICES, <<"/services">>).
-define(TASKS, <<"/tasks">>).
-define(METAFLOWS, <<"/metaflows">>).

-define(MK_TIME_FILTER(CreatedFrom, CreatedTo), <<?CREATED_FROM/binary, CreatedFrom/binary, <<"&">>/binary, ?CREATED_TO/binary, CreatedTo/binary>>).
-define(SET_REASON(Reason), case Reason of 'undefined' -> <<>>; _ -> <<"&reason=", ?TO_BIN(Reason)/binary>> end).
-define(SET_ACCEPT_CHARGES(AcceptCharges, Doc), modkazoo_util:set_value(<<"accept_charges">>, AcceptCharges, ?MK_DATABAG(Doc))).

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

-define(DEFAULT_ALLOTMENTS,
{[{<<"amount">>, 600},
  {<<"cycle">>, <<"hourly">>},
  {<<"increment">>, 60},
  {<<"minimum">>, 60},
  {<<"no_consume_time">>, 0}
]}).

-define(CONFERENCE_ACTION(Action), {[{<<"action">>, ?TO_BIN(Action)}]}).
-define(MATCH_ACCOUNT_RAW(Account), <<(Account):32/binary>>).

kz_admin_creds(Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, ?V1/binary, ?API_AUTH/binary>>),
    API_Key = m_config:get_value('mod_kazoo', 'kazoo_super_duper_api_key', Context),
    DataBag = {[{<<"data">>, {[{<<"api_key">>, API_Key}]}}]},
    Payload = jiffy:encode(DataBag),

    {'ok', _, _, Body} = ibrowse:send_req(URL, req_headers('undefined'), 'put', Payload, [{'inactivity_timeout', 15000}]),

    {JsonData} = jiffy:decode(Body),
    {AccountData} = proplists:get_value(<<"data">>, JsonData),
    Account_Id = proplists:get_value(<<"account_id">>, AccountData),
    Auth_Token = proplists:get_value(<<"auth_token">>, JsonData),
    {'ok', {'account_id', Account_Id}, {'auth_token', Auth_Token}, {'crossbar', Crossbar_URL}}. 

kz_user_creds(Login, Password, AccountName, Context) ->
    Creds = io_lib:format("~s:~s", [Login, Password]),
    Md5Hash = iolist_to_binary([io_lib:format("~2.16.0b", [C]) || <<C>> <= erlang:md5(Creds)]),
    kz_user_creds(Md5Hash, AccountName, Context).

kz_user_creds(Md5Hash, AccountName, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, ?V1/binary, ?USER_AUTH/binary>>),
    DataBag = {[{<<"data">>, {[{<<"credentials">>, Md5Hash}, {<<"account_name">>, AccountName}]}}]},
    kz_creds(URL, DataBag, Context).

kz_api_key_creds(API_Key, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, ?V1/binary, ?API_AUTH/binary>>),
    DataBag = {[{<<"data">>, {[{<<"api_key">>, ?TO_BIN(API_Key)}]}}]},
    kz_creds(URL, DataBag, Context).

kz_creds(URL, DataBag, Context) ->
    try
        Payload = jiffy:encode(DataBag),
        case ibrowse:send_req(URL, req_headers('undefined'), 'put', Payload, [{'inactivity_timeout', 15000}]) of
            {'ok', [50,_,_], _, Body} ->
                JsonBody = jiffy:decode(Body),
                Owner_Id = modkazoo_util:get_value([<<"data">>, <<"owner_id">>], JsonBody),
                Account_Id = modkazoo_util:get_value([<<"data">>, <<"account_id">>], JsonBody),
                Account_Name = modkazoo_util:get_value([<<"data">>, <<"account_name">>], JsonBody),
                Auth_Token = modkazoo_util:get_value(<<"auth_token">>, JsonBody),
                Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
                {'ok' ,{'owner_id', Owner_Id}
                      ,{'account_id', Account_Id}
                      ,{'auth_token', Auth_Token}
                      ,{'crossbar', Crossbar_URL}
                      ,{'account_name', Account_Name}
                };
            {'ok', Code, _, Body} ->
                Data = modkazoo_util:get_value(<<"data">>, jiffy:decode(Body)),
                {'badauth', Code, Data}
        end
    catch
        _:_ -> <<"Auth exception">>
    end.

kz_get_acc_doc(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_get_acc_doc_by_account_id(AccountId, Context).

kz_get_acc_doc_by_account_id('undefined', _Context) ->
    <<>>;
kz_get_acc_doc_by_account_id(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_acc_doc_by_account_id_and_authtoken(AccountId, AuthToken, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary>>,
    crossbar_account_authtoken_request('get', API_String, [], AuthToken, Context, <<>>).

kz_adminget_acc_doc_by_account_id('undefined', _Context) ->
    <<>>;
kz_adminget_acc_doc_by_account_id(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary>>,
    {'ok', _, _, Body} = crossbar_admin_request('get', API_String, [], Context),
    modkazoo_util:get_value(<<"data">>, jiffy:decode(Body)).

kz_set_acc_doc(K, V, Context) ->
    kz_set_acc_doc(K, V, z_context:get_session('kazoo_account_id', Context), Context).

kz_set_acc_doc(["dial_plan","system"], V, AccountId, Context) ->
    kz_set_acc_doc([<<"dial_plan">>,<<"system">>], [?TO_BIN(V)], AccountId, Context);
kz_set_acc_doc(K, V, AccountId, Context) ->
    CurrDoc = kz_get_acc_doc_by_account_id(AccountId, Context),
    NewDoc = case V of
        'undefined' -> modkazoo_util:delete_key(K, CurrDoc);
         _ -> modkazoo_util:set_value(K, V, CurrDoc)
    end,
    case AccountId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary>>,
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
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    kz_get_user_doc_by_authtoken(OwnerId, AccountId, AuthToken, Context).

kz_get_user_doc_by_authtoken(OwnerId, AccountId, AuthToken, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?USERS/binary, "/", ?TO_BIN(OwnerId)/binary>>,
    case AccountId =:= 'undefined' orelse OwnerId =:= 'undefined' orelse OwnerId =:= 'null' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?USERS/binary, "/", ?TO_BIN(OwnerId)/binary>>,
            crossbar_account_authtoken_request('get', API_String, [], AuthToken, Context, <<>>);
        'true' -> []
    end.

kz_set_user_doc(K, V, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    kz_set_user_doc(K, V, OwnerId, Context).

kz_set_user_doc(["dial_plan","system"], V, OwnerId, Context) ->
    kz_set_user_doc([<<"dial_plan">>,<<"system">>], [?TO_BIN(V)], OwnerId, Context);
kz_set_user_doc(K, V, OwnerId, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_set_user_doc(K, V, OwnerId, AccountId, AuthToken, Context).

kz_set_user_doc(K, V, OwnerId, AccountId, AuthToken, Context) ->
    CurrDoc = kz_get_user_doc_by_authtoken(OwnerId, AccountId, AuthToken, Context),
    NewDoc = modkazoo_util:set_value(K, V, CurrDoc),
    case AccountId =:= 'undefined' orelse OwnerId =:= 'undefined' of
        'false' -> 
            API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?USERS/binary, "/", ?TO_BIN(OwnerId)/binary>>,
            crossbar_account_authtoken_request('post', API_String, {[{<<"data">>, NewDoc}]}, AuthToken, Context, <<>>);
        'true' -> []
    end.

kz_toggle_account_doc(K, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    kz_toggle_account_doc(K, AccountId, Context).

kz_toggle_account_doc(K, 'undefined', Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    kz_toggle_account_doc(K, AccountId, Context);
kz_toggle_account_doc(K, AccountId, Context) ->
    case kz_account_doc_field(K, AccountId, Context) of
        'true' -> kz_set_acc_doc(K, 'false', AccountId, Context);
        _ -> kz_set_acc_doc(K, 'true', AccountId, Context)
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
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary, "/", ?TO_BIN(DeviceId)/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

kz_set_device_doc(["dial_plan","system"], V, DeviceId, Context) ->
    kz_set_device_doc([<<"dial_plan">>,<<"system">>], [?TO_BIN(V)], DeviceId, Context);
kz_set_device_doc(["media","encryption","methods"], <<"No encryption">>, DeviceId, Context) ->
    kz_set_device_doc([<<"media">>,<<"encryption">>,<<"methods">>], [], DeviceId, Context);
kz_set_device_doc(["media","encryption","methods"], <<V/binary>>, DeviceId, Context) ->
  lager:info("IAM V: ~p",[V]),
    kz_set_device_doc([<<"media">>,<<"encryption">>,<<"methods">>], binary:split(V, <<",">>), DeviceId, Context);
kz_set_device_doc(K, V, DeviceId, Context) ->
    CurrDoc = kz_get_device_doc(DeviceId, Context),
    NewDoc = case V of
        'undefined' -> modkazoo_util:delete_key(K, CurrDoc);
         _ -> modkazoo_util:set_value(K, V, CurrDoc)
    end,
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    case Account_Id =:= 'undefined' orelse DeviceId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?DEVICES/binary, "/", ?TO_BIN(DeviceId)/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context);
        'true' -> []
    end.

crossbar_noauth_request_raw(Verb, API_String, DataBag, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, API_String/binary>>),
    Payload = case DataBag of
                  [] -> [];
                   _ -> jiffy:encode(DataBag)
              end,
    ibrowse:send_req(URL, req_headers('undefined'), Verb, Payload, [{'inactivity_timeout', 15000}]).

crossbar_noauth_request(Verb, API_String, DataBag, Context) ->
    case crossbar_noauth_request_raw(Verb, API_String, DataBag, Context) of
        {'ok', ReturnCode, _, Body} ->
            case ReturnCode of
                [50,_,_] ->    %  50 = "2"
                    {JsonData} = jiffy:decode(Body),
                    proplists:get_value(<<"data">>, JsonData);
                _ -> <<"">>
            end;
        E -> 
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

crossbar_account_send_request(Verb, API_String, ContentType, DataBag, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    crossbar_account_send_request(Verb, API_String, ContentType, DataBag, AuthToken, Context).

crossbar_account_send_request(Verb, API_String, ContentType, DataBag, AuthToken, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, API_String/binary>>),
    Payload = case DataBag of
                  [] -> [];
                  _ ->
                      case ContentType of
                          "application/json" -> jiffy:encode(DataBag);
                          _ -> DataBag
                      end
              end,
    ibrowse:send_req(URL, req_headers(ContentType, AuthToken), Verb, Payload, [{'inactivity_timeout', 15000}]).

crossbar_account_send_raw_request_body(Verb, API_String, Headers, Data, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    crossbar_account_send_raw_request_body(AuthToken, Verb, API_String, Headers, Data, Context).

crossbar_account_send_raw_request_body(AuthToken, Verb, API_String, Headers, Data, Context) ->
    case crossbar_account_send_raw_request(AuthToken, Verb, API_String, Headers, Data, Context) of
        {'ok', [50,_,_], _, Body} ->  Body; %  50 = "2"
        E -> 
            lager:info("crossbar_account_send_raw_request_body Error: ~p", [E]),
            lager:info("crossbar_account_send_raw_request_body Error Verb: ~p", [Verb]),
            lager:info("crossbar_account_send_raw_request_body Error API_String: ~p", [API_String]),
            lager:info("crossbar_account_send_raw_request_body Error Data: ~p", [Data]),
            <<>>
    end.
        
crossbar_account_send_raw_request(Verb, API_String, Headers, Data, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    crossbar_account_send_raw_request(AuthToken, Verb, API_String, Headers, Data, Context).

crossbar_account_send_raw_request(AuthToken, Verb, API_String, Headers, Data, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    URL = z_convert:to_list(<<Crossbar_URL/binary, API_String/binary>>),
    ibrowse:send_req(URL, req_headers(AuthToken)++Headers, Verb, Data, [{'inactivity_timeout', 15000}]).

crossbar_account_request(Verb, API_String, DataBag, Context) ->
    crossbar_account_request(Verb, API_String, DataBag, Context, <<>>).

crossbar_account_request(Verb, API_String, DataBag, Context, Default) ->
    case crossbar_account_send_request(Verb, API_String, DataBag, Context) of
        {'ok', ReturnCode, _, Body} ->
            case ReturnCode of
                [50,_,_] ->
                    {JsonData} = jiffy:decode(Body),
                    proplists:get_value(<<"data">>, JsonData);
                "402" -> 
                    error_return(ReturnCode, Body, Default);
                _ -> 
                    case ReturnCode of
                        "401" -> z_notifier:notify({kazoo_notify, "no_auth",'undefined','undefined','undefined'}, Context);
                        "429" ->
                            mod_signal:emit({emit_growl_signal
                                            ,?SIGNAL_FILTER(Context) ++
                                             [{'text',?__("Too many requests, please wait and refresh page.", Context)}
                                             ,{'type', 'notice'}
                                             ]
                                            }
                                           ,Context);
                        _ -> 'ok'
                    end,
                    lager:info("crossbar_account_request API String: ~p", [API_String]),
                    lager:info("crossbar_account_request DataBag: ~p", [DataBag]),
                    lager:info("crossbar_account_request Verb: ~p", [Verb]),
                    lager:info("crossbar_account_request RC: ~p", [ReturnCode]),
                    lager:info("crossbar_account_request Body: ~p", [Body]),
                    lager:info("crossbar_account_request decoded Body: ~p", [jiffy:decode(Body)]),
                    error_return(ReturnCode, Body, Default)
            end;
        E -> 
            lager:info("crossbar_account_request Error Verb: ~p", [Verb]),
            lager:info("crossbar_account_request Error API_String: ~p", [API_String]),
            lager:info("crossbar_account_request Error DataBag: ~p", [DataBag]),
            lager:info("crossbar_account_request Error: ~p", [E]),
            Default
    end.

crossbar_account_authtoken_request(Verb, API_String, DataBag, AuthToken, Context, Default) ->
    case crossbar_account_send_request(Verb, API_String, "application/json", DataBag, AuthToken, Context) of
        {'ok', ReturnCode, _, Body} ->
            case ReturnCode of
                [50,_,_] ->
                    {JsonData} = jiffy:decode(Body),
                    proplists:get_value(<<"data">>, JsonData);
                _ -> 
                    case ReturnCode of
                        "401" -> z_notifier:notify({kazoo_notify, "no_auth",'undefined','undefined','undefined'}, Context);
                        "429" ->
                            mod_signal:emit({emit_growl_signal
                                            ,?SIGNAL_FILTER(Context) ++
                                             [{'text',?__("Too many requests, please wait and refresh page.", Context)}
                                             ,{'type', 'notice'}
                                             ]
                                            }
                                           ,Context);
                        _ -> 'ok'
                    end,
                    error_return(ReturnCode, Body, Default)
            end;
        _E -> 
            Default
    end.

error_return(ReturnCode, Body, Default) ->
    case Default of
        'return_error' -> {'error', ReturnCode, Body};
        _ -> Default
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
    modkazoo_util:get_value([?TO_BIN(X) || X <- Field], kz_get_acc_doc_by_account_id(AccountId, Context));
kz_account_doc_field(Field, AccountId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_acc_doc_by_account_id(AccountId, Context));
kz_account_doc_field(Field, AccountId, Context) when is_list(Field) ->
    modkazoo_util:get_value(?TO_BIN(Field), kz_get_acc_doc_by_account_id(AccountId, Context)).

kz_user_doc_field(Field, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    kz_user_doc_field(Field, OwnerId, Context).

kz_user_doc_field(Field, OwnerId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_user_doc(OwnerId, Context));
kz_user_doc_field(Field, OwnerId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([?TO_BIN(X) || X <- Field], kz_get_user_doc(OwnerId, Context));
kz_user_doc_field(Field, OwnerId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_user_doc(OwnerId, Context));
kz_user_doc_field(Field, OwnerId, Context) when is_list(Field) ->
    modkazoo_util:get_value(?TO_BIN(Field), kz_get_user_doc(OwnerId, Context)).

kz_device_doc_field(Field, DeviceId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_device_doc(DeviceId, Context));
kz_device_doc_field(Field, DeviceId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([?TO_BIN(X) || X <- Field], kz_get_device_doc(DeviceId, Context));
kz_device_doc_field(Field, DeviceId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_device_doc(DeviceId, Context));
kz_device_doc_field(Field, DeviceId, Context) when is_list(Field) ->
    modkazoo_util:get_value(?TO_BIN(Field), kz_get_device_doc(DeviceId, Context)).

kz_media_doc_field(Field, MediaId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, kz_get_media_doc(MediaId, Context));
kz_media_doc_field(Field, MediaId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([?TO_BIN(X) || X <- Field], kz_get_media_doc(MediaId, Context));
kz_media_doc_field(Field, MediaId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, kz_get_media_doc(MediaId, Context));
kz_media_doc_field(Field, MediaId, Context) when is_list(Field) ->
    modkazoo_util:get_value(?TO_BIN(Field), kz_get_media_doc(MediaId, Context)).

create_kazoo_account(Context) ->
    Firstname = ?TO_BIN(z_context:get_q("firstname", Context)),
    Surname = ?TO_BIN(z_context:get_q("surname", Context)),
    Username = modkazoo_util:to_lower_binary(z_context:get_q("username", Context)),
    Companyname = ?TO_BIN(z_context:get_q("companyname", Context)),
    Email = ?TO_BIN(z_context:get_q("email", Context)),
    Phonenumber = ?TO_BIN(z_context:get_q("phonenumber", Context)),
    DefaultRealm = m_config:get_value('mod_kazoo', 'kazoo_default_realm', Context),
    Accountname = case valid_account_name(Companyname) of
      'false' -> ?TO_BIN(modkazoo_util2:translit(z_convert:to_list(<<Firstname/binary, <<" ">>/binary, Surname/binary>>)));
      'true' -> ?TO_BIN(modkazoo_util2:translit(z_convert:to_list(Companyname)))
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
                                          Lang -> ?TO_BIN(Lang)
                                      end
                     }
                    ,{<<"timezone">>,case m_config:get_value('mod_kazoo', 'default_kazoo_timezone', Context) of
                                         'undefined' -> <<"Europe/London">>;
                                          TZ -> ?TO_BIN(TZ)
                                      end
                     }
                    ,{<<"realm">>,<<(modkazoo_util:normalize_account_name(Accountname))/binary, DefaultRealm/binary>>}
                    ,{<<"available_apps">>,[<<"voip">>,<<"pbxs">>]}
                    ,{<<"is_trial_account">>, 'true'}
                  ]}
              }]},
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ResellerId/binary>>,
    case z_context:get_session(kazoo_auth_token, Context) of
        'undefined' -> {'ok', _, _, Body} = crossbar_admin_request('put', API_String, DataBag, Context);
        _ -> {'ok', _, _, Body} = crossbar_account_send_raw_request('put', API_String, [], jiffy:encode(DataBag), Context)
    end,
    CreatedUserAccountId =  case modkazoo_util:get_value([<<"data">>,<<"id">>], jiffy:decode(Body)) of
                                'undefined' -> throw({'error', 'account_name_already_in_use'});
                                 AccId -> AccId
                            end,
    UserPassword = modkazoo_util:rand_hex_binary(10),
    create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, CreatedUserAccountId, Context),
    send_signup_email(Accountname, Username, Firstname, Surname, Email, UserPassword, Context),
    {'new_account_id', CreatedUserAccountId}.
 
valid_account_name(Name) when size(Name) < 3 -> 'false';
valid_account_name(_) -> 'true'.

kz_account_create_callflow(Routines, Context) ->
    DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, ?EMPTY_CALLFLOW, Routines)),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary>>,
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
    ForwardTo = ?TO_BIN(z_context:get_q("ring-number-txt", Context)),
    RingVoip = not modkazoo_util:on_to_true(z_context:get_q("ring-device-checkbox", Context)),
    KeepCallerID = modkazoo_util:on_to_true(z_context:get_q("call_forward_keep_caller_id", Context)),
    VmToEmail = modkazoo_util:on_to_true(z_context:get_q("vm-to-email-checkbox", Context)),
    Timezone = ?TO_BIN(z_context:get_q("user_timezone", Context)),
    z_context:set_session('user_timezone', Timezone, Context),
    CurrentDoc = kz_get_user_doc(Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"enabled">>], CallForwardEnabled, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"number">>], ForwardTo, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"substitute">>], RingVoip, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"call_forward">>, <<"keep_caller_id">>], KeepCallerID, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"vm_to_email_enabled">>], VmToEmail, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"timezone">>], Timezone, J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrentDoc, Routines),
    Owner_Id = z_context:get_session('kazoo_owner_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?USERS/binary, "/", Owner_Id/binary>>,
    crossbar_account_request('post', API_String, {[{<<"data">>, NewDoc}]}, Context),
    Context.

create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, AccountId, Context) ->
    create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, <<"admin">>, AccountId, Context).

create_kazoo_user(Username, UserPassword, Firstname, Surname, Email, Phonenumber, PrivLevel, AccountId, Context) ->
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
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
                    {<<"enabled">>, 'true'},
                    {<<"email">>, Email},
                    {<<"contact_phonenumber">>, Phonenumber},
                    {<<"password">>, UserPassword},
                    {<<"priv_level">>,PrivLevel},
                    {<<"vm_to_email_enabled">>,true},
                    {<<"fax_to_email_enabled">>,true},
                    {<<"verified">>,false},
                    {<<"timezone">>,get_account_timezone(Context)},
                    {<<"record_call">>,false}
                   ]}
               }]},
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?USERS/binary>>,
    {'ok', _, _, Body} = crossbar_admin_request('put', API_String, DataBag, Context),
    modkazoo_util:get_value(<<"data">>, jiffy:decode(Body)),
    Doc = modkazoo_util:get_value(<<"data">>, jiffy:decode(Body)),
    UserId = modkazoo_util:get_value(<<"id">>, Doc),
    API_String2 = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?USERS/binary, "/", ?TO_BIN(UserId)/binary>>,
    crossbar_admin_request('post', API_String2, ?MK_DATABAG(modkazoo_util:set_value(<<"enabled">>,'true', Doc)), Context).

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
            SignUpload = [#upload{tmpfile=SignUploadTmp
                                 ,data=FileData
                                 ,filename=modkazoo_util2:translit(SignUploadFilename)
                                 ,mime=proplists:get_value(mime, FileIdnProps)
                                 }
                         ];
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
            ,{comments, ?TO_BIN(z_context:get_q("comments", Context))}
            ,{phonenumber, ?TO_BIN(z_context:get_q("phonenumber", Context))}
           ] ++ SignUploadFilenameVar,

    Attachments = SignUpload,

    case modkazoo_util:get_q_bin("notify_signed_up",Context) of
        <<"yes">> -> 
            E_SignUp = #email{
                to=Email,
                from=SalesEmail,
                html_tpl="_email_signup_greeting.tpl",
                vars=Vars,
                attachments=Attachments
            },
            z_email:send(E_SignUp, Context);
        _ ->
            'ok'
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
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?USERS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_devices(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?DEVICES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_devices(Context) ->
    Owner_Id = z_context:get_session('kazoo_owner_id', Context),
    kz_list_user_devices(Owner_Id, Context).

kz_list_user_devices(Owner_Id, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?DEVICES/binary, "?", ?FILTER_OWNER/binary, Owner_Id/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_vmboxes(Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_vmboxes(Context) ->
    Owner_Id = z_context:get_session('kazoo_owner_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "?", ?FILTER_OWNER/binary, Owner_Id/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_vmbox_details(VMBoxId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_vmbox_messages(VMBoxId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary, ?MESSAGES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_purge_voicemails(VMBoxId, DaysTo, Context) ->
    Candidates = vmbox_messages('get', VMBoxId, Context),
    FilterTS = calendar:datetime_to_gregorian_seconds(calendar:universal_time()) - (z_convert:to_integer(DaysTo) * 86400),
    MediaIds = [modkazoo_util:get_value(<<"media_id">>, X)
                || X <- Candidates
                   ,(FilterTS > (z_convert:to_integer(modkazoo_util:get_value(<<"timestamp">>, X))))
                    andalso (modkazoo_util:get_value(<<"folder">>, X) =/= <<"deleted">>)
               ],
    lists:foldl(fun(MediaId, Delay) -> spawn(?MODULE, kz_purge_voicemail, [VMBoxId, MediaId, Delay, Context]), Delay + 1 end, 0, MediaIds),
    length(MediaIds) + 2.

kz_purge_voicemail(VMBoxId, MediaId, Delay, Context) ->
    timer:sleep(Delay * ?MILLISECONDS_IN_SECOND),
    vmbox_message('delete', MediaId, VMBoxId, Context).

kz_list_account_cdr(CreatedFrom, CreatedTo, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    kz_list_account_cdr(AccountId, CreatedFrom, CreatedTo, AuthToken, Context).

kz_list_account_cdr(AccountId, CreatedFrom, CreatedTo, AuthToken, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CDRS/binary, <<"?">>/binary, 
                    ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary, ?NO_PAGINATION/binary>>,
    crossbar_account_authtoken_request('get', API_String, [], AuthToken, Context, <<>>).

kz_list_account_cdr_interaction(CreatedFrom, CreatedTo, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    kz_list_account_cdr_interaction(AccountId, CreatedFrom, CreatedTo, AuthToken, Context).

kz_list_account_cdr_interaction(AccountId, CreatedFrom, CreatedTo, AuthToken, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CDRS/binary, ?INTERACTION/binary, <<"?">>/binary, 
                    ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary, ?NO_PAGINATION/binary>>,
    crossbar_account_authtoken_request('get', API_String, [], AuthToken, Context, <<>>).

kz_list_account_cdr_page(_StartKey, PageSize, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?CDRS/binary, ?INTERACTION/binary, <<"?">>/binary,
                   ?PAGE_SIZE/binary, ?TO_BIN(PageSize)/binary>>,
 %                  ?START_KEY/binary, ?TO_BIN(StartKey)/binary, <<"&">>/binary, ?PAGE_SIZE/binary, ?TO_BIN(PageSize)/binary>>,
 %  Docs to implement pagination: https://github.com/2600hz/kazoo/blob/master/applications/crossbar/doc/basics.md#pagination                 
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_cdr(CreatedFrom, CreatedTo, Context) ->
    OwnerId = z_context:get_session('kazoo_owner_id', Context),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?USERS/binary, "/", OwnerId/binary, ?CDRS/binary, <<"?">>/binary, 
                   ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_user_cdr_reduced(CreatedFrom, CreatedTo, Context) ->
    kz_cdr_list_reduce(kz_list_user_cdr(CreatedFrom, CreatedTo, Context), Context).

kz_fetch_cdr_details(CdrId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?CDRS/binary, "/", ?TO_BIN(CdrId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_cdr_legs(CdrId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?CDRS/binary, ?LEGS/binary, "/", ?TO_BIN(CdrId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_cdr_legs_localized(CdrId, Context) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    [cdr_jobj_add_localtime(CdrElement, Timezone) || CdrElement <- kz_cdr_legs(CdrId, Context)].

cdr_jobj_add_localtime(CdrElement, Timezone) ->
    T = z_convert:to_integer(modkazoo_util:get_value(<<"timestamp">>,CdrElement)),
    modkazoo_util:set_value(<<"filtered_call_date">>
                           ,localtime:local_to_local(calendar:gregorian_seconds_to_datetime(T), "UTC", Timezone)
                           ,CdrElement).

kz_vmessage_download_link(VMBoxId, MediaId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary,
                   ?MESSAGES/binary, "/", ?TO_BIN(MediaId)/binary, ?RAW/binary, <<"?">>/binary,
                   ?AUTH_TOKEN/binary, (z_context:get_session(kazoo_auth_token, Context))/binary>>,
    <<(m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context))/binary, API_String/binary>>. 
    
kz_kzattachment_link(RecordingId, DocType, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    kz_kzattachment_link(AccountId, RecordingId, AuthToken, DocType, Context).

kz_kzattachment_link(AccountId, [_|_] = RecordingIds, AuthToken, DocType, Context) ->
    [kz_kzattachment_link(AccountId, RecordingId, AuthToken, DocType, Context) || RecordingId <- RecordingIds];
kz_kzattachment_link(AccountId, RecordingId, AuthToken, DocType, Context) ->
    API_String = <<"/kzattachment?"
                   ,"account_id=", ?TO_BIN(AccountId)/binary
                   ,"&recording_id=", ?TO_BIN(RecordingId)/binary
                   ,"&auth_token=", ?TO_BIN(AuthToken)/binary
                   ,"&doc_type=", ?TO_BIN(DocType)/binary
                 >>,
    <<"https://", ?TO_BIN(z_dispatcher:hostname(Context))/binary, API_String/binary>>. 

call_recording_attachment(AccountId, RecordingId, AuthToken, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary,?RECORDINGS/binary,"/", ?TO_BIN(RecordingId)/binary>>,
    crossbar_account_send_raw_request_body(AuthToken, 'get', API_String, [{"Accept", "audio/mpeg"}], [], Context).

kz_cdr_list_reduce(CdrList, Context) when is_list(CdrList) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    [ kz_cdr_element_reduce(Element, Timezone, Context) || Element <- CdrList ];
kz_cdr_list_reduce(_,_) ->
    [].

kz_cdr_element_reduce({CdrElement} = _Element, Timezone, Context) ->
    FilterFun = fun ({<<"timestamp">>,_}) -> true;
                    ({<<"calling_from">>,_}) -> true;
                    ({<<"from">>,_}) -> true;
                    ({<<"dialed_number">>,_}) -> true;
                    ({<<"to">>,_}) -> true;
                    ({<<"duration_seconds">>,_}) -> true;
                    ({<<"billing_seconds">>,_}) -> true;
                    ({<<"id">>,_}) -> true;
                    ({<<"call_id">>,_}) -> true;
                    ({<<"media_recordings">>,_}) -> true;
                    ({<<"rate_name">>,_}) -> true;
                    ({<<"rate">>,_}) -> true;
                    ({<<"cost">>,_}) -> true;
                    (_) -> false end,
    T = z_convert:to_integer(proplists:get_value(<<"timestamp">>,CdrElement)),
    ?JSON_WRAPPER(lists:filter(FilterFun, CdrElement)
      ++[{<<"full_element">>,  CdrElement}]
      ++[{<<"z_recording_download_link">>, kz_kzattachment_link(proplists:get_value(<<"media_recordings">>, CdrElement)
                                                                ,"call_recording"
                                                                ,Context)
        }]
      ++[{<<"filtered_call_date">>, localtime:local_to_local(calendar:gregorian_seconds_to_datetime(T), "UTC", Timezone)}]).

kz_list_account_cdr_reduced(CreatedFrom, CreatedTo, Context) ->
    case z_context:get_session('show_cdr_legs', Context) of
        'true' ->
            kz_cdr_list_reduce(kz_list_account_cdr(CreatedFrom, CreatedTo, Context), Context);
        _ ->
            kz_cdr_list_reduce(kz_list_account_cdr_interaction(CreatedFrom, CreatedTo, Context), Context)
    end.

kz_incoming_fax_download_link(DocId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?FAXES_INCOMING/binary, ?TO_BIN(DocId)/binary,
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
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary>>,
    crossbar_account_request('post', API_String, {[{<<"data">>, NewVMBox}]}, Context).

update_folder1(Message, Folder, MediaId, MediaId) ->
    modkazoo_util:set_value(<<"folder">>, ?TO_BIN(Folder), Message);
update_folder1(Message, _, _, _) ->
    Message.

password_recovery(Username, AccountName, Context) ->
    API_String = <<?V2/binary, ?USER_AUTH/binary, ?RECOVERY/binary>>,
    DataBag = {[{<<"data">>,
                  {[{<<"username">>, ?TO_BIN(Username)}
                    ,{<<"account_name">>, ?TO_BIN(AccountName)}
                    ,{<<"ui_url">>, <<"https://", ?TO_BIN(z_dispatcher:hostname(Context))/binary, "/password_reset_form">>}
                  ]}
              }]},
    crossbar_noauth_request('put', API_String, DataBag, Context). 

password_reset_submit(ResetId, Context) ->
    API_String = <<?V2/binary, ?USER_AUTH/binary, ?RECOVERY/binary>>,
    DataBag = {[{<<"data">>, {[{<<"reset_id">>, ?TO_BIN(ResetId)}]}}]},
    crossbar_noauth_request_raw('post', API_String, DataBag, Context). 

growl_redirect(Type, Text, Dispatch, Context) ->
    Routines = [
                fun(J) -> z_render:wire({'growl', [{text, ?__(Text, J)}, {type, Type}, {stay, true}]}, J) end
               ,fun(J) -> z_render:wire([{redirect, [{dispatch, Dispatch}]}], J) end
               ],
    lists:foldl(fun(F, J) -> F(J) end, Context, Routines).

change_credentials(Username, Password, OwnerId, Context) ->
    CurrDoc = kz_get_user_doc(OwnerId, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"username">>], ?TO_BIN(Username), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"email">>], ?TO_BIN(Username), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"password">>], ?TO_BIN(Password), J) end],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrDoc, Routines),
    Account_Id = z_context:get_session('kazoo_account_id', Context),
    case Account_Id =:= 'undefined' orelse OwnerId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, Account_Id/binary, ?USERS/binary, "/", ?TO_BIN(OwnerId)/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context, 'return_error');
        'true' -> []
    end.

current_account_credit(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    current_account_credit(AccountId, Context).

current_account_credit(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?BRAINTREE/binary, ?CREDITS/binary>>, 
    crossbar_account_request('get', API_String, [], Context).

kz_check_device_registration(DeviceId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?DEVICES/binary, ?STATUS/binary>>, 
    DevicesStatus = crossbar_account_request('get', API_String, [], Context),
    lists:member({[{<<"device_id">>,?TO_BIN(DeviceId)},{<<"registered">>,true}]}, DevicesStatus).

kz_get_registrations_by_accountid(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?REGISTRATIONS/binary>>, 
    crossbar_account_request('get', API_String, [], Context).

kz_get_registrations_count_by_accountid(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?REGISTRATIONS/binary, ?COUNT/binary>>, 
    crossbar_account_request('get', API_String, [], Context).

kz_get_reseller_registrations(AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
                     'true' ->
                         <<?V2/binary, ?REGISTRATIONS/binary>>;
                     'false' ->
                         <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?REGISTRATIONS/binary>> 
                 end,
    crossbar_account_request('get', API_String, [], Context).

kz_get_reseller_registrations_count(AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
                     'true' ->
                         <<?V2/binary, ?REGISTRATIONS/binary, ?COUNT/binary>>;
                     'false' ->
                         <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?REGISTRATIONS/binary, ?COUNT/binary>> 
                 end,
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
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?REGISTRATIONS/binary, "/", ?TO_BIN(Username)/binary>>, 
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
    API_String = <<?RATES/binary, ?NUMBER/binary, "/", ?TO_BIN(Number)/binary>>, 
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
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?FAXES_INCOMING/binary, ?TO_BIN(DocId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_incoming_fax_delete(DocId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?FAXES_INCOMING/binary, ?TO_BIN(DocId)/binary>>,
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
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?FAXES_INCOMING/binary, ?TO_BIN(DocId)/binary, ?ATTACHMENT/binary>>,
    crossbar_account_attachment_request('get', API_String, [], Context).

phone_number(<<"+", Number/binary>>, Context) ->
    phone_number(<<"%2B", Number/binary>>, Context);
phone_number(Number, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    phone_number('get', Number, AccountId, [], Context).

phone_number(Verb, <<"+", Number/binary>>, AccountId, DataBag, Context) ->
    phone_number(Verb, <<"%2B", Number/binary>>, AccountId, DataBag, Context);
phone_number(Verb, Number, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PHONE_NUMBERS/binary, "/", ?TO_BIN(Number)/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_account_numbers_info(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_account_numbers_info(AccountId, Context).

kz_account_numbers_info(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PHONE_NUMBERS/binary>>,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> [];
        Result -> modkazoo_util:to_proplist(<<"numbers">>,Result)
    end.

account_numbers_fix_plus(AccountId, Context) ->
    _ = account_numbers_fix(AccountId, Context),
    mod_signal:emit({onnet_allocated_numbers_tpl, ?SIGNAL_FILTER(Context)} ,Context),
    mod_signal:emit({emit_growl_signal
                    ,?SIGNAL_FILTER(Context) ++
                     [{'text',?__("Numbers refresh finished", Context)}
                     ,{'type', 'notice'}
                     ]}
                   ,Context).

account_numbers_fix(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PHONE_NUMBERS/binary, ?FIX/binary>>,
    crossbar_account_request('post', API_String, [], Context).

kz_account_numbers(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_account_numbers(AccountId, Context).

kz_account_numbers(AccountId, Context) ->
    proplists:get_keys(kz_account_numbers_info(AccountId, Context)).

kz_spare_numbers(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_spare_numbers(AccountId, Context).

kz_spare_numbers(AccountId, Context) ->
    [Number || {Number, JObj} <- kz_account_numbers_info(AccountId, Context), modkazoo_util:get_value(<<"used_by">>,JObj) == 'undefined'].

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

kz_list_ledgers(LedgerId, AccountId, CreatedFrom, CreatedTo, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?LEDGERS/binary, "/", ?TO_BIN(LedgerId)/binary
                   ,"?", ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary>>,
    crossbar_account_request('get', API_String, [], Context, []).

kz_ledgers_summary(AccountId, CreatedFrom, CreatedTo, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?LEDGERS/binary
                   ,"?", ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_transactions(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_transactions(AccountId, Context).

kz_list_transactions(AccountId, Context) ->
    {Year, Month, _} = erlang:date(),
    CreatedFrom = calendar:datetime_to_gregorian_seconds({{Year,Month,1},{0,0,0}}),
    CreatedTo = calendar:datetime_to_gregorian_seconds({{Year,Month,calendar:last_day_of_the_month(Year, Month)},{23,59,59}}),
    kz_list_transactions(AccountId, CreatedFrom, CreatedTo, Context).

kz_list_transactions(CreatedFrom, CreatedTo, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_transactions(AccountId, CreatedFrom, CreatedTo, Context).

kz_list_transactions(AccountId, CreatedFrom, CreatedTo, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TRANSACTIONS/binary, <<"?">>/binary,
                   ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_transactions(AccountId, CreatedFrom, CreatedTo, Reason, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TRANSACTIONS/binary, <<"?">>/binary,
                   ?MK_TIME_FILTER(?TO_BIN(CreatedFrom), ?TO_BIN(CreatedTo))/binary, ?SET_REASON(Reason)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_bt_transactions(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?BRAINTREE/binary, ?TRANSACTIONS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_subscriptions(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_subscriptions(AccountId, Context).

kz_list_subscriptions(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TRANSACTIONS/binary, ?SUBSCRIPTIONS/binary>>,
    lager:info("kz_list_subscriptions: ~p", [crossbar_account_request('get', API_String, [], Context)]),
    crossbar_account_request('get', API_String, [], Context).

kz_current_balance(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TRANSACTIONS/binary, ?CURRENT_BALANCE/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_transactions_credit(CreditType, Amount, Reason, Description, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TRANSACTIONS/binary, ?CREDIT/binary>>,
    DataBag = {[{<<"data">>,{[{<<"amount">>, ?TO_BIN(Amount)}
                             ,{<<"reason">>, ?TO_BIN(Reason)}
                             ,{<<"description">>, ?TO_BIN(Description)}
                             ,{<<"credit_type">>, ?TO_BIN(CreditType)}
                             ]}}]},
    lager:info("kz_transactions_credit DataBag: ~p", [DataBag]),
    crossbar_account_request('put', API_String, DataBag, Context).

kz_transactions_debit(Amount, Reason, Description, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TRANSACTIONS/binary, ?DEBIT/binary>>,
    DataBag = {[{<<"data">>,{[{<<"amount">>, ?TO_BIN(Amount)}
                              ,{<<"reason">>, ?TO_BIN(Reason)}
                              ,{<<"description">>, ?TO_BIN(Description)}
                             ]}}]},
    crossbar_account_request('delete', API_String, DataBag, Context).

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
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_context:get_session('kazoo_account_id', Context))/binary, ?BRAINTREE/binary, ?CARDS/binary, "/", CardId/binary>>,
    crossbar_account_request('delete', API_String, [], Context).
    
make_payment(Amount, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?BRAINTREE/binary, ?CREDITS/binary>>, 
    DataBag = {[{<<"data">>,{[{<<"amount">>, ?TO_BIN(Amount)}]}}]},
    lager:info("Make payment attempt. AccountId: ~p. Amount: ~p.",[AccountId, Amount]),
    crossbar_account_request('put', API_String, DataBag, Context, 'return_error').

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
            case z_convert:to_atom(kz_user_doc_field([<<"inno_ui">>,?TO_BIN(ElementName)], Context)) of
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
            kz_set_user_doc([<<"inno_ui">>,?TO_BIN(ElementName)], 'false', Context);
        _ -> 
            z_context:set_session(z_convert:to_atom(ElementName), 'true', Context),
            kz_set_user_doc([<<"inno_ui">>,?TO_BIN(ElementName)], 'true', Context)
    end. 

lookup_numbers(Country, AreaCode, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    lookup_numbers(Country, AreaCode, AccountId, Context).

lookup_numbers('undefined', AreaCode, AccountId, Context) ->
    Country = case m_config:get_value('mod_kazoo', 'default_country', Context) of
                  'undefined' -> <<"US">>;
                  Val -> Val
              end,
    lookup_numbers(Country, AreaCode, AccountId, Context);
lookup_numbers(Country, AreaCode, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PHONE_NUMBERS/binary
                   ,<<"?">>/binary, ?COUNTRY/binary, (?TO_BIN(Country))/binary
                   ,<<"&">>/binary,?PREFIX/binary, AreaCode/binary
                   ,<<"&">>/binary, ?QUANTITY/binary, <<"100">>/binary>>,
    crossbar_account_request('get', API_String, [], Context).

rs_add_number(Num, AccountId, Context) ->
    Number = case ?TO_BIN(Num) of 
        <<$+, BNum/binary>> -> BNum;
        BNum -> BNum
    end,
    DataBag = ?SET_ACCEPT_CHARGES('true', {[{<<"numbers">>, [Number]}]}),
    _ = crossbar_account_request('put'
                                 ,<<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PHONE_NUMBERS/binary, "/", Number/binary>>
                                 ,DataBag
                                 ,Context
                                ),
    _ = crossbar_account_request('put'
                                 ,<<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary
                                   ,?PHONE_NUMBERS/binary, "/", Number/binary, ?ACTIVATE/binary>>
                                 ,[]
                                 ,Context
                                ).

purchase_numbers(Numbers, AcceptCharges, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?PHONE_NUMBERS/binary, ?COLLECTION/binary, ?ACTIVATE/binary>>,
    DataBag = ?SET_ACCEPT_CHARGES(AcceptCharges, {[{<<"numbers">>, [?TO_BIN(Number) || Number <- Numbers]}]}),
    crossbar_account_request('put', API_String, DataBag, Context, 'return_error').

process_purchase_numbers([Number|_] = Numbers, AcceptCharges, Context) ->
    Routines = [fun(C) -> z_render:update("onnet_allocated_numbers_tpl"
                                         ,z_template:render("onnet_allocated_numbers.tpl", [{headline, "Allocated numbers"}], C)
                                         ,C)
                end
               ,fun(C) -> z_render:update("onnet_widget_monthly_fees_tpl"
                                         ,z_template:render("onnet_widget_monthly_fees.tpl", [{headline,"Current month services"}], C)
                                         ,C)
                end
               ,fun(C) -> z_render:update("onnet_widget_order_additional_number_tpl"
                                         ,z_template:render("onnet_widget_order_additional_number.tpl", [], C)
                                         ,C)
                end
               ,fun(C) -> z_render:dialog_close(C) end],
    case purchase_numbers(Numbers, AcceptCharges, Context) of
        {'error', _ReturnCode, Body} ->
            Ctx = lists:foldl(fun(F, J) -> F(J) end, Context, Routines),
            Message = modkazoo_util:get_value([<<"data">>,<<"error">>, ?TO_BIN(Number),<<"message">>], jiffy:decode(Body)),
            z_render:growl_error(?TO_LST(Message), Ctx);
        _ ->
            Ctx = lists:foldl(fun(F, J) -> F(J) end, Context, Routines),
            modkazoo_util:delay_signal(2, 'update_fin_info_signal', ?SIGNAL_FILTER(Context), Context),
            AccountId = z_context:get_session('kazoo_account_id', Context),
            _ = z_mqtt:publish(<<"site/phiz/public/current_account_credit_", AccountId/binary>>, <<>>, z_acl:sudo(Ctx)),
            z_render:growl(?__("Number ", Ctx)++z_convert:to_list(Number)++?__(" successfully allocated.", Ctx), Ctx)
    end.

deallocate_number(<<"+", Number/binary>>, Context) ->
    deallocate_number(<<"%2B", Number/binary>>, Context);
deallocate_number(Number, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    deallocate_number(Number, AccountId, Context).

deallocate_number(<<"+", Number/binary>>, AccountId, Context) ->
    deallocate_number(<<"%2B", Number/binary>>, AccountId, Context);
deallocate_number(Number, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PHONE_NUMBERS/binary, "/", ?TO_BIN(Number)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

service_plan(PlanId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    service_plan(PlanId, AccountId, Context).

service_plan(PlanId, AccountId, Context) ->
    service_plan('get', PlanId, AccountId, [], Context).

service_plan(Verb, PlanId, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, "/", ?TO_BIN(PlanId)/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

service_plans(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    service_plans(AccountId, Context).

service_plans(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

available_service_plans(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    available_service_plans(AccountId, Context).

available_service_plans(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, ?AVAILABLE/binary>>,
    crossbar_account_request('get', API_String, [], Context).

current_service_plans(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    current_service_plans(AccountId, Context).

current_service_plans(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, ?CURRENT/binary>>,
    crossbar_account_request('get', API_String, [], Context).

sync_service_plans(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, ?SYNCHRONIZATION/binary>>,
    crossbar_account_request('post', API_String, [], Context).

reconcile_service_plans(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, ?RECONCILIATION/binary>>,
    crossbar_account_request('post', API_String, [], Context).

add_service_plan(PlanId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, "/", ?TO_BIN(PlanId)/binary>>,
    DataBag = {[{<<"data">>, {[{<<"id">>, ?TO_BIN(PlanId)}]}}]},
    crossbar_account_request('post', API_String, DataBag, Context).

admin_add_service_plan(PlanId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, "/", ?TO_BIN(PlanId)/binary>>,
    DataBag = {[{<<"data">>, {[{<<"id">>, ?TO_BIN(PlanId)}]}}]},
    crossbar_admin_request('post', API_String, DataBag, Context).

remove_service_plan_from_account(PlanId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICE_PLANS/binary, "/", ?TO_BIN(PlanId)/binary>>,
    crossbar_account_request('delete', API_String, ?MK_DATABAG({[]}), Context).

is_service_plan_applied(Context) ->
    case modkazoo_util:get_value(<<"plans">>, current_service_plans(Context)) of
        'undefined' -> 'false';
        {[]} -> 'false';
        _ -> 'true'
    end.

valid_card_exists(Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?BRAINTREE/binary, ?CARDS/binary>>,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> 'false';
        Cards -> lists:member('false',[modkazoo_util:get_value(<<"expired">>,Card) || Card <- Cards])
    end.

is_creditable(Context) ->
    valid_card_exists(Context).

kz_get_user_timezone(Context) ->
    case kz_user_doc_field(<<"timezone">>, Context) of
        'undefined' -> get_account_timezone(Context);
        Timezone -> Timezone
    end.

get_account_timezone(Context) ->
    case z_context:get_session('kazoo_account_id', Context) of
        'undefined' ->
            m_config:get_value('mod_kazoo', 'default_kazoo_timezone', Context);
        AccountId ->
            case kz_account_doc_field(<<"timezone">>, AccountId, Context) of
                'undefined' -> m_config:get_value('mod_kazoo', 'default_kazoo_timezone', Context);
                Timezone -> Timezone
            end
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

get_account_name(Context) ->
    case z_context:get_session('kazoo_account_name', Context) of
        'undefined' ->
            Name = kz_account_doc_field(<<"name">>, Context),
            z_context:set_session('kazoo_account_name', Name, Context),
            Name;
        Name -> Name
    end.

get_account_name(AccountId, Context) ->
    kz_account_doc_field(<<"name">>, AccountId, Context).

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
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

delete_user(UserId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse UserId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?USERS/binary, "/", UserId/binary>>,
            crossbar_account_request('delete', API_String, [], Context);
        'true' -> []
    end.

delete_device(DeviceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse DeviceId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?DEVICES/binary, "/", DeviceId/binary>>,
            crossbar_account_request('delete', API_String, [], Context);
        'true' -> []
    end.

classify_number(PhoneNumber, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?PHONE_NUMBERS/binary, ?CLASSIFIERS/binary, "/", ?TO_BIN(PhoneNumber)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_classifiers(Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?PHONE_NUMBERS/binary, ?CLASSIFIERS/binary>>,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> [<<"">>];
        Result -> Result
    end.

add_device(Context) ->
    Props = modkazoo_util:filter_empty(
        [{[<<"data">>,<<"sip">>,<<"username">>],?TO_BIN(z_context:get_q("sipusername",Context))}
        ,{[<<"data">>,<<"sip">>,<<"password">>],?TO_BIN(z_context:get_q("sippassword",Context))}
        ,{[<<"data">>,<<"sip">>,<<"invite_format">>], case z_context:get_q("route",Context) of 'undefined' -> <<"username">>; _ -> <<"route">> end}
        ,{[<<"data">>,<<"sip">>,<<"route">>], ?TO_BIN(z_context:get_q("route",Context))}
        ,{[<<"data">>,<<"call_forward">>,<<"enabled">>], case z_context:get_q("cellphonenumber",Context) of 'undefined' -> false; _ -> true end}
        ,{[<<"data">>,<<"call_forward">>,<<"number">>],?TO_BIN(z_context:get_q("cellphonenumber",Context))}
        ,{[<<"data">>,<<"name">>],?TO_BIN(z_context:get_q("name",Context))}
        ,{[<<"data">>,<<"owner_id">>],?TO_BIN(z_context:get_q("device_owner_id",Context))}
        ,{[<<"data">>,<<"device_type">>],?TO_BIN(z_context:get_q("device_type",Context))}
        ]),
    DataBag = lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, ?MK_DEVICE_SIP, Props),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?DEVICES/binary>>,
    _ = crossbar_account_request('put', API_String, DataBag, Context),
    Context.

kz_list_account_groups(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?GROUPS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_blacklists(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?BLACKLISTS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_callflows(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_list_account_callflows(AccountId, Context).

kz_list_account_callflows(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CALLFLOWS/binary>>,
    crossbar_account_request('get', API_String, [], Context, []).

kz_get_account_callflow(CallflowId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_get_account_callflow(CallflowId, AccountId, Context).

kz_get_account_callflow(CallflowId, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CALLFLOWS/binary, "/", ?TO_BIN(CallflowId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_children(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CHILDREN/binary>>,
    lists:reverse(crossbar_account_request('get', API_String, [], Context)).

kz_list_account_channels(Context) ->
    kz_list_account_channels(z_context:get_session('kazoo_account_id', Context), Context).

kz_list_account_channels('undefined', Context) ->
    kz_list_account_channels(z_context:get_session('kazoo_account_id', Context), Context);
kz_list_account_channels(AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CHANNELS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_reseller_channels(AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
                     'true' ->
                         <<?V2/binary, ?CHANNELS/binary>>;
                     'false' ->
                         <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CHANNELS/binary>>
                 end,
    crossbar_account_request('get', API_String, [], Context).

kz_channel_info(CallId, Context) ->
    kz_channel_info(CallId, z_context:get_session('kazoo_account_id', Context), Context).

kz_channel_info(CallId, 'undefined', Context) ->
    kz_channel_info(CallId, z_context:get_session('kazoo_account_id', Context), Context);
kz_channel_info(CallId, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CHANNELS/binary, "/" , ?TO_BIN(CallId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_channel_action(CallId, DataBag, Context) ->
    kz_channel_action(CallId, DataBag, z_context:get_session('kazoo_account_id', Context), Context).

kz_channel_action(CallId, DataBag, 'undefined', Context) ->
    kz_channel_action(CallId, DataBag, z_context:get_session('kazoo_account_id', Context), Context);
kz_channel_action(CallId, DataBag, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CHANNELS/binary, "/", ?TO_BIN(CallId)/binary>>,
    crossbar_account_request('post', API_String, DataBag, Context).

kz_channel_hangup(CallId, AccountId, Context) ->
    DataBag = {[{<<"data">>, {[{<<"action">>, <<"hangup">>}]}}]},
    kz_channel_action(CallId, DataBag, AccountId, Context).

kz_channel_transfer(Target, CallId, AccountId, Context) ->
    DataBag = {[{<<"data">>, {[{<<"action">>, <<"transfer">>}, {<<"target">>, ?TO_BIN(Target)}, {<<"takeback_dtmf">>, <<"*1">>}]}}]},
    kz_channel_action(CallId, DataBag, AccountId, Context).

kz_channel_eavesdrop(Id, Mode, CallId, AccountId, Context) ->
    DataBag = {[{<<"data">>, {[{<<"call_id">>, ?TO_BIN(CallId)}, {<<"mode">>, ?TO_BIN(Mode)}, {<<"id">>, ?TO_BIN(Id)}]}}]},
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?QUEUES/binary, ?EAVESDROP/binary>>,
    crossbar_account_request('put', API_String, DataBag, Context).

add_group(Context) ->
    Endpoints = lists:foldr(fun(T,J) -> case T of
                                           {_,[]} -> []++J; 
                                           {"user",Id} ->  J++[{?TO_BIN(Id),{[{<<"type">>,<<"user">>}]}}];
                                           {"device",Id} ->  J++[{?TO_BIN(Id),{[{<<"type">>,<<"device">>}]}}];
                                           _ -> []++J 
                                       end 
                               end, [], z_context:get_q_all(Context)),
    Props = modkazoo_util:filter_empty(
        [{[<<"data">>,<<"name">>],?TO_BIN(z_context:get_q("name",Context))}
        ,{[<<"data">>,<<"endpoints">>],{Endpoints}}
        ]),
    DataBag = lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, ?MK_GROUP, Props),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?GROUPS/binary>>,
    _ = crossbar_account_request('put', API_String, DataBag, Context),
    Context.

modify_group(Context) ->
    modify_group(z_context:get_q("group_id",Context), Context).

modify_group(GroupId, Context) ->
    Endpoints = lists:foldr(fun(T,J) -> case T of
                                           {_,[]} -> []++J; 
                                           {"user",Id} ->  J++[{?TO_BIN(Id),{[{<<"type">>,<<"user">>}]}}];
                                           {"device",Id} ->  J++[{?TO_BIN(Id),{[{<<"type">>,<<"device">>}]}}];
                                           _ -> []++J 
                                       end 
                               end, [], z_context:get_q_all(Context)),
    Props = modkazoo_util:filter_empty(
        [{[<<"data">>,<<"name">>],?TO_BIN(z_context:get_q("name",Context))}
        ,{[<<"data">>,<<"endpoints">>],{Endpoints}}
        ]),
    DataBag = lists:foldl(fun({K,V},J) -> modkazoo_util:set_value(K,V,J) end, kz_get_group_doc(GroupId, Context), Props),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, "/", ?TO_BIN(GroupId)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context);
        'true' -> []
    end.

delete_group(GroupId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, "/", ?TO_BIN(GroupId)/binary>>,
            crossbar_account_request('delete', API_String, [], Context);
        'true' -> []
    end.

kz_get_group_doc(GroupId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, "/", ?TO_BIN(GroupId)/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

kz_set_group_doc(K, V, GroupId, Context) ->
    CurrDoc = kz_get_group_doc(GroupId, Context),
    NewDoc = modkazoo_util:set_value(K, V, CurrDoc),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse GroupId =:= 'undefined' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?GROUPS/binary, "/", ?TO_BIN(GroupId)/binary>>,
            crossbar_account_request('post', API_String,  {[{<<"data">>, NewDoc}]}, Context);
        'true' -> []
    end.

cf_add_number(Number, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context) of
        'undefined' -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    Numbers = modkazoo_util:get_value([<<"numbers">>], CurrentCallflow) ++ [?TO_BIN(Number)],
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"numbers">>], Numbers, CurrentCallflow), Context).

cf_add_pattern(Pattern, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context) of
        'undefined' -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    Patterns = modkazoo_util:get_value([<<"patterns">>], CurrentCallflow) ++ [?TO_BIN(Pattern)],
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"patterns">>], Patterns, CurrentCallflow), Context).

cf_delete_number(Number, Context) ->
    case z_context:get_session('current_callflow', Context) of
        'undefined' -> 'undefined';
        CurrentCallflow -> 
            Numbers = modkazoo_util:get_value([<<"numbers">>], CurrentCallflow) -- [?TO_BIN(Number)],
            Patterns = modkazoo_util:get_value([<<"patterns">>], CurrentCallflow) -- [?TO_BIN(Number)],
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
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"name">>], ?TO_BIN(Name), CurrentCallflow), Context).

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
    case modkazoo_util:get_value(<<"id">>,CurrentCallflow) of
        'undefined' ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary>>,
            case crossbar_account_request('put', API_String, DataBag, Context) of
                <<>> -> z_render:growl_error(?__("Something wrong happened.", Context), Context); 
                Result ->
                    cf_set_session('current_callflow', <<"id">>, modkazoo_util:get_value(<<"id">>,Result), Context),
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
                    z_render:growl(?__("Callflow saved", Context), Context)
            end;
        Id ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", ?TO_BIN(Id)/binary>>,
            case crossbar_account_request('post', API_String, ?MK_DATABAG(z_context:get_session('current_callflow', Context)), Context) of
                <<>> -> z_render:growl_error(?__("Something wrong happened.", Context), Context);
                _ ->
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
                    z_render:growl(?__("Callflow saved", Context), Context)
            end
    end.

cf_delete('current_callflow', Context) ->
    CurrentCallflow = z_context:get_session('current_callflow', Context),
    case modkazoo_util:get_value(<<"id">>,CurrentCallflow) of
        'undefined' ->
            z_context:set_session('current_callflow', 'undefined', Context);
        Id ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('delete', API_String, [], Context),
            z_context:set_session('current_callflow', 'undefined', Context)
    end.

cf_notes_number_action("add", Number, Context) ->
    case cf_notes_remove(Number, 'cf_notes_removed_numbers', Context) of
        'true' -> 'ok';
        'false' -> cf_notes_add(Number, 'cf_notes_added_numbers', Context)
    end;

cf_notes_number_action("remove", Number, Context) ->
    case cf_notes_remove(Number, 'cf_notes_added_numbers', Context) of
        'true' -> 'ok';
        'false' -> cf_notes_add(Number, 'cf_notes_removed_numbers', Context)
    end.

cf_notes_remove(Number, Type, Context) ->
    Numbers = cf_notes_get(Type, Context),
    case lists:member(Number, Numbers) of
        'true' ->
            NewNumbers = Numbers -- [Number],
            z_context:set_session(Type, NewNumbers, Context),
            'true';
        'false' -> 'false'
    end.

cf_notes_add(Number, Type, Context) ->
    Numbers = cf_notes_get(Type, Context),
    case lists:member(Number,Numbers) of
        'true' -> 'ok';
        'false' -> z_context:set_session(Type, [Number] ++ Numbers, Context)
    end.

cf_notes_get(Type, Context) ->
    case z_context:get_session(z_convert:to_atom(Type), Context) of
        'undefined' -> [];
        List -> List
    end.

cf_notes_flush(Context) ->
    z_context:set_session('cf_notes_removed_numbers', 'undefined', Context),
    z_context:set_session('cf_notes_added_numbers', 'undefined', Context).

kz_list_account_media(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_media_doc(MediaId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    case AccountId =:= 'undefined' orelse MediaId =:= 'undefined' orelse MediaId =:= 'null' of
        'false' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, AccountId/binary, ?MEDIA/binary, "/", ?TO_BIN(MediaId)/binary>>,
            crossbar_account_request('get', API_String, [], Context);
        'true' -> []
    end.

cf_build_page_group_endpoints(Context) ->
    lists:map(fun (EndpointId) ->
                  {[{<<"endpoint_type">>,?TO_BIN(z_context:get_q(EndpointId++"_type", Context))}
                   ,{<<"id">>,?TO_BIN(EndpointId)}]}
              end, z_context:get_q_all("sortable_element", Context)).

cf_build_ring_group_endpoints(Context) ->
    lists:map(fun (EndpointId) -> cf_form_endpoint(EndpointId, Context) end, z_context:get_q_all("sortable_element", Context)).

cf_form_endpoint(EndpointId, Context) ->
    {[{<<"endpoint_type">>,?TO_BIN(z_context:get_q(EndpointId++"_type", Context))}
     ,{<<"id">>,?TO_BIN(EndpointId)}
     ,{<<"delay">>,?TO_BIN(z_context:get_q(EndpointId++"_delay", Context))}
     ,{<<"timeout">>,?TO_BIN(z_context:get_q(EndpointId++"_timeout", Context))}]}.

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
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MENUS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_menu(Context) ->
    Id = z_context:get_q("menu_id",Context),
    Props = [{<<"name">>, ?TO_BIN(z_context:get_q("name", Context))}
            ,{<<"retries">>, ?TO_BIN(z_context:get_q("retries", Context))}
            ,{<<"timeout">>, ?TO_BIN(z_context:get_q("timeout", Context))}
            ,{<<"max_extension_length">>, ?TO_BIN(z_context:get_q("max_extension_length", Context))}
            ,{<<"media">>, {[{<<"exit_media">>, not(modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context)))}
                            ,{<<"invalid_media">>, not(modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context)))}
                            ,{<<"transfer_media">>, not(modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context)))}
                            ,{<<"greeting">>, ?TO_BIN(z_context:get_q("greeting", Context))}]}}
            ,{<<"record_pin">>, ?TO_BIN(z_context:get_q("record_pin", Context))}
            ,{<<"allow_record_from_offnet">>, modkazoo_util:on_to_true(z_context:get_q("allow_record_from_offnet", Context))}
            ,{<<"hunt">>, modkazoo_util:on_to_true(z_context:get_q("hunt", Context))}
            ,{<<"suppress_media">>, modkazoo_util:on_to_true(z_context:get_q("suppress_media", Context))}
            ,{<<"hunt_allow">>, ?TO_BIN(z_context:get_q("hunt_allow", Context))}
            ,{<<"hunt_deny">>, ?TO_BIN(z_context:get_q("hunt_deny", Context))}
            ,{<<"id">>, ?TO_BIN(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MENUS/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MENUS/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_menu(Verb, MenuId,Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MENUS/binary, "/", ?TO_BIN(MenuId)/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

kz_list_account_temporal_rules(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_temporal_rule(RuleId,Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary, "/", ?TO_BIN(RuleId)/binary>>,
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
                    _ = cf_set_session('current_callflow', z_string:split(ElementId,"-"), ParkedBranch, Context),
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
                    z_render:dialog_close(Context)
            end;
        "dead_air" ->
            cf_set_session('current_callflow', z_string:split(ElementId,"-")++["module"], ?TO_BIN(ToolName), Context),
            cf_set_session('current_callflow', z_string:split(ElementId,"-")++["children"], {[]}, Context),
            cf_set_session('current_callflow', z_string:split(ElementId,"-")++["data"], {[]}, Context),
            z_render:insert_bottom(PathToChildren
                          ,z_template:render("_cf_child.tpl",[{tool_name,ToolName}
                                                             ,{element_id, ElementId}
                                                             ,{drop_parent,DropParent}
                                                             ,{switch,Switch}]
                                             ,Context)
                          ,Context);
        _ ->
            Context1 = z_render:insert_bottom(PathToChildren
                                     ,z_template:render("_cf_child.tpl",[{tool_name,ToolName}
                                                                        ,{element_id, ElementId}
                                                                        ,{drop_parent,DropParent}
                                                                        ,{switch,Switch}]
                                                        ,Context)
                                     ,Context),
            cf_set_session('current_callflow', z_string:split(ElementId,"-")++["module"], ?TO_BIN(ToolName), Context),
            cf_set_session('current_callflow', z_string:split(ElementId,"-")++["children"], {[]}, Context),
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
    ElementPath = lists:map(fun (K) -> ?TO_BIN(K) end, z_string:split(BranchId,"-")),
    lager:info("cf_may_be_add_desc_child ElementPath: ~p",[ElementPath]),
    case modkazoo_util:get_value(ElementPath++[<<"children">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> Context;
        {[]} -> Context;
        Children ->
            lists:foldl(fun(Switch, ContextAcc) -> cf_add_desc_child(BranchId,DropId,DropParent,Switch,ContextAcc) end
                       ,Context
                       ,modkazoo_util:get_keys(Children))
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
    ElementPath = lists:map(fun (K) -> ?TO_BIN(K) end, z_string:split(BranchId,"-")),
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
            [Id,<<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary
                 ,<<" ">>/binary
                 ,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>];
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
            [Id,<<(modkazoo_util:get_value_bin(<<"first_name">>,UserDoc))/binary
                 ,<<" ">>/binary
                 ,(modkazoo_util:get_value_bin(<<"last_name">>,UserDoc))/binary>>];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"ring_group">> ->
    Name = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"name">>],z_context:get_session('current_callflow', Context)),
    ['undefined', Name];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"page_group">> ->
    Name = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"name">>],z_context:get_session('current_callflow', Context)),
    ['undefined', Name];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"cidlistmatch">> ->
    ListId = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    List = kz_get_account_list(ListId, Context),
    [ListId, modkazoo_util:get_value(<<"name">>,List)];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"check_cid">> ->
    case modkazoo_util:get_value(ModulePath++[<<"data">>,<<"use_absolute_mode">>],z_context:get_session('current_callflow', Context)) of
        'true' -> ['undefined', <<"Exact numbers">>];
        'false' -> ['undefined', <<"Regex match">>];
        _ -> ['undefined', undefined]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"prepend_cid">> ->
    CallerIdNamePrefix = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"caller_id_name_prefix">>]
                                                ,z_context:get_session('current_callflow', Context)),
    CallerIdNumberPrefix = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"caller_id_number_prefix">>]
                                                  ,z_context:get_session('current_callflow', Context)),
    ['undeined',[CallerIdNamePrefix ,CallerIdNumberPrefix]];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"set_cid">> ->
    CallerIdNamePrefix = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"caller_id_name">>]
                                                ,z_context:get_session('current_callflow', Context)),
    CallerIdNumberPrefix = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"caller_id_number">>]
                                                  ,z_context:get_session('current_callflow', Context)),
    ['undeined',[CallerIdNamePrefix ,CallerIdNumberPrefix]];
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
                         case modkazoo_util:get_value(ModulePath++[<<"data">>,X],Callflow) of
                             'undefined' -> J++[];
                             Id -> J++[{Id,X}]
                         end
                     end
                    ,[]
                    ,[<<"device_id">>,<<"user_id">>,<<"group_id">>])
    of
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
            <<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary
             ,<<" ">>/binary
             ,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>
    end.
    
cf_delete_element(ElementId,Context) ->
    modkazoo_util:delete_session_jobj_key('current_callflow', cf_element_path(ElementId), Context).
    
cf_park_element(ElementId,Context) ->
    ParkCandidate = modkazoo_util:get_value(cf_element_path(ElementId), z_context:get_session('current_callflow', Context)),
    z_context:set_session('cf_park_slot1', ParkCandidate, Context),
    z_render:growl(?__("Branch saved", Context), Context).

cf_element_path(ElementId) ->
    lists:map(fun (K) -> ?TO_BIN(K) end, z_string:split(ElementId,"-")).

cf_get_element_by_id(ElementId, Context) ->
    modkazoo_util:get_value(cf_element_path(ElementId), z_context:get_session('current_callflow', Context)). 

cf_handle_drop({drop,{dragdrop,{drag_args,[{tool_name,ToolName}]},mod_kazoo,_}
                    ,{dragdrop,{drop_args,[{drop_id,DropId},{drop_parent,DropParent}]},mod_kazoo,BranchId}}
              ,Context) ->
    lager:info("Drop DropParent: ~p",[DropParent]),
    case z_convert:to_list(DropParent) of
        "cidlistmatch" ->
            lager:info("Drop BranchId: ~p",[BranchId]),
            [KeysList,AddOn] = [[<<"match">>,<<"nomatch">>],[]],
            case cf_available_keys(KeysList,cf_element_path(BranchId),AddOn,Context) of
                [] -> z_render:growl_error(?__("No routing keys left.",Context), Context); 
                AvailableKeys ->
                    z_render:dialog(?__("Choose route option",Context)
                                   ,"_cf_select_option_cidlistmatch.tpl"
                                   ,[{tool_name,ToolName}
                                    ,{drop_id,DropId}
                                    ,{drop_parent,DropParent}
                                    ,{branch_id,BranchId}
                                    ,{available_keys,AvailableKeys}
                                    ]
                                   ,Context)
            end;
        "check_cid" ->
            lager:info("Drop BranchId: ~p",[BranchId]),
            [KeysList,AddOn] =
                case modkazoo_util:get_value(cf_element_path(BranchId)++[<<"data">>,<<"use_absolute_mode">>]
                                            ,z_context:get_session('current_callflow', Context))
                of
                    'false' -> [[<<"nomatch">>,<<"match">>],[]];
                    'true' -> [[<<"nomatch">>],[<<"caller_id">>]] 
                end,
            case cf_available_keys(KeysList,cf_element_path(BranchId),AddOn,Context) of
                [] -> z_render:growl_error(?__("No routing keys left.",Context), Context); 
                AvailableKeys ->
                    z_render:dialog(?__("Choose route option",Context)
                                         ,"_cf_select_option_check_cid.tpl"
                                         ,[{tool_name,ToolName}
                                          ,{drop_id,DropId}
                                          ,{drop_parent,DropParent}
                                          ,{branch_id,BranchId}
                                          ,{available_keys,AvailableKeys}]
                                         ,Context)
            end;
        "menu" ->
            lager:info("Drop BranchId: ~p",[BranchId]),
            z_render:dialog(?__("Menu option",Context)
                                 ,"_cf_select_option.tpl"
                                 ,[{tool_name,ToolName}
                                  ,{drop_id,DropId}
                                  ,{drop_parent,DropParent}
                                  ,{branch_id,BranchId}
                                  ,{available_keys,cf_available_keys(?MENU_KEYS_LIST,cf_element_path(BranchId),Context)}]
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
            cf_child([{tool_name,ToolName},{drop_id,DropId},{drop_parent,DropParent},{branch_id,BranchId},{switch,Switch}],Context)
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
        "cidlistmatch" ->
            [KeysList,AddOn] = [[<<"match">>,<<"nomatch">>],[]],
            z_render:dialog(?__("Choose route option",Context)
                               ,"_cf_select_option_cidlistmatch.tpl"
                               ,[{existing_element_id,ExistingElementId}
                                ,{switch,hd(lists:reverse(cf_element_path(ExistingElementId)))}
                                ,{available_keys,cf_available_keys(KeysList
                                                                  ,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))
                                                                  ,AddOn
                                                                  ,Context)}
                                ]
                               ,Context);
        "check_cid" ->
            lager:info("Drop ExistingElementId: ~p",[ExistingElementId]),
            lager:info("Drop TL: ~p",[lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))]),
            lager:info("Switch: ~p",[hd(lists:reverse(cf_element_path(ExistingElementId)))]),
            [KeysList,AddOn] =
                case modkazoo_util:get_value(lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))
                                               ++[<<"data">>,<<"use_absolute_mode">>]
                                            ,z_context:get_session('current_callflow', Context))
                of
                    'false' -> [[<<"nomatch">>,<<"match">>],[]];
                    'true' -> [[<<"nomatch">>],[<<"caller_id">>]]
                end,
            z_render:dialog(?__("Choose route option",Context)
                                 , "_cf_select_option_check_cid.tpl"
                                 ,[{existing_element_id,ExistingElementId}
                                 ,{switch,hd(lists:reverse(cf_element_path(ExistingElementId)))}
                                 ,{available_keys,cf_available_keys(KeysList
                                                                   ,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))
                                                                   ,AddOn
                                                                   ,Context)}]
                                 ,Context);
        "menu" ->
            z_render:dialog(?__("Menu option",Context)
                               , "_cf_select_option.tpl"
                               ,[{existing_element_id,ExistingElementId}
                                ,{kz_element_id,hd(lists:reverse(modkazoo_util:split_b(ExistingElementId,"-")))}
                                ,{available_keys,cf_available_keys(?MENU_KEYS_LIST
                                                                  ,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))
                                                                  ,Context)}]
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
    StartDate = calendar:datetime_to_gregorian_seconds({{z_convert:to_integer(StartYear)
                                                        ,z_convert:to_integer(StartMonth)
                                                        ,z_convert:to_integer(StartDay)}
                                                        ,{0,0,0}}),
    Id = z_context:get_q("id",Context),
    Props = [{<<"time_window_start">>, ?TO_BIN(TimeWindowStart)}
            ,{<<"time_window_stop">>, ?TO_BIN(TimeWindowStop)}
            ,{<<"wdays">>, case Wdays of 'undefined' -> 'undefined'; _ -> lists:map(fun(Wday) -> ?TO_BIN(Wday) end, Wdays) end}
            ,{<<"days">>, case Days of 'undefined' -> 'undefined'; _ -> lists:map(fun(Day) -> ?TO_BIN(Day) end, [Days]) end}
            ,{<<"interval">>, ?TO_BIN(z_context:get_q("interval",Context))}
            ,{<<"cycle">>, ?TO_BIN(z_context:get_q("cycle",Context))}
            ,{<<"name">>, ?TO_BIN(z_context:get_q("name",Context))}
            ,{<<"type">>, ?TO_BIN(z_context:get_q("type",Context))}
            ,{<<"start_date">>, StartDate}
            ,{<<"id">>, ?TO_BIN(Id)}
            ,{<<"enabled">>, z_convert:to_atom(z_context:get_q("enabled",Context))}
            ,{<<"ordinal">>, ?TO_BIN(z_context:get_q("ordinal",Context))}
            ,{<<"month">>, ?TO_BIN(z_context:get_q("month",Context))}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

cf_delete_time_of_the_day_rule(RuleId,Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary, "/", ?TO_BIN(RuleId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

upload_media(Context) ->
    try
        PromptName = case z_context:get_q("promptname", Context) of
            [] ->
               throw(no_name_entered);
            PromptNameStr ->
               ?TO_BIN(PromptNameStr)
        end,
        case z_context:get_q("promptfile", Context) of
            {upload, UploadFilename, UploadTmp, _, _} ->
                false = modkazoo_util:check_file_size_exceeded(promptfile, UploadTmp, 15000000),
                Result = set_media_doc(z_context:get_q("prompt_id", Context), PromptName, ?TO_BIN(UploadFilename), Context),
                set_media_attachment(modkazoo_util:get_value(<<"id">>, Result), UploadFilename, UploadTmp, Context);
            _ ->
                case z_context:get_q("existing_description", Context) of
                    'undefined' -> throw(no_document_uploaded);
                    ExistingDescr ->  
                        set_media_doc(z_context:get_q("prompt_id", Context), PromptName, ExistingDescr, Context)
                end
        end,
        mod_signal:emit({update_admin_portal_media_list_tpl, ?SIGNAL_FILTER(Context)}, Context),
        z_render:dialog_close(Context)
    catch
        no_name_entered ->
            z_render:growl_error(?__("No name entered",Context), Context);
        no_document_uploaded ->
            z_render:growl_error(?__("No document chosen",Context), Context);
        error:{badmatch, {true, promptfile}} ->
            z_render:growl_error(?__("Maximum file size exceeded. Please try to upload smaller file.",Context), Context);
        E1:E2 ->
            lager:info("Error. E1: ~p E2: ~p", [E1, E2]),
            z_render:growl_error(?__("Something wrong happened.",Context), Context)
    end.

set_media_doc(Id, PromptName, Description, Context) ->
    Props =  [{<<"streamable">>,true}
             ,{<<"name">>, ?TO_BIN(PromptName)}
             ,{<<"media_source">>, <<"upload">>}
             ,{<<"id">>, ?TO_BIN(Id)}
             ,{<<"description">>, ?TO_BIN(Description)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.
  
set_media_attachment(Id, UploadFilename, UploadTmp, Context) ->
    {ok, Data} = file:read_file(UploadTmp),
    {ok, IdnProps} = z_media_identify:identify(UploadTmp, UploadFilename, Context),
    Mime = proplists:get_value(mime, IdnProps),
    API_String_Raw = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary, "/", ?TO_BIN(Id)/binary, ?RAW/binary>>,
    Headers = [{"Content-Type",Mime}],
    crossbar_account_send_raw_request('post', API_String_Raw, Headers, Data, Context).

kz_delete_prompt(PromptId,Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary, "/", ?TO_BIN(PromptId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_get_account_prompt(PromptId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary, "/", ?TO_BIN(PromptId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_get_account_prompt_attachment(PromptId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?MEDIA/binary, "/", ?TO_BIN(PromptId)/binary, ?RAW/binary>>,
    crossbar_account_attachment_request('get', API_String, [], Context).

kz_list_account_conferences(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CONFERENCES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_c2calls(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CLICKTOCALL/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_vmbox(Context) ->
    Id = z_context:get_q("vmbox_id",Context),
    Props = [{<<"name">>, ?TO_BIN(z_context:get_q("name", Context))}
            ,{<<"mailbox">>, ?TO_BIN(z_context:get_q("mailbox", Context))}
            ,{<<"pin">>, ?TO_BIN(z_context:get_q("pin", Context))}
            ,{<<"owner_id">>, ?TO_BIN(z_context:get_q("owner_id", Context))}
            ,{<<"media">>, case z_context:get_q("unavailable_message_id", Context) of
                               [] -> 'undefined';
                               MessageId -> {[{<<"unavailable">>, ?TO_BIN(MessageId)}]}
                           end
             }
            ,{<<"timezone">>, ?TO_BIN(z_context:get_q("vmbox_timezone", Context))}
            ,{<<"is_setup">>, modkazoo_util:on_to_true(z_context:get_q("is_setup", Context))}
            ,{<<"require_pin">>, modkazoo_util:on_to_true(z_context:get_q("require_pin", Context))}
            ,{<<"check_if_owner">>, modkazoo_util:on_to_true(z_context:get_q("check_if_owner", Context))}
            ,{<<"skip_greeting">>, modkazoo_util:on_to_true(z_context:get_q("skip_greeting", Context))}
            ,{<<"skip_instructions">>, modkazoo_util:on_to_true(z_context:get_q("skip_instructions", Context))}
            ,{<<"delete_after_notify">>, modkazoo_util:on_to_true(z_context:get_q("delete_after_notify", Context))}
            ,{<<"id">>, ?TO_BIN(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_vmbox(Verb, VMBoxId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

vmbox_messages(Verb, VMBoxId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary, ?MESSAGES/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

vmbox_message(Verb, MessageId, VMBoxId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?VMBOXES/binary, "/", ?TO_BIN(VMBoxId)/binary
                  ,?MESSAGES/binary, "/", ?TO_BIN(MessageId)/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

kz_conference(Context) ->
    Id = z_context:get_q("conference_id",Context),
    Numbers = lists:map(fun (K) -> re:replace(K, "[^A-Za-z0-9]", "", [global, {return, binary}]) end
                       ,z_string:split(z_context:get_q("numbers", Context),",")),
    Pins = lists:map(fun (K) -> re:replace(K, "[^A-Za-z0-9]", "", [global, {return, binary}]) end
                    ,z_string:split(z_context:get_q("pins", Context),",")),
    Props = [{<<"name">>, ?TO_BIN(z_context:get_q("conference_name", Context))}
            ,{<<"member">>, {[{<<"numbers">>, case Numbers of [<<>>] -> []; _ -> Numbers end}
                            ,{<<"pins">>, case Pins of [<<>>] -> []; _ -> Pins end}
                            ,{<<"join_muted">>, modkazoo_util:on_to_true(z_context:get_q("join_muted", Context))}
                            ,{<<"join_deaf">>, modkazoo_util:on_to_true(z_context:get_q("join_deaf", Context))}]}}
            ,{<<"owner_id">>, ?TO_BIN(z_context:get_q("owner_id", Context))}
            ,{<<"play_name">>, modkazoo_util:on_to_true(z_context:get_q("play_name", Context))}
            ,{<<"moderator">>, {[{<<"numbers">>, []}
                            ,{<<"pins">>, []}
                            ,{<<"join_muted">>, 'false'}
                            ,{<<"join_deaf">>, 'false'}]}}
            ,{<<"conference_numbers">>, []}
            ,{<<"id">>, ?TO_BIN(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CONFERENCES/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CONFERENCES/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_conference(Verb, ConferenceId,Context) ->
    kz_conference(Verb, ConferenceId, [], Context).

kz_conference(Verb, ConferenceId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CONFERENCES/binary, "/", ?TO_BIN(ConferenceId)/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_conference_participant(ParticipantId, ConferenceId, Context) ->
    kz_conference_participant('get', ParticipantId, ConferenceId, [], Context).

kz_conference_participant(Verb, ParticipantId, ConferenceId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?CONFERENCES/binary, "/", ?TO_BIN(ConferenceId)/binary,
                                                          ?PARTICIPANTS/binary, "/", ?TO_BIN(ParticipantId)/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_conference_participants(ConferenceId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?CONFERENCES/binary, "/", ?TO_BIN(ConferenceId)/binary, ?PARTICIPANTS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

dedup_kz_conference_participants(ConferenceId,Context) ->
    case kz_conference_participants(ConferenceId,Context) of
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

start_outbound_conference(Context) ->
    ConferenceId = z_context:get_q('conference_selector', Context),
    SelectedListId = z_context:get_q('selected_list', Context),
    SelectedMedia = z_context:get_q('selected_media', Context),
    start_outbound_conference(SelectedListId, ConferenceId, SelectedMedia, Context).

start_outbound_conference([], _, _, Context) ->
    z_render:growl_error(?__("No participants list chosen.",Context), Context);
start_outbound_conference(_, [], _, Context) ->
    z_render:growl_error(?__("No conference chosen.",Context), Context);
start_outbound_conference(ListId, ConferenceId, MediaId, Context) ->
    UserId = z_context:get_session('kazoo_owner_id', Context),
    NumbersList = [modkazoo_util:get_value([<<"value">>,<<"number">>],JObj) || JObj <- kz_list_account_list_entries(ListId, Context)],
    [add_cccp_autodial(ParticipantNumber, ConferenceId, UserId, MediaId, Context) || ParticipantNumber <- NumbersList],
    z_render:growl(?__("Attempt sent.",Context), Context).

add_conf_participant(Context) ->
    ConferenceId = z_context:get_q('conference_selector', Context),
    ParticipantNumber = z_context:get_q('a_leg_number', Context),
    SelectedMedia = z_context:get_q('selected_media', Context),
    add_conf_participant(ParticipantNumber, ConferenceId, SelectedMedia, Context).

add_conf_participant([], _, _, Context) ->
    z_render:growl_error(?__("No participant number filled in.",Context), Context);
add_conf_participant(_, [], _, Context) ->
    z_render:growl_error(?__("No conference chosen.",Context), Context);
add_conf_participant(ParticipantNumber, ConferenceId, MediaId, Context) ->
    UserId = z_context:get_session('kazoo_owner_id', Context),
    add_cccp_autodial(ParticipantNumber, ConferenceId, UserId, MediaId, Context),
    z_render:growl(?__("Attempt sent.",Context), Context).

do_conference_action(Action, ConferenceId, Context) ->
    DataBag = ?MK_DATABAG(?CONFERENCE_ACTION(Action)),
    kz_conference('put', ConferenceId, DataBag, Context).

do_conference_participant_action(Action, ParticipantId, ConferenceId, Context) ->
    DataBag = ?MK_DATABAG(?CONFERENCE_ACTION(Action)),
    kz_conference_participant('put', ParticipantId, ConferenceId, DataBag, Context).

maybe_update_conference_participants_headline("add-member", ConferenceId, Context) ->
    case current_conference_participants_number(ConferenceId, Context) of
        1 -> mod_signal:emit({update_conference_participants_headline, ?SIGNAL_FILTER(Context)}, Context);
        _ -> 'ok'
    end;
maybe_update_conference_participants_headline("del-member", ConferenceId, Context) ->
    case current_conference_participants_number(ConferenceId, Context) of
        0 -> mod_signal:emit({update_conference_participants_headline, ?SIGNAL_FILTER(Context)}, Context);
        _ -> 'ok'
    end.

current_conference_participants_number(ConferenceId, Context) ->
    ConferenceDetails = kz_conference('get', ConferenceId, Context),
    modkazoo_util:get_value_integer([<<"_read_only">>,<<"moderators">>], ConferenceDetails)
    +
    modkazoo_util:get_value_integer([<<"_read_only">>,<<"members">>], ConferenceDetails).

kz_c2call(Context) ->
    Id = z_context:get_q("c2call_id",Context),
    Props = [{<<"name">>, ?TO_BIN(z_context:get_q("name", Context))}
            ,{<<"auth_required">>, modkazoo_util:on_to_true(z_context:get_q("auth_required", Context))}
            ,{<<"dial_first">>, ?TO_BIN(z_context:get_q("dial_first", Context))}
            ,{<<"extension">>, ?TO_BIN(z_context:get_q("extension", Context))}
            ,{<<"caller_id_number">>, ?TO_BIN(z_context:get_q("caller_id_number", Context))}
            ,{<<"outbound_callee_id_number">>, ?TO_BIN(z_context:get_q("caller_id_number", Context))}
            ,{<<"id">>, ?TO_BIN(Id)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CLICKTOCALL/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CLICKTOCALL/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_c2call(Verb, C2CallId,Context) ->
    kz_c2call(Verb, C2CallId, [], Context).

kz_c2call(Verb, C2CallId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CLICKTOCALL/binary, "/", ?TO_BIN(C2CallId)/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_c2call_hyperlink(C2CallId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CLICKTOCALL/binary, "/", ?TO_BIN(C2CallId)/binary, ?CONNECT/binary>>,
    Crossbar_URL = m_config:get_value('mod_kazoo', 'kazoo_crossbar_url', Context),
    <<Crossbar_URL/binary, API_String/binary>>.

kz_get_featurecode_by_name(FCName, Context) ->
    case lists:filter(fun(X) -> ?TO_BIN(FCName) == modkazoo_util:get_value([<<"featurecode">>,<<"name">>],X) end, kz_list_account_callflows(Context)) of
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
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"id">>], ?TO_BIN(ListId), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"dynamic_cid">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*69([0-9]{2,})$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"69">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"dynamic_cid">>, J) end],
    update_featurecode(<<"dynamic_cid">>, Routines, Context).

set_featurecode_eavesdrop(ApprovedGroupId, TargetGroupId, Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"module">>], <<"eavesdrop_feature">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"name">>], <<"eavesdrop_feature">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"patterns">>], [<<"^\\*68([0-9]{2,})$">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"featurecode">>, <<"number">>], <<"68">>, J) end
                ,fun(J) -> case ApprovedGroupId of
                               [] -> 
                                   modkazoo_util:delete_key([<<"flow">>,<<"data">>,<<"approved_group_id">>], J);
                               _ -> 
                                   modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"approved_group_id">>], ?TO_BIN(ApprovedGroupId), J)
                           end
                 end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>,<<"data">>,<<"group_id">>], ?TO_BIN(TargetGroupId), J) end],
    update_featurecode(<<"eavesdrop_feature">>, Routines, Context).

update_featurecode(FeatureCodeName, Routines, Context) ->
    case kz_get_featurecode_by_name(FeatureCodeName, Context) of
        [] -> kz_account_create_callflow(Routines, Context);
        JObj -> 
            CallflowId = modkazoo_util:get_value(<<"id">>,JObj),
            CurrDoc = kz_get_account_callflow(CallflowId, Context),
            APIString = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", CallflowId/binary>>,
            DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, CurrDoc, Routines)),
            crossbar_account_request('post', APIString, DataBag, Context)
    end.

toggle_featurecode_voicemail_check(Context) ->
    case kz_get_featurecode_by_name(<<"voicemail[action=check]">>, Context) of
        [] -> kz_add_featurecode_voicemail_check(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_voicemail_direct(Context) ->
    case kz_get_featurecode_by_name(<<"voicemail[action=\"direct\"]">>, Context) of
        [] -> kz_add_featurecode_voicemail_direct(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_park_and_retrieve(Context) ->
    case kz_get_featurecode_by_name(<<"park_and_retrieve">>, Context) of
        [] -> kz_add_featurecode_park_and_retrieve(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_park_valet(Context) ->
    case kz_get_featurecode_by_name(<<"valet">>, Context) of
        [] -> kz_add_featurecode_park_valet(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_park_retrieve(Context) ->
    case kz_get_featurecode_by_name(<<"retrieve">>, Context) of
        [] -> kz_add_featurecode_park_retrieve(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_intercom(Context) ->
    case kz_get_featurecode_by_name(<<"intercom">>, Context) of
        [] -> kz_add_featurecode_intercom(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_privacy(Context) ->
    case kz_get_featurecode_by_name(<<"privacy[mode=full]">>, Context) of
        [] -> kz_add_featurecode_privacy(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_hotdesk_enable(Context) ->
    case kz_get_featurecode_by_name(<<"hotdesk[action=login]">>, Context) of
        [] -> kz_add_featurecode_hotdesk_enable(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_hotdesk_disable(Context) ->
    case kz_get_featurecode_by_name(<<"hotdesk[action=logout]">>, Context) of
        [] -> kz_add_featurecode_hotdesk_disable(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_hotdesk_toggle(Context) ->
    case kz_get_featurecode_by_name(<<"hotdesk[action=toggle]">>, Context) of
        [] -> kz_add_featurecode_hotdesk_toggle(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_activate(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=activate]">>, Context) of
        [] -> kz_add_featurecode_call_forward_activate(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_deactivate(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=deactivate]">>, Context) of
        [] -> kz_add_featurecode_call_forward_deactivate(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_toggle(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=toggle]">>, Context) of
        [] -> kz_add_featurecode_call_forward_toggle(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

toggle_featurecode_call_forward_update(Context) ->
    case kz_get_featurecode_by_name(<<"call_forward[action=update]">>, Context) of
        [] -> kz_add_featurecode_call_forward_update(Context);
        JObj -> 
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
            crossbar_account_request('delete', API_String, [], Context)
    end.

delete_featurecode(CodeName, Context) ->
    JObj = kz_get_featurecode_by_name(CodeName, Context),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>,JObj))/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

toggle_blacklist_member(BlacklistId,Context) ->
    Blacklists = case kz_account_doc_field(<<"blacklists">>, Context) of
        'undefined' -> [];
        Value -> Value
    end,
    case lists:member(BlacklistId, Blacklists) of
        'true' -> kz_set_acc_doc(<<"blacklists">>, lists:usort(Blacklists)--[BlacklistId,<<"undefined">>], Context); 
        'false' -> kz_set_acc_doc(<<"blacklists">>, lists:usort(Blacklists++[BlacklistId])--[<<"undefined">>], Context) 
    end.

kz_get_account_blacklist(BlacklistId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?BLACKLISTS/binary, "/", ?TO_BIN(BlacklistId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

set_blacklist_doc(Id, Name, Nums, Context) ->
    Props =  [{<<"name">>, ?TO_BIN(Name)}
             ,{<<"id">>, ?TO_BIN(Id)}
             ,{<<"numbers">>, ?JSON_WRAPPER(lists:map(fun(X) -> {?TO_BIN(modkazoo_util:cleanout(X))
                                                                ,modkazoo_util:set_value(<<"description">>, modkazoo_util:get_q_bin(X, Context), ?EMPTY_JSON_OBJECT)}
                                                      end
                                           ,Nums))
              }
             ],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?BLACKLISTS/binary>>,
            crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?BLACKLISTS/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, DataBag, Context)
    end.

kz_delete_blacklist(BlacklistId,Context) ->
    kz_set_acc_doc(<<"blacklists">>, lists:usort(kazoo_util:kz_account_doc_field(<<"blacklists">>, Context))--[BlacklistId,<<"undefined">>], Context),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?BLACKLISTS/binary, "/", ?TO_BIN(BlacklistId)/binary>>,
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
                     mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context)
            end;
        "false" ->
            case modkazoo_util:get_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>,<<"nomatch">>], z_context:get_session('current_callflow', Context)) of
                'undefined' -> 
                    z_context:set_session('current_callflow', modkazoo_util:set_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>], ?EMPTY_JSON_OBJECT, CurrentCallflow), Context),
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context);
                NoMatch -> 
                    Childless = modkazoo_util:set_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>], ?EMPTY_JSON_OBJECT, CurrentCallflow),
                    z_context:set_session('current_callflow', modkazoo_util:set_value(modkazoo_util:split_b(ElementId,"-")++[<<"children">>,<<"nomatch">>], NoMatch, Childless), Context),
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context)
            end
    end.

rs_delete_account(AccountId,Context) ->
    _ = delete_account(AccountId,Context),
    _ = z_context:set_session('rs_selected_account_id', 'undefined', Context),
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
            record_call_doc_id(Context);
        [Cf|_] -> 
            modkazoo_util:get_value(<<"id">>,Cf)
    end.

create_record_call_callflow(Context) ->
    Routines = [fun(J) -> modkazoo_util:set_value([<<"name">>], <<"record_call">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"numbers">>], [<<"record_call">>], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"contact_list">>, <<"exclude">>], true, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"module">>], <<"record_call">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"action">>], <<"start">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"url">>], <<>>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"format">>], <<"mp3">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"flow">>, <<"data">>, <<"time_limit">>], <<"6000">>, J) end],
    DataBag = ?MK_DATABAG(lists:foldl(fun(F, J) -> F(J) end, ?EMPTY_CALLFLOW, Routines)),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary>>,
    crossbar_account_request('put', API_String, DataBag, Context).

kz_cccp_creds_list(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CCCPS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

add_cccp_doc(Field1, Field2, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CCCPS/binary>>,
    DataBag = {[{<<"data">>, {[Field1, Field2, {<<"active">>, true}]}}]},
    crossbar_account_request('put', API_String, DataBag, Context).

add_cccp_autodial(ALegNumber, BLegNumber, UserId, MediaId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CCCPS/binary, ?AUTODIAL/binary>>,
    Payload = modkazoo_util:filter_empty([{<<"a_leg_number">>, ?TO_BIN(ALegNumber)}
                                         ,{<<"b_leg_number">>, ?TO_BIN(BLegNumber)}
                                         ,{<<"user_id">>, ?TO_BIN(UserId)}
                                         ,{<<"media_id">>, ?TO_BIN(MediaId)}
                                         ,{<<"retain_cid">>, 'true'}
                                         ,{<<"callback_delay">>, 1}]),
    crossbar_account_request('put', API_String, ?MK_DATABAG({Payload}), Context).

del_cccp_doc(DocId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CCCPS/binary, "/", ?TO_BIN(DocId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

get_cccp_doc(DocId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CCCPS/binary, "/", ?TO_BIN(DocId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

cccp_field_toggler(DocId, FieldName, Context) ->
    CurrDoc = get_cccp_doc(DocId, Context),
    NewDoc = case modkazoo_util:get_value(?TO_BIN(FieldName), CurrDoc) of
        'true' -> modkazoo_util:set_value(?TO_BIN(FieldName), 'false', CurrDoc);
        _ -> modkazoo_util:set_value(?TO_BIN(FieldName), 'true', CurrDoc)
    end,
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CCCPS/binary, "/", ?TO_BIN(DocId)/binary>>,
    crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context).

kz_find_account_by_number(Number, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?PHONE_NUMBERS/binary, "/", ?TO_BIN(Number)/binary, ?IDENTIFY/binary>>,
    modkazoo_util:get_value(<<"account_id">>, crossbar_account_request('get', API_String, [], Context)).

kz_admin_find_accountname_by_number(Number, Context) ->
    modkazoo_util:get_value(<<"name">>,kz_adminget_acc_doc_by_account_id(kz_admin_get_account_by_number(Number, Context),Context)).

kz_admin_get_account_by_number(Number, Context) ->
    {'ok', {'account_id', AccountId}, {'auth_token', AuthToken}, {'crossbar', CrossbarURL}} = kz_admin_creds(Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?PHONE_NUMBERS/binary, "/", ?TO_BIN(Number)/binary, ?IDENTIFY/binary>>,
    URL = z_convert:to_list(<<CrossbarURL/binary, API_String/binary>>),
    {'ok', _, _, Body} = ibrowse:send_req(URL, req_headers(AuthToken), 'get', [], [], 10000),
    modkazoo_util:get_value([<<"data">>,<<"account_id">>], jiffy:decode(Body)).

list_account_trunks(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    list_account_trunks(AccountId, Context).

list_account_trunks(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CONNECTIVITY/binary>>,
    crossbar_account_request('get', API_String, [], Context).

check_trunk_name_field(TrunkDoc, Context) ->
    case modkazoo_util:get_value(<<"name">>, TrunkDoc) of
        'undefined' -> modkazoo_util:set_value(<<"name">>, <<(get_account_name(Context))/binary, " Trunkstore">>, TrunkDoc);
        _ -> TrunkDoc
    end.

kz_trunk_server(Context) ->
    TrunkId = case z_context:get_q("trunk_id",Context) of
             'undefined' ->
                 case list_account_trunks(Context) of
                     [] ->
                         DataBag = ?MK_DATABAG({[{<<"account">>, {[{<<"credits">>,{[{<<"prepay">>,<<"0.00">>}]}}
                                                                  ,{<<"trunks">>,<<"0">>}
                                                                  ,{<<"inbound_trunks">>,<<"0">>}
                                                                  ,{<<"auth_realm">>,get_account_realm(Context)}
                                                                  ]}}
                                                ,{<<"name">>, <<(get_account_name(Context))/binary, " Trunkstore">>}
                                                ,{<<"servers">>, []}
                                                ]}),
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
    kz_trunk('post', TrunkId, ?MK_DATABAG(check_trunk_name_field(NewTrunkDoc, Context)), Context).

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
    kz_trunk('post', TrunkId, ?MK_DATABAG(check_trunk_name_field(NewTrunkDoc, Context)), Context).

kz_trunk_server_numbers(Context) ->
    case z_context:get_q("trunk_id",Context) of
        'undefined' -> ok;
        TrunkId ->
            TS_Numbers = case z_context:get_q_all("ts_number",Context) of
                [] -> {[]};
                NumbersList -> ?JSON_WRAPPER(lists:map(fun(Number) -> {?TO_BIN(Number), ?EMPTY_JSON_OBJECT} end, NumbersList))
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
            API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CONNECTIVITY/binary, "/", ?TO_BIN(TrunkId)/binary>>,
            crossbar_account_request(Verb, API_String, [], Context);
        'put' -> 
            API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CONNECTIVITY/binary>>,
            crossbar_account_request(Verb, API_String, DataBag, Context);
        'post' ->
            API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CONNECTIVITY/binary, "/", ?TO_BIN(TrunkId)/binary>>,
            crossbar_account_request(Verb, API_String, DataBag, Context);
        _ -> 'ok'
    end.

get_trunk_doc_field(K, TrunkId, AccountId, Context) ->
    modkazoo_util:get_value(K, kz_trunk('get', TrunkId, AccountId, [], Context)).

set_trunk_doc_field(K, V, TrunkId, AccountId, Context) ->
    TrunkDoc = kz_trunk('get', TrunkId, AccountId, [], Context),
    kz_trunk('post', TrunkId, AccountId, ?MK_DATABAG(modkazoo_util:set_value(K, V, TrunkDoc)), Context).

list_trunks_realm(?MATCH_ACCOUNT_RAW(AccountId), Context) ->
    [get_trunk_doc_field([<<"account">>,<<"auth_realm">>], TrunkId, AccountId, Context) || TrunkId <- list_account_trunks(AccountId, Context)];
list_trunks_realm(_, _) -> [].

sync_trunkstore_realm(TrunkId, AccountId, Context) ->
    AccountRealm = get_account_realm(AccountId, Context),
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
                ,fun(J) -> modkazoo_util:set_value([<<"options">>,<<"inbound_format">>], ?TO_BIN(z_context:get_q("inbound_format",Context)), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"auth">>,<<"auth_method">>], ?TO_BIN(z_context:get_q("auth_method",Context)), J) end
                ,fun(J) -> case z_context:get_q("auth_trunk_user",Context) of
                               'undefined' -> J;
                               User -> modkazoo_util:set_value([<<"auth">>,<<"auth_user">>], ?TO_BIN(User), J)
                           end
                 end
                ,fun(J) -> case z_context:get_q("auth_password",Context) of
                               'undefined' -> J;
                               Pwd -> modkazoo_util:set_value([<<"auth">>,<<"auth_password">>], ?TO_BIN(Pwd), J)
                           end
                 end
                ,fun(J) -> case z_context:get_q("ipaddress",Context) of 'undefined' -> J; Ip -> modkazoo_util:set_value([<<"auth">>,<<"ip">>], ?TO_BIN(Ip), J) end end
                ,fun(J) -> case z_context:get_q("ipaddress",Context) of 'undefined' -> J; Ip -> modkazoo_util:set_value([<<"options">>,<<"ip">>], ?TO_BIN(Ip), J) end end
                ,fun(J) -> modkazoo_util:set_value([<<"server_name">>], ?TO_BIN(z_context:get_q("server_name",Context)), J) end],
    lists:foldl(fun(F, J) -> F(J) end, Server, Routines).

kz_list_account_webhooks(Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?WEBHOOKS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_webhook_info(WebhookId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?WEBHOOKS/binary, "/", ?TO_BIN(WebhookId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_webhook_delete(WebhookId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?WEBHOOKS/binary, "/", ?TO_BIN(WebhookId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_webhook_toggle(WebhookId, Context) ->
    CurrDoc = kz_webhook_info(WebhookId, Context),
    NewDoc = case modkazoo_util:get_value(<<"enabled">>, CurrDoc) of
        'true' -> modkazoo_util:set_value(<<"enabled">>, 'false', CurrDoc);
        'false' -> modkazoo_util:set_value(<<"enabled">>, 'true', CurrDoc)
    end,
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?WEBHOOKS/binary, "/", ?TO_BIN(WebhookId)/binary>>,
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
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?WEBHOOKS/binary>>,
            crossbar_account_request('put', API_String, ?MK_DATABAG(NewDoc), Context);
        Id ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?WEBHOOKS/binary, "/", ?TO_BIN(Id)/binary>>,
            crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context)
    end.

filter_custom_fields({"custom_key_" ++ T, Key}, Context) ->
    fun(J) -> modkazoo_util:set_value([<<"custom_data">>,?TO_BIN(Key)], modkazoo_util:get_q_bin(T,Context), J) end;
filter_custom_fields(_, _Context) ->
    fun(J) -> J end.

kz_current_context_reseller_status(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_reseller_status(AccountId, Context).

kz_reseller_status(AccountId, Context) ->
    modkazoo_util:get_value(<<"is_reseller">>, kz_get_acc_doc_by_account_id(AccountId, Context)).

kz_current_context_reseller_id(Context) ->
    modkazoo_util:get_value(<<"reseller_id">>, kz_get_acc_doc(Context)).

kz_current_context_superadmin(Context) ->
    modkazoo_util:get_value(<<"superduper_admin">>, kz_get_acc_doc(Context)).

kz_callflows_numbers(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_callflows_numbers(AccountId, Context).

kz_callflows_numbers(AccountId, Context) ->
    lists:foldl(fun(X,Acc) -> modkazoo_util:get_value([<<"numbers">>],X) ++ Acc end, [], kz_list_account_callflows(AccountId, Context)).

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
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?CALLFLOWS/binary, "/", (modkazoo_util:get_value(<<"id">>, CurrDoc))/binary>>,
    crossbar_account_request('post', API_String, DataBag, Context).

kz_list_account_resources(Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS(Context)/binary, ?RESOURCES/binary>>
    end,
    crossbar_account_request('get', API_String, [], Context).
    
kz_resource_info(ResourceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_resource_info(ResourceId, AccountId, Context).

kz_resource_info(ResourceId, AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>
    end,
    crossbar_account_request('get', API_String, [], Context).
    
kz_resource_delete(ResourceId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_resource_delete(ResourceId, AccountId, Context).

kz_resource_delete(ResourceId, AccountId, Context) ->
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>
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
        'true' -> <<?V2/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>
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
        ,{<<"codecs">>,lists:foldl(fun(Codec,J) -> case Codec of [] -> J; _ -> J ++ [?TO_BIN(Codec)] end end, [], z_context:get_q_all("codecs",Context))}
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
    case ResourceId of
        <<>> ->
            API_String = case kz_current_context_superadmin(Context) of
                'true' -> <<?V2/binary, ?RESOURCES/binary>>; 
                'false' -> <<?V2/binary, ?ACCOUNTS(Context)/binary, ?RESOURCES/binary>>
            end,
            _ = crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = case kz_current_context_superadmin(Context) of
                'true' -> <<?V2/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>; 
                'false' -> <<?V2/binary, ?ACCOUNTS(Context)/binary, ?RESOURCES/binary, "/", ?TO_BIN(ResourceId)/binary>>
            end,
            _ = crossbar_account_request('post', API_String, DataBag, Context)
    end.

super_account_id(Context) ->
    case z_context:get_session('super_account_id', Context) of
        'undefined' ->
            {'ok', {'account_id', SuperAccountId}, {'auth_token', _}, {'crossbar', _}} = kz_admin_creds(Context),
            z_context:set_session('super_account_id', SuperAccountId, Context),
            SuperAccountId;
        AccountId ->
             AccountId
    end.

kz_list_account_notifications(Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?NOTIFICATIONS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_notification_info(NotificationId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_notification_info(NotificationId, AccountId, Context).

kz_notification_info(NotificationId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_delete_notification_template(NotificationId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_notification_template(ContentType, NotificationId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    kz_notification_template(ContentType, NotificationId, AccountId, Context).

kz_notification_template(ContentType, NotificationId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary>>,
    crossbar_account_send_raw_request_body('get', API_String, [{"Accept", ContentType}], [], Context).

kz_save_notification_template(ContentType, NotificationId, AccountId, MessageBody, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary>>,
    crossbar_account_send_request('post', API_String, ContentType, MessageBody, Context).

rs_kz_all_customers_update(AccountId, Context) ->
    rs_kz_customer_update('undefined', AccountId, Context).

rs_kz_customer_update(RecipientAccountId, AccountId, Context) ->
    CurrNotifyDoc = kz_notification_info(<<"customer_update">>, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"to">>,<<"email_addresses">>], emails_list("input_to", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"to">>,<<"type">>], modkazoo_util:get_q_bin("to", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"cc">>,<<"email_addresses">>], emails_list("input_cc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"cc">>,<<"type">>], modkazoo_util:get_q_bin("cc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"bcc">>,<<"email_addresses">>], emails_list("input_bcc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"bcc">>,<<"type">>], modkazoo_util:get_q_bin("bcc", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"from">>], modkazoo_util:get_q_bin("from", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"subject">>], modkazoo_util:get_q_bin("subject", Context), J) end
                ,fun(J) -> modkazoo_util:set_value([<<"template_charset">>], <<"utf-8">>, J) end
                ,fun(J) -> modkazoo_util:set_value(<<"plain">>, ?TO_BIN(z_context:get_q("text_body", Context)), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"html">>, base64:encode(?TO_BIN(z_context:get_q("html_body", Context))), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"user_type">>, modkazoo_util:get_q_bin("selected_user", Context), J) end
                ,fun(J) when RecipientAccountId == 'undefined' -> J; (J) -> modkazoo_util:set_value(<<"recipient_id">>, RecipientAccountId, J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrNotifyDoc, Routines),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, ?CUSTOMER_UPDATE/binary, ?MESSAGE/binary>>,
    crossbar_account_send_request('post', API_String, ?MK_DATABAG(NewDoc), Context).

kz_list_account_lists(Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

account_list(Context) ->
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
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary>>,
            crossbar_account_request('put', API_String, ?MK_DATABAG(NewDoc), Context);
        _ ->
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary>>,
            crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context)
    end.

delete_account_list(ListId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

delete_account_list_entry(EntryId, ListId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary,
                                                          ?ENTRIES/binary, "/", ?TO_BIN(EntryId)/binary>>,
    crossbar_account_request('delete', API_String, [], Context).

kz_get_account_list(ListId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_list_account_list_entries(ListId,Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary, ?ENTRIES/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_account_list_add_entry(ListType, ListId, Context) ->
    EntryId = z_context:get_q("entry_id", Context),
    CurrDoc = case EntryId of
        'undefined' -> ?EMPTY_JSON_OBJECT;
         _ -> kz_get_account_list_entry(EntryId, ListId, Context)
    end,
    Routines = list_routines(ListType, Context),
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrDoc, Routines),
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary, ?ENTRIES/binary>>,
    case EntryId of
        'undefined' ->
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary, ?ENTRIES/binary>>,
            crossbar_account_request('put', API_String, ?MK_DATABAG(NewDoc), Context);
        _ ->
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?LISTS/binary, "/", ?TO_BIN(ListId)/binary,
                                                                  ?ENTRIES/binary, "/", ?TO_BIN(EntryId)/binary>>,
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
    Plain = ?TO_BIN(kz_notification_template("text/plain", NotificationId, AccountId, Context)),
    HTML = kz_notification_template("text/html", NotificationId, AccountId, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"to">>,<<"email_addresses">>], [?TO_BIN(Email)], J) end
                ,fun(J) -> modkazoo_util:set_value([<<"to">>,<<"type">>], <<"specified">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"template_charset">>], <<"utf-8">>, J) end
                ,fun(J) -> modkazoo_util:set_value([<<"enabled">>], 'true', J) end
                ,fun(J) -> modkazoo_util:set_value(<<"from">>, ?TO_BIN(Email), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"reply_to">>, ?TO_BIN(Email), J) end
                ,fun(J) -> modkazoo_util:set_value(<<"plain">>, Plain, J) end
                ,fun(J) -> modkazoo_util:set_value(<<"html">>, base64:encode(HTML), J) end
               ],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrNotifyDoc, Routines),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary, ?PREVIEW/binary>>,
    _ = crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            _ = kz_save_notification_template("text/html", NotificationId, AccountId, HTML, Context),
            _ = kz_save_notification_template("text/plain", NotificationId, AccountId, Plain, Context);
        _ -> 'ok'
    end.

notifications_smtplog(Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?NOTIFICATIONS/binary, ?SMTPLOG/binary>>,
    {'ok', _, _, Body} = crossbar_account_send_request('get', API_String, "text/plain", [], Context),
    modkazoo_util:get_value(<<"data">>,jiffy:decode(Body)). 

notifications_smtplog_by_id(LogId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?NOTIFICATIONS/binary, ?SMTPLOG/binary, "/", (?TO_BIN(LogId))/binary>>,
    crossbar_account_request('get', API_String, [], Context).

kz_notifications(Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    NotificationId = z_context:get_q("notification_id", Context),
    CurrNotifyDoc = kz_notification_info(NotificationId, Context),
    Plain = ?TO_BIN(kz_notification_template("text/plain", NotificationId, AccountId, Context)),
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
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary>>,
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
    Plain = ?TO_BIN(kz_notification_template("text/plain", NotificationId, AccountId, Context)),
    HTML = kz_notification_template("text/html", NotificationId, AccountId, Context),
    Routines = [fun(J) -> modkazoo_util:set_value([<<"enabled">>], State, J) end],
    NewDoc = lists:foldl(fun(F, J) -> F(J) end, CurrNotifyDoc, Routines),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, "/", ?TO_BIN(NotificationId)/binary>>,
    _ = crossbar_account_request('post', API_String, ?MK_DATABAG(NewDoc), Context),
    case modkazoo_util:get_value(<<"account_overridden">>, CurrNotifyDoc) of
        'undefined' ->
            _ = kz_save_notification_template("text/html", NotificationId, AccountId, HTML, Context),
            _ = kz_save_notification_template("text/plain", NotificationId, AccountId, Plain, Context);
        _ -> 'ok'
    end.

list_system_dialplans(Context) -> 
    API_String = case kz_current_context_superadmin(Context) of
        'true' -> <<?V2/binary, ?DIALPLANS/binary>>; 
        'false' -> <<?V2/binary, ?ACCOUNTS(Context)/binary, ?DIALPLANS/binary>>
    end,
    case crossbar_account_request('get', API_String, [], Context) of
        <<>> -> {[]};
        JObj -> JObj
    end.

list_system_dialplans_names(Context) -> 
    Dialplans = modkazoo_util:to_proplist(list_system_dialplans(Context)),
    lists:usort(lists:foldl(fold_dialplan_names(), [], Dialplans)).

fold_dialplan_names() ->
    fun({_, Val}, Acc) when is_list(Val) ->
        lists:foldl(fun(ValElem, A) -> [modkazoo_util:get_value(<<"name">>, ValElem)] ++ A end, Acc, Val);
       ({_, Val}, Acc) ->
        [modkazoo_util:get_value(<<"name">>, Val)] ++ Acc
    end.

kz_set_reseller_status(Verb, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?RESELLER/binary>>,
    crossbar_account_request(Verb, API_String, [], Context).

kz_toggle_reseller_status(AccountId, Context) ->
    case kz_reseller_status(AccountId, Context) of
        'true' -> kz_set_reseller_status('delete', AccountId, Context);
        _ -> kz_set_reseller_status('put', AccountId, Context)
    end.

kz_toggle_account_status(AccountId, Context) ->
    kz_toggle_account_doc(<<"enabled">>, AccountId, Context).

per_minute_calls(Transactions) ->
    Fun = fun(Transaction) -> modkazoo_util:get_value(<<"reason">>, Transaction) == <<"per_minute_call">> end,
    modkazoo_util:filter(Fun, Transactions).

credit_transactions(Transactions) ->
    Fun = fun(Transaction) ->
              (modkazoo_util:get_value(<<"type">>, Transaction) == <<"credit">>)
              and
              (modkazoo_util:get_value(<<"reason">>, Transaction) =/= <<"database_rollup">>)
          end,
    modkazoo_util:filter(Fun, Transactions).

debit_transactions(Transactions) ->
    Fun = fun(Transaction) ->
              (modkazoo_util:get_value(<<"type">>, Transaction) == <<"debit">>)
              and
              (modkazoo_util:get_value(<<"reason">>, Transaction) =/= <<"per_minute_call">>)
              and
              (modkazoo_util:get_value(<<"reason">>, Transaction) =/= <<"database_rollup">>)
          end,
    modkazoo_util:filter(Fun, Transactions).

kz_account_access_lists(Verb, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?ACCESS_LISTS/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_device_access_lists(Verb, DeviceId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?DEVICES(DeviceId)/binary, ?ACCESS_LISTS/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_limits(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?LIMITS/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context, 'return_error').

save_trunks_limits(InputValue, TrunksType, AccountId, AcceptCharges, Context) ->
  AuthToken = z_context:get_session(kazoo_auth_token, Context),
  lager:info("IAM AuthToken: ~p",[AuthToken]),
    CurrDoc = kz_limits('get', AccountId, [], Context),
    QtyDiff = ?TO_INT(InputValue) - modkazoo_util:get_value(?TO_BIN(TrunksType), CurrDoc, 0),
    Upd = [{?TO_BIN(TrunksType), ?TO_INT(InputValue)}
          ],
    NewDoc = modkazoo_util:set_values(Upd, CurrDoc),
    Routines = [fun(C) -> z_render:update("trunks_manager_table"
                                         ,z_template:render("trunks_manager_table_body.tpl", [], C)
                                         ,C)
                end
               ],
    case kz_limits('post', AccountId, ?SET_ACCEPT_CHARGES(AcceptCharges, NewDoc), Context) of
        {'error', "402", Body} ->
            Data = modkazoo_util:get_value(<<"data">>, jiffy:decode(Body)),
            case modkazoo_util:get_value([<<"limits">>,?TO_BIN(TrunksType)], Data) of
                'undefined' ->
                    Message = modkazoo_util:get_value(<<"message">>, Data),
                    z_render:growl_error(?TO_LST(Message), Context);
                LimitsItem ->
                    Expences = QtyDiff * modkazoo_util:get_value(<<"activation_charge">>, LimitsItem)
                               + QtyDiff * modkazoo_util:get_value(<<"rate">>, LimitsItem),
                    CurrentAccountCredit = modkazoo_util:get_value(<<"amount">>, current_account_credit(AccountId, Context)),
                    PVT_Limits = onbill_util:onbill_pvt_limits('get', AccountId, [], Context),
                    MaybePostpayCredit =
                        case modkazoo_util:get_value(<<"allow_postpay">>, PVT_Limits, 'false') of
                            'true' ->
                                modkazoo_util:get_value(<<"max_postpay_amount">>, PVT_Limits, 0);
                            'false' -> 0
                        end,
                    case Expences > (CurrentAccountCredit + MaybePostpayCredit) of
                        'true' ->
                            Ctx = lists:foldl(fun(F, J) -> F(J) end, Context, Routines),
                            z_render:growl_error(?__("Not enough funds.",Ctx), Ctx);
                        'false' ->
                            z_render:dialog(?__("Charges Confirmation",Context)
                                           ,"_accept_trunks_limits_charges.tpl"
                                           ,[{item, LimitsItem}
                                            ,{quantity_diff, QtyDiff}
                                            ,{trunks_type, TrunksType}
                                            ,{account_id, AccountId}
                                            ,{width, "auto"}
                                            ]
                                           ,Context)
                    end
            end;
        {'error', _ReturnCode, Body} ->
            Message = modkazoo_util:get_value([<<"data">>,<<"message">>], jiffy:decode(Body)),
            Ctx = lists:foldl(fun(F, J) -> F(J) end, Context, Routines),
            z_render:growl_error(?TO_LST(Message), Ctx);
        _ ->
            Ctx = lists:foldl(fun(F, J) -> F(J) end, Context, Routines),
            z_render:growl(?__("Trunks amount successfully changed.", Ctx), Ctx)
    end.

kz_allotments(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ALLOTMENTS/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

kz_allotments_consumed(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ALLOTMENTS/binary, ?CONSUMED/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

allotment_element_delete(AllotmentElementName, AccountId, Context) ->
    CurrAllotments = kz_allotments('get', AccountId, [], Context),
    NewAllotments = modkazoo_util:delete_key(AllotmentElementName, CurrAllotments),
    kz_allotments('post', AccountId, ?MK_DATABAG(NewAllotments), Context).

allotment_element_add(AllotmentElementName, AccountId, Context) ->
    CurrAllotments = kz_allotments('get', AccountId, [], Context),
    NewAllotments = modkazoo_util:set_value(AllotmentElementName, (?DEFAULT_ALLOTMENTS), CurrAllotments),
    kz_allotments('post', AccountId, ?MK_DATABAG(NewAllotments), Context).

allotment_element_set_field(InputValue, FieldName, AllotmentElementName, AccountId, Context) ->
    FieldValue = case FieldName of
                     "cycle" -> ?TO_BIN(InputValue);
                     "group_consume" -> [?TO_BIN(InputValue)];
                     _ -> ?TO_INT(InputValue)
                 end,
    CurrAllotments = kz_allotments('get', AccountId, [], Context),
    NewAllotments = modkazoo_util:set_value([?TO_BIN(AllotmentElementName), ?TO_BIN(FieldName)], FieldValue, CurrAllotments),
    kz_allotments('post', AccountId, ?MK_DATABAG(NewAllotments), Context).

set_e911_number_service(AddressValues, Number, AccountId, Context) ->
    NumberDoc = kazoo_util:phone_number('get', Number, AccountId, [], Context),
    Features = modkazoo_util:get_value(<<"features">>, NumberDoc, []),
    NewFeatures = lists:usort([<<"e911">>] ++ Features),
    E911AddrJObj = modkazoo_util:set_values(AddressValues, modkazoo_util:new()),
    Routines =
        [fun(JObj) -> modkazoo_util:set_value(<<"features">>, NewFeatures, JObj) end
        ,fun(JObj) -> modkazoo_util:set_value(<<"e911">>, E911AddrJObj, JObj) end],
    NewDoc = lists:foldl(fun(F, JObj) -> F(JObj) end, NumberDoc, Routines),
    kazoo_util:phone_number('post', Number, AccountId, ?MK_DATABAG(NewDoc), Context).

remove_e911_number_service(Number, AccountId, Context) ->
    NumberDoc = kazoo_util:phone_number('get', Number, AccountId, [], Context),
    Features = modkazoo_util:get_value(<<"features">>, NumberDoc, []),
    NewFeatures = lists:delete(<<"e911">>, Features),
    Routines =
        [fun(JObj) -> modkazoo_util:set_value(<<"features">>, NewFeatures, JObj) end
        ,fun(JObj) -> modkazoo_util:delete_key(<<"e911">>, JObj) end],
    NewDoc = lists:foldl(fun(F, JObj) -> F(JObj) end, NumberDoc, Routines),
    kazoo_util:phone_number('post', Number, AccountId, ?MK_DATABAG(NewDoc), Context).

is_trial_account(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    is_trial_account(AccountId, Context).

is_trial_account(AccountId, Context) ->
    case kz_account_doc_field(<<"trial_time_left">>, AccountId, Context) of
        'undefined' -> 'false';
        TimeLeft -> {'true', TimeLeft}
    end.

services_status(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?SERVICES/binary, ?STATUS/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

toggle_services_status(AccountId, Context) ->
    StatusData = services_status('get', AccountId, [], Context),
  lager:info("IAM AuthToken: ~p",[z_context:get_session(kazoo_auth_token, Context)]),
    case modkazoo_util:get_value(<<"in_good_standing">>, StatusData) of
        'false' ->
            DataBag = ?MK_DATABAG({[{<<"in_good_standing">>, 'true'},{<<"reason">>,<<"administratively_justified">>}]}),
            services_status('post', AccountId, DataBag, Context);
        'true' ->
            DataBag = ?MK_DATABAG({[{<<"in_good_standing">>, 'false'},{<<"reason">>,<<"administratively_convicted">>}]}),
            services_status('post', AccountId, DataBag, Context)
    end.

all_tasks(Context) ->
    API_String = <<?V2/binary, ?TASKS/binary>>,
    crossbar_account_request('get', API_String, [], Context).

account_tasks(Verb, AccountId, DataBag, Context) ->
    account_tasks(Verb, AccountId, "application/json", DataBag, Context).

account_tasks(Verb, AccountId, ContentType, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TASKS/binary>>,
    {'ok', _, _, Body} = crossbar_account_send_request(Verb, API_String, ContentType, DataBag, Context),
    modkazoo_util:get_value(<<"data">>,jiffy:decode(Body)).

get_tasks_csv(AttName, TaskId, AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TASKS/binary
                  ,"/", ?TO_BIN(TaskId)/binary, "?csv_name=", ?TO_BIN(AttName)/binary>>,
    crossbar_account_send_raw_request('get', API_String, [{"Accept", "text/csv"}], [], Context).

account_task(Verb, TaskId, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?TASKS/binary, "/", ?TO_BIN(TaskId)/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).

add_new_task(Context) ->
    case z_context:get_q("taskfile", Context) of
        {upload, UploadFilename, UploadTmp, _, _} ->
            add_new_task_file(UploadFilename, UploadTmp, Context);
        _ ->
            Category = modkazoo_util:get_q_bin(<<"task_category">>, Context),
            Action = modkazoo_util:get_q_bin(<<"task_action">>, Context),
            API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?TASKS/binary
                          ,"?category=", Category/binary, "&action=", Action/binary>>,
            crossbar_account_request('put', API_String, [], Context)
    end.

add_new_task_file(UploadFilename, UploadTmp, Context) ->
    Category = modkazoo_util:get_q_bin(<<"task_category">>, Context),
    Action = modkazoo_util:get_q_bin(<<"task_action">>, Context),
    {ok, Data} = file:read_file(UploadTmp),
    Mime =
        case binary:split(?TO_BIN(UploadFilename), <<".csv">>) of
            [_,_] -> "text/csv";
            _ ->
                {ok, IdnProps} = z_media_identify:identify(UploadTmp, UploadFilename, Context),
                proplists:get_value(mime, IdnProps)
        end,
    Headers = [{"Content-Type",Mime}],
    API_String = <<?V2/binary, ?ACCOUNTS(Context)/binary, ?TASKS/binary, "?category=", Category/binary
                  ,"&action=", Action/binary, "&file_name=", ?TO_BIN(UploadFilename)/binary>>,
    crossbar_account_send_raw_request('put', API_String, Headers, Data, Context).

metaflows(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?METAFLOWS/binary>>,
    crossbar_account_request(Verb, API_String, DataBag, Context).
