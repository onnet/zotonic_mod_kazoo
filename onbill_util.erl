-module(onbill_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([docs_listing/3
         ,onbill_modb_attachment/4
         ,onbill_attachment_link/4
         ,onbill_attachment_name_link/5
         ,generate_monthly_docs/4
         ,variables/2
         ,variables/4
         ,onbill_service_plan/2
         ,onbill_service_plan/5
         ,carrier/2
         ,carrier/5
         ,carrier_template/7
         ,doc/2
         ,doc/5
         ,doc_field/3
         ,periodic_fees_active/2
         ,periodic_fees/4
         ,periodic_fees/5
         ,onbill_transaction/3
         ,promised_payment/1
         ,promised_payment/4
         ,current_services/1
         ,current_services/2
         ,current_billing_period/2
         ,billing_periods/2
         ,period_balance/3
         ,currency_sign/1
         ,onbill_e911_addresses/4
         ,e911_address/5
         ,set_e911_address/3
         ,set_e911_address/4
         ,update_e911_doc/3
         ,get_e911_attachment/2
         ,get_e911_attachment/3
         ,confirm_e911_address/4
         ,confirm_number_purchase_dialog/1
         ,onbill_trial/4
         ,onbill_pvt_limits/4
         ,save_pvt_limits_field/4
         ,onbill_proforma/4
         ,onbill_proforma_doc/5
         ,create_proforma_invoice/3
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").


-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ACCOUNTS(Context), <<"/accounts/", (z_context:get_session('kazoo_account_id', Context))/binary>>).
-define(ONBILLS, <<"/onbills">>).
-define(INVOICE, <<"/invoice">>).
-define(ATTACHMENT, <<"/attachment">>).
-define(GENERATE, <<"/generate">>).
-define(MODB, <<"/onbills_modb">>).
-define(CUSTOMERS, <<"/onbill_customers">>).
-define(RESELLERS, <<"/onbill_resellers">>).
-define(CARRIERS, <<"/onbill_carriers">>).
-define(VARIABLES, <<"/onbill_variables">>).
-define(SERVICE_PLANS, <<"/onbill_service_plans">>).
-define(PERIODIC_FEES, <<"/periodic_fees">>).
-define(ONBILL_TRANSACTIONS, <<"/onbill_transactions">>).
-define(PROMISED_PAYMENT, <<"/promised_payment">>).
-define(CURRENT_SERVICES, <<"/current_services">>).
-define(CURRENT_BILLING_PERIOD, <<"/current_billing_period">>).
-define(BILLING_PERIODS, <<"/billing_periods">>).
-define(PERIOD_BALANCE, <<"/period_balance">>).
-define(CURRENCY_SIGN, <<"/currency_sign">>).
-define(ONBILL_E911, <<"/onbill_e911">>).
-define(RAW, <<"/raw">>).
-define(CONFIRM_ADDRESS, <<"/confirm">>).
-define(ONBILL_TRIAL, <<"/onbill_trial">>).
-define(ONBILL_PVT_LIMITS, <<"/onbill_pvt_limits">>).
-define(ONBILL_PROFORMA, <<"/onbill_proforma">>).

docs_listing(AccountId, Timestamp, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary,"?period_timestamp=", ?TO_BIN(Timestamp)/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

doc(DocId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    doc('get', AccountId, DocId, [], Context).

doc(Verb, AccountId, DocId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?ONBILLS/binary,"/",(z_convert:to_binary(DocId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

variables(CustomerId, Context) ->
    variables('get', CustomerId, [], Context).

variables(Verb, CustomerId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(CustomerId))/binary, ?VARIABLES/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

onbill_service_plan(ServicePlanId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    onbill_service_plan('get', AccountId, ServicePlanId, [], Context).

onbill_service_plan(Verb, AccountId, ServicePlanId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?SERVICE_PLANS/binary,"/",(z_convert:to_binary(ServicePlanId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

carrier(CarrierId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    carrier('get', AccountId, CarrierId, [], Context).

carrier(Verb, AccountId, CarrierId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                  ,?CARRIERS/binary,"/",(z_convert:to_binary(CarrierId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

carrier_template(Verb, Headers, AccountId, CarrierId, TemplateId, MessageBody, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                  ,?CARRIERS/binary,"/",(z_convert:to_binary(CarrierId))/binary,"/",(z_convert:to_binary(TemplateId))/binary>>,
    kazoo_util:crossbar_account_send_raw_request_body(Verb, API_String, Headers, MessageBody, Context).

onbill_modb_attachment(AccountId, DocId, AuthToken, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?ONBILLS/binary,"/",(z_convert:to_binary(DocId))/binary, ?ATTACHMENT/binary>>,
    kazoo_util:crossbar_account_send_raw_request_body(AuthToken, 'get', API_String, [], [], Context).

onbill_attachment_link(AccountId, DocId, DocType, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    API_String = <<"/kzattachment?"
                   ,"account_id=", ?TO_BIN(AccountId)/binary
                   ,"&doc_id=", ?TO_BIN(DocId)/binary
                   ,"&doc_type=", ?TO_BIN(DocType)/binary
                   ,"&auth_token=", ?TO_BIN(AuthToken)/binary
                 >>,
    <<"https://", (z_convert:to_binary(z_dispatcher:hostname(Context)))/binary, API_String/binary>>.

onbill_attachment_name_link(AccountId, DocId, AttName, DocType, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    API_String = <<"/kzattachment?"
                   ,"account_id=", ?TO_BIN(AccountId)/binary
                   ,"&doc_id=", ?TO_BIN(DocId)/binary
                   ,"&att_name=", ?TO_BIN(AttName)/binary
                   ,"&doc_type=", ?TO_BIN(DocType)/binary
                   ,"&auth_token=", ?TO_BIN(AuthToken)/binary
                 >>,
    <<"https://", (z_convert:to_binary(z_dispatcher:hostname(Context)))/binary, API_String/binary>>.

generate_monthly_docs(DocType, DocsAccountId, Timestamp, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?GENERATE/binary, "/", ?TO_BIN(DocsAccountId)/binary>>,
    DataBag = ?MK_DATABAG({[{<<"period_timestamp">>, Timestamp},{<<"doc_type">>, DocType}]}),
    kazoo_util:crossbar_account_request('put', API_String, DataBag, Context).

generate_transaction_based_invoice(DocType, DocsAccountId, Timestamp, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?GENERATE/binary, "/", ?TO_BIN(DocsAccountId)/binary>>,

doc_field(Field, DocId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, doc(DocId, Context));
doc_field(Field, DocId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([z_convert:to_binary(X) || X <- Field], doc(DocId, Context));
doc_field(Field, DocId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, doc(DocId, Context));
doc_field(Field, DocId, Context) when is_list(Field) ->
    modkazoo_util:get_value(z_convert:to_binary(Field), doc(DocId, Context)).

periodic_fees_active(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PERIODIC_FEES/binary, "?active_only=true">>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

periodic_fees(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PERIODIC_FEES/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

periodic_fees(Verb, AccountId, 'undefined', DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary ,?PERIODIC_FEES/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context);
periodic_fees(Verb, AccountId, FeeId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary
                   ,?PERIODIC_FEES/binary,"/", ?TO_BIN(FeeId)/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

onbill_transaction(TransactionId, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILL_TRANSACTIONS/binary, "/", ?TO_BIN(TransactionId)/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

promised_payment(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    promised_payment('get', AccountId, [], Context).

promised_payment(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PROMISED_PAYMENT/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

current_services(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    current_services(AccountId, Context).

current_services(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?CURRENT_SERVICES/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

current_billing_period(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?CURRENT_BILLING_PERIOD/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

billing_periods(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?BILLING_PERIODS/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

period_balance(AccountId, Timestamp, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?PERIOD_BALANCE/binary
                  ,"?period_timestamp=", ?TO_BIN(Timestamp)/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

currency_sign(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILLS/binary, ?CURRENCY_SIGN/binary>>,
    Res = kazoo_util:crossbar_account_request('get', API_String, [], Context),
    modkazoo_util:get_value(<<"currency_sign">>, Res).

onbill_e911_addresses(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILL_E911/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

e911_address(Verb, DocId, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILL_E911/binary, "/", ?TO_BIN(DocId)/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

set_e911_address(Number, AccountId, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    {upload, UploadFilename, UploadTmp, _, _} = z_context:get_q("address_confirmation_file",Context),
    {ok, FileData} = file:read_file(UploadTmp),
    {ok, FileIdnProps} = z_media_identify:identify(UploadTmp, Context),
    Attachments =
        [#upload{tmpfile=UploadTmp
                ,data=FileData
                ,filename=modkazoo_util2:translit(UploadFilename)
                ,mime=proplists:get_value(mime, FileIdnProps)
                }
        ],
    SenderName = kazoo_util:email_sender_name(Context),
    EmailFrom = m_config:get_value('mod_kazoo', sales_email, Context),
    Vars = [{account_name, z_context:get_session('kazoo_account_name', Context)}
           ,{login_name, z_context:get_session('kazoo_login_name', Context)}
           ,{email_from, EmailFrom}
           ,{clientip, ClientIP}
           ,{sender_name, SenderName}
           ,{number, modkazoo_util:get_q_bin("number",Context)}
           ,{upload_filenamefile, UploadFilename}
           ],
    Values = [{<<"postal_code">>, modkazoo_util:get_q_bin("postal_code",Context)} 
             ,{<<"locality">>, modkazoo_util:get_q_bin("locality",Context)}
             ,{<<"region">>, modkazoo_util:get_q_bin("region",Context)}
             ,{<<"street_address">>, modkazoo_util:get_q_bin("street_address",Context)}
             ,{<<"extended_address">>, modkazoo_util:get_q_bin("extended_address",Context)}],
    Logs = [{<<"initial_comment">>, modkazoo_util:get_q_bin("comments",Context)}
           ,{<<"initial_request_ip_address">>, ?TO_BIN(ClientIP)}], 
    AllocateNumberEmail =
        #email{to = EmailFrom
              ,from = EmailFrom
              ,html_tpl = "_create_e911_doc_email.tpl"
              ,vars = Vars ++ [{?TO_ATM(A), B} || {A, B} <- Values++Logs]
              ,attachments = Attachments
              },
    spawn('z_email','send' ,[AllocateNumberEmail, Context]),
    Result = onbill_e911_addresses('put', AccountId, ?MK_DATABAG(modkazoo_util:set_values(Values++Logs, modkazoo_util:new())), Context),
    {upload, UploadFilename, UploadTmp, _, _} = z_context:get_q("address_confirmation_file",Context),
    set_e911_attachment(modkazoo_util:get_value(<<"id">>, Result), UploadFilename, UploadTmp, Context),
    kazoo_util:set_e911_number_service(Values, Number, AccountId, Context).

set_e911_address(AddressDocId, Number, AccountId, Context) ->
    Doc = e911_address('get', AddressDocId, AccountId, [], Context),
    Values = [{<<"postal_code">>, modkazoo_util:get_value(<<"postal_code">>, Doc)} 
             ,{<<"locality">>, modkazoo_util:get_value(<<"locality">>, Doc)}
             ,{<<"region">>, modkazoo_util:get_value(<<"region">>, Doc)}
             ,{<<"street_address">>, modkazoo_util:get_value(<<"street_address">>, Doc)}
             ,{<<"extended_address">>, modkazoo_util:get_value(<<"extended_address">>, Doc)}
             ], 
    kazoo_util:set_e911_number_service(Values, Number, AccountId, Context).
    

update_e911_doc(DocId, AccountId, Context) ->
    Values = [{<<"postal_code">>, modkazoo_util:get_q_bin("postal_code",Context)} 
             ,{<<"locality">>, modkazoo_util:get_q_bin("locality",Context)}
             ,{<<"region">>, modkazoo_util:get_q_bin("region",Context)}
             ,{<<"street_address">>, modkazoo_util:get_q_bin("street_address",Context)}
             ,{<<"extended_address">>, modkazoo_util:get_q_bin("extended_address",Context)}
             ], 
    CurrDoc = e911_address('get', DocId, AccountId, [], Context),
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(Values, CurrDoc)),
    e911_address('post', DocId, AccountId, DataBag, Context).

get_e911_attachment(Id, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    get_e911_attachment(Id, AccountId, Context).

get_e911_attachment(Id, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILL_E911/binary, "/", ?TO_BIN(Id)/binary, ?RAW/binary>>,
    kazoo_util:crossbar_account_send_raw_request('get', API_String, [], [], Context).

set_e911_attachment(Id, UploadFilename, UploadTmp, Context) ->
    {ok, Data} = file:read_file(UploadTmp),
    {ok, IdnProps} = z_media_identify:identify(UploadTmp, UploadFilename, Context),
    Mime = proplists:get_value(mime, IdnProps),
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?ONBILL_E911/binary, "/", ?TO_BIN(Id)/binary, ?RAW/binary>>,
    Headers = [{"Content-Type",Mime}],
    kazoo_util:crossbar_account_send_raw_request('post', API_String, Headers, Data, Context).

confirm_e911_address(IfConfirmed, DocId, AccountId, Context) ->
    DataBag = ?MK_DATABAG({[{<<"address_confirmed">>, IfConfirmed}]}),
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary
                  ,?ONBILL_E911/binary, "/", ?TO_BIN(DocId)/binary, ?CONFIRM_ADDRESS/binary>>,
    kazoo_util:crossbar_account_request('post', API_String, DataBag, Context).

confirm_number_purchase_dialog(Context) ->
    [Number|_] = Numbers = z_context:get_q_all("numbers_about_to_purchase",Context),
    NumberClass = kazoo_util:classify_number(Number, Context),
    NumberName = modkazoo_util:get_value(<<"name">>, NumberClass),
    CurrentServicePlans = kazoo_util:current_service_plans(Context),
    PhoneNumbersServices = modkazoo_util:get_value([<<"items">>,<<"phone_numbers">>], CurrentServicePlans),
    Rate = modkazoo_util:get_value([NumberName, <<"rate">>], PhoneNumbersServices),
    ActivationCharge = modkazoo_util:get_value([NumberName, <<"activation_charge">>], PhoneNumbersServices),
    OrderQuantity = length(Numbers),
    AccountId = z_context:get_session(kazoo_account_id, Context),
    PVT_Limits = onbill_util:onbill_pvt_limits('get', AccountId, [], Context),
    MaybePostpayCredit =
        case modkazoo_util:get_value(<<"allow_postpay">>, PVT_Limits, 'false') of
            'true' ->
                modkazoo_util:get_value(<<"max_postpay_amount">>, PVT_Limits, 0);
            'false' -> 0
        end,
    OrderTotal = ActivationCharge * OrderQuantity + Rate * OrderQuantity,
    case modkazoo_util:get_value(<<"amount">>, kazoo_util:current_account_credit(Context)) of
        Amount when (Amount + MaybePostpayCredit) >= OrderTotal ->
            CurrentQuantity = modkazoo_util:get_value([NumberName, <<"quantity">>], PhoneNumbersServices),
            ExpectedQuantity = CurrentQuantity + OrderQuantity,
            SingleDiscount =
                case modkazoo_util:get_value([NumberName, <<"single_discount">>], PhoneNumbersServices) of
                    'true' ->
                        modkazoo_util:get_value([NumberName, <<"single_discount_rate">>], PhoneNumbersServices, 0.0);
                    'false' ->
                        0.0
                end,
            CumulativeDiscount =
                modkazoo_util:get_value([NumberName, <<"cumulative_discount">>], PhoneNumbersServices, 0.0)
                * modkazoo_util:get_value([NumberName, <<"cumulative_discount_rate">>], PhoneNumbersServices, 0.0),
            Basket =
                {[{<<"name">>, NumberName}
                 ,{<<"friendly_name">>, modkazoo_util:get_value(<<"friendly_name">>, NumberClass)}
                 ,{<<"rate">>, Rate}
                 ,{<<"activation_charge">>, ActivationCharge}
                 ,{<<"order_quantity">>, OrderQuantity}
                 ,{<<"order_total">>, OrderTotal}
                 ,{<<"single_discount">>, SingleDiscount}
                 ,{<<"cumulative_discount">>, CumulativeDiscount}
                 ,{<<"expected_quantity">>, ExpectedQuantity}
                 ,{<<"expected_mrc">>, Rate * ExpectedQuantity - SingleDiscount - CumulativeDiscount}]},
            z_render:dialog(?__("Add phone number(s)",Context)
                           ,"_numbers_add_attempt_lazy.tpl"
                           ,[{numbers_to_purchase, Numbers}
                            ,{basket, Basket}
                            ,{width, <<"auto">>}
                            ]
                           ,Context);
        _ ->
            z_render:growl_error(?__("Sorry, not enough funds.",Context), Context)
    end.

onbill_trial(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary ,?ONBILL_TRIAL/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

onbill_pvt_limits(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary ,?ONBILL_PVT_LIMITS/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

save_pvt_limits_field(InputValue, FieldName, AccountId, Context) ->
    DataBag = ?MK_DATABAG({[{?TO_BIN(FieldName), ?TO_BIN(InputValue)}]}),
    onbill_pvt_limits('post', AccountId, DataBag, Context).

onbill_proforma(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary ,?ONBILL_PROFORMA/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

onbill_proforma_doc(Verb, DocId, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary ,?ONBILL_PROFORMA/binary, "/", ?TO_BIN(DocId)/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

create_proforma_invoice(Amount, AccountId, Context) ->
    DataBag = ?MK_DATABAG({[{<<"amount">>, Amount}]}),
    onbill_proforma('put', AccountId, DataBag, Context).
