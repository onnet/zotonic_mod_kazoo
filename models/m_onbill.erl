-module(m_onbill).
-author("kirill.sysoev@gmail.com").

-behaviour(gen_model).

-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2
]).

-include_lib("zotonic.hrl").

m_find_value({onbill_get_doc, [{doc_id, DocId}]}, _M, Context) ->
    onbill_util:doc(DocId, Context);

m_find_value({onbill_get_doc_json, [{doc_id, DocId}]}, _M, Context) ->
    jiffy:encode(onbill_util:doc(DocId, Context));

m_find_value({onbill_get_variables, [{account_id, AccountId}]}, _M, Context) ->
    onbill_util:variables(AccountId, Context);

m_find_value({onbill_get_variables_json, [{account_id, AccountId}]}, _M, Context) ->
    jiffy:encode(onbill_util:variables(AccountId, Context));

m_find_value({onbill_get_customer, [{customer_id, CustomerId}]}, _M, Context) ->
    onbill_util:customer(CustomerId, Context);

m_find_value({onbill_get_customer_json, [{customer_id, CustomerId}]}, _M, Context) ->
    jiffy:encode(onbill_util:customer(CustomerId, Context));

m_find_value({onbill_get_reseller, [{reseller_id, ResellerId}]}, _M, Context) ->
    onbill_util:reseller(ResellerId, Context);

m_find_value({onbill_get_reseller_json, [{reseller_id, ResellerId}]}, _M, Context) ->
    jiffy:encode(onbill_util:reseller(ResellerId, Context));

m_find_value({onbill_get_carrier, [{carrier_id, CarrierId}]}, _M, Context) ->
    onbill_util:carrier(CarrierId, Context);

m_find_value({onbill_get_carrier_json, [{carrier_id, CarrierId}]}, _M, Context) ->
    jiffy:encode(onbill_util:carrier(CarrierId, Context));

m_find_value({onbill_get_service_plan,[{service_plan_id, ServicePlanId}]}, _M, Context) ->
    onbill_util:onbill_service_plan(ServicePlanId, Context);

m_find_value({onbill_get_service_plan_json,[{service_plan_id, ServicePlanId}]}, _M, Context) ->
    jiffy:encode(onbill_util:onbill_service_plan(ServicePlanId, Context));

m_find_value({doc_field,[{doc_id, DocId},{field, Field}]}, _M, Context) ->
    onbill_util:doc_field(Field, DocId, Context);

m_find_value({docs_listing, [{account_id, 'undefined'}, {selected_billing_period, SelectedBillingPeriod}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({docs_listing, [{account_id, AccountId}, {selected_billing_period, SelectedBillingPeriod}]}, _M, Context);
m_find_value({docs_listing, [{account_id, AccountId}, {selected_billing_period, 'undefined'}]}, _M, Context) ->
    onbill_util:docs_listing(AccountId, modkazoo_util:current_tstamp(Context), Context);
m_find_value({docs_listing, [{account_id, AccountId}, {selected_billing_period, SelectedBillingPeriod}]}, _M, Context) ->
    [Ts,_] = z_string:split(SelectedBillingPeriod, ","),
    Timestamp = z_convert:to_integer(Ts),
    onbill_util:docs_listing(AccountId, Timestamp, Context);

m_find_value({attachment_download_link,[{account_id, 'undefined'},{doc_id, DocId},{doc_type,DocType}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{doc_type,DocType}]}, _M, Context);
m_find_value({attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{doc_type,DocType}]}, _M, Context) ->
    onbill_util:onbill_attachment_link(AccountId, DocId, DocType, Context);

m_find_value({attachment_download_link,[{account_id,'undefined'},{doc_id, DocId},{attachment_name, AttName},{doc_type, DocType}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{attachment_name, AttName},{doc_type, DocType}]}, _M, Context);
m_find_value({attachment_download_link,[{account_id,AccountId},{doc_id, DocId},{attachment_name, AttName},{doc_type, DocType}]}, _M, Context) ->
    onbill_util:onbill_attachment_name_link(AccountId, DocId, AttName, DocType, Context);

m_find_value({carrier_template,[{carrier_id,CarrierId},{template_id,TemplateId}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    onbill_util:carrier_template('get', [], AccountId, CarrierId, TemplateId, [], Context);

m_find_value({periodic_fees, [{account_id, AccountId}, {fees_type,"show_all"}]}, _M, Context) ->
    onbill_util:periodic_fees('get', AccountId, [], Context);
m_find_value({periodic_fees, [{account_id, AccountId}, {fees_type,_}]}, _M, Context) ->
    onbill_util:periodic_fees_active(AccountId, Context);

m_find_value({periodic_fees, [{account_id, AccountId},{fee_id, FeeId}]}, _M, Context) ->
    onbill_util:periodic_fees('get', AccountId, FeeId, [], Context);

m_find_value({transaction, [{account_id, AccountId},{transaction_id, TransactionId}]}, _M, Context) ->
    onbill_util:onbill_transaction(TransactionId, AccountId, Context);

m_find_value(promised_payment, _M, Context) ->
    onbill_util:promised_payment(Context);

m_find_value(kz_current_services, _M, Context) ->
    onbill_util:current_services(Context);

m_find_value({kz_current_services, [{account_id, AccountId}]}, _M, Context) ->
    onbill_util:current_services(AccountId, Context);

m_find_value({current_billing_period, [{account_id, AccountId}]}, _M, Context) ->
    onbill_util:current_billing_period(AccountId, Context);

m_find_value({billing_periods, [{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({billing_periods, [{account_id, AccountId}]}, _M, Context);
m_find_value({billing_periods, [{account_id, AccountId}]}, _M, Context) ->
    onbill_util:billing_periods(AccountId, Context);

m_find_value({e911_addresses,[{account_id, 'undefined'}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    m_find_value({e911_addresses,[{account_id, AccountId}]}, _M, Context);
m_find_value({e911_addresses,[{account_id, AccountId}]}, _M, Context) ->
    onbill_util:onbill_e911_addresses('get', AccountId, [], Context);

m_find_value({e911_addresses_confirmed,[{account_id, AccountId}]}, _M, Context) ->
    Addresses = m_find_value({e911_addresses,[{account_id, AccountId}]}, _M, Context),
    [Addr || Addr <- Addresses, modkazoo_util:get_value(<<"address_confirmed">>, Addr) == 'true'];

m_find_value({get_e911_address_doc,[{doc_id,'undefined'},{account_id,_AccountId}]}, _M, _Context) ->
    'undefined';
m_find_value({get_e911_address_doc,[{doc_id,DocId},{account_id,AccountId}]}, _M, Context) ->
    onbill_util:e911_address('get', DocId, AccountId, [], Context);

m_find_value({onbill_pvt_limits,[{account_id, AccountId}]}, _M, Context) ->
    onbill_util:onbill_pvt_limits('get', AccountId, [], Context);

m_find_value(proforma_invoices, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    onbill_util:onbill_proforma('get', AccountId, [], Context);

m_find_value(_V, _VV, _Context) ->
    lager:info("m_find_value _V: ~p", [_V]),
    lager:info("m_find_value _VV: ~p", [_VV]),
    [_V,_VV,"m_kazoo_find_value_mismatch"].

m_to_list(_V, _Context) ->
    lager:info("m_to_list _V: ~p", [_V]),
    [_V,"m_to_list"].

m_value(#m{value=V}, _Context) -> V.

