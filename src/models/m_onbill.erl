-module(m_onbill).
-author("kirill.sysoev@gmail.com").

-behaviour(gen_model).

-export([m_get/2
]).

-include_lib("zotonic_core/include/zotonic.hrl").

-spec m_get( list(), z:context() ) -> { term(), list() }.

m_get([ {onbill_get_doc, [{doc_id, DocId}]} | Rest ], Context) ->
    {onbill_util:doc(DocId, Context), Rest};

m_get([ {onbill_get_doc_json, [{doc_id, DocId}]} | Rest ], Context) ->
    {jiffy:encode(onbill_util:doc(DocId, Context)), Rest};

m_get([ {onbill_get_variables, []} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {onbill_util:variables(AccountId, Context), Rest};

m_get([ {onbill_get_variables, [{account_id, AccountId}]} | Rest ], Context) ->
    {onbill_util:variables(AccountId, Context), Rest};

m_get([ {onbill_get_variables_json, [{account_id, AccountId}]} | Rest ], Context) ->
    {jiffy:encode(onbill_util:variables(AccountId, Context)), Rest};

m_get([ {onbill_get_carrier, [{carrier_id, CarrierId}]} | Rest ], Context) ->
    {onbill_util:carrier(CarrierId, Context), Rest};

m_get([ {onbill_get_carrier_json, [{carrier_id, CarrierId}]} | Rest ], Context) ->
    {jiffy:encode(onbill_util:carrier(CarrierId, Context)), Rest};

m_get([ {onbill_get_service_plan,[{service_plan_id, ServicePlanId}]} | Rest ], Context) ->
    {onbill_util:onbill_service_plan(ServicePlanId, Context), Rest};

m_get([ {onbill_get_service_plan_json,[{service_plan_id, ServicePlanId}]} | Rest ], Context) ->
    {jiffy:encode(onbill_util:onbill_service_plan(ServicePlanId, Context)), Rest};

m_get([ {doc_field,[{doc_id, DocId},{field, Field}]} | Rest ], Context) ->
    {onbill_util:doc_field(Field, DocId, Context), Rest};

m_get([ {docs_listing, [{account_id, 'undefined'}, {selected_billing_period, SelectedBillingPeriod}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {docs_listing, [{account_id, AccountId}, {selected_billing_period, SelectedBillingPeriod}]} | Rest ], Context);
m_get([ {docs_listing, [{account_id, AccountId}, {selected_billing_period, 'undefined'}]} | Rest ], Context) ->
    {onbill_util:docs_listing(AccountId, modkazoo_util:current_tstamp(Context), Context), Rest};
m_get([ {docs_listing, [{account_id, AccountId}, {selected_billing_period, SelectedBillingPeriod}]} | Rest ], Context) ->
    [Ts,_] = z_string:split(SelectedBillingPeriod, ","),
    Timestamp = z_convert:to_integer(Ts),
    {onbill_util:docs_listing(AccountId, Timestamp, Context), Rest};

m_get([ {attachment_download_link,[{account_id, 'undefined'},{doc_id, DocId},{doc_type,DocType}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{doc_type,DocType}]} | Rest ], Context);
m_get([ {attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{doc_type,DocType}]} | Rest ], Context) ->
    {onbill_util:onbill_attachment_link(AccountId, DocId, DocType, Context), Rest};

m_get([ {attachment_download_link,[{account_id,'undefined'},{doc_id, DocId},{attachment_name, AttName},{doc_type, DocType}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{attachment_name, AttName},{doc_type, DocType}]} | Rest ], Context);
m_get([ {attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{attachment_name, AttName},{doc_type, DocType}]} | Rest ], Context) ->
    {onbill_util:onbill_attachment_name_link(AccountId, DocId, AttName, DocType, Context), Rest};

m_get([ {carrier_template,[{carrier_id,CarrierId},{template_id,TemplateId}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {onbill_util:carrier_template('get', [], AccountId, CarrierId, TemplateId, [], Context), Rest};

m_get([ {periodic_fees, [{account_id, AccountId}, {fees_type,<<"show_all">>}]} | Rest ], Context) ->
    {onbill_util:periodic_fees('get', AccountId, [], Context), Rest};
m_get([ {periodic_fees, [{account_id, AccountId}, {fees_type,_}]} | Rest ], Context) ->
    {onbill_util:periodic_fees_active(AccountId, Context), Rest};

m_get([ {periodic_fees, [{account_id, AccountId},{fee_id, FeeId}]} | Rest ], Context) ->
    {onbill_util:periodic_fees('get', AccountId, FeeId, [], Context), Rest};

m_get([ {transaction, [{account_id, AccountId},{transaction_id, TransactionId}]} | Rest ], Context) ->
    {onbill_util:onbill_transaction(TransactionId, AccountId, Context), Rest};

m_get([ promised_payment | Rest ], Context) ->
    {onbill_util:promised_payment(Context), Rest};

m_get([ kz_current_services | Rest ], Context) ->
    {onbill_util:current_services(Context), Rest};

m_get([ {kz_current_services, [{account_id, AccountId}]} | Rest ], Context) ->
    {onbill_util:current_services(AccountId, Context), Rest};

m_get([ {current_billing_period, [{account_id, AccountId}]} | Rest ], Context) ->
    {onbill_util:current_billing_period(AccountId, Context), Rest};

m_get([ {billing_periods, [{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {billing_periods, [{account_id, AccountId}]} | Rest ], Context);
m_get([ {billing_periods, [{account_id, AccountId}]} | Rest ], Context) ->
    {onbill_util:billing_periods(AccountId, Context), Rest};

m_get([ {e911_addresses,[{account_id, 'undefined'}]} | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_get([ {e911_addresses,[{account_id, AccountId}]} | Rest ], Context);
m_get([ {e911_addresses,[{account_id, AccountId}]} | Rest ], Context) ->
    {onbill_util:onbill_e911_addresses('get', AccountId, [], Context), Rest};

m_get([ {e911_addresses_confirmed,[{account_id, AccountId}]} | Rest ], Context) ->
    Addresses = m_get([ {e911_addresses,[{account_id, AccountId}]} | Rest ], Context),
    {[Addr || Addr <- Addresses, modkazoo_util:get_value(<<"address_confirmed">>, Addr) == 'true'], Rest};

m_get([ {get_e911_address_doc,[{doc_id,'undefined'},{account_id,_AccountId}]} | Rest ], _Context) ->
    {'undefined', Rest};
m_get([ {get_e911_address_doc,[{doc_id,DocId},{account_id,AccountId}]} | Rest ], Context) ->
    {onbill_util:e911_address('get', DocId, AccountId, [], Context), Rest};

m_get([ {onbill_pvt_limits,[{account_id, AccountId}]} | Rest ], Context) ->
    {onbill_util:onbill_pvt_limits('get', AccountId, [], Context), Rest};

m_get([ proforma_invoices | Rest ], Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    {onbill_util:onbill_proforma('get', AccountId, [], Context), Rest};

m_get([ _VR | Rest ], _Context) ->
    ?PRINT(_VR),
    ?PRINT(Rest),
    {undefined, Rest};
m_get(_V, _Context) ->
    ?PRINT(_V),
    {undefined, []}.

