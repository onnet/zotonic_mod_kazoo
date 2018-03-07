%%
%% A bit modified Kazoo account CDR
%%
%% curl 'https://domain.tld/api/kazoo/cdr?created_from=63634712400&created_to=63634798799&account_id=33ca__f452&auth_token=2ba9d___e683f2'
%%

-module(service_kazoo_cdr).
-author("Kirill Sysoev").
-svc_title("Kazoo cdr proxy.").
-svc_needauth(false).

-export([process_get/2]).

-include_lib("zotonic_core/include/zotonic.hrl").
-include_lib("../include/mod_kazoo.hrl").

process_get(_ReqData, Context) ->
    AccountId = z_context:get_q("account_id", Context),
    CreatedFrom = z_context:get_q("created_from", Context),
    CreatedTo = z_context:get_q("created_to", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    AccountCDR = kazoo_util:kz_list_account_cdr(AccountId, CreatedFrom, CreatedTo, AuthToken, Context),
    reply_result(AccountCDR, Context).

reply_result(<<>>, _) ->
    <<"{\"status\": \"failure\"}">>;
reply_result(Reply, Context) ->
    FilteredCDR = kz_cdr_list_filter(Reply, Context),
    Values = [{<<"status">>,<<"success">>}
             ,{<<"data">>,FilteredCDR}
             ],
    DataBag = modkazoo_util:set_values(Values,{[]}),
    jiffy:encode(DataBag).

kz_cdr_list_filter(CdrList, Context) when is_list(CdrList) ->
    [kz_cdr_element_reduce(Element, Context) || Element <- CdrList
     ,modkazoo_util:get_value(<<"call_id">>, Element) == modkazoo_util:get_value(<<"bridge_id">>, Element)
    ];
kz_cdr_list_filter(_, _) ->
    [].

kz_cdr_element_reduce({CdrElement}, Context) ->
    FilterFun = fun ({<<"timestamp">>,_}) -> true;
                    ({<<"calling_from">>,_}) -> true;
                    ({<<"dialed_number">>,_}) -> true;
                    ({<<"callee_id_number">>,_}) -> true;
                    ({<<"duration_seconds">>,_}) -> true;
                    ({<<"billing_seconds">>,_}) -> true;
                    ({<<"recording_url">>,_}) -> false;
                    ({<<"id">>,_}) -> true;
                    ({<<"call_id">>,_}) -> true;
                    ({<<"hangup_cause">>,_}) -> true;
                    (_) -> false end,
    _T = z_convert:to_integer(proplists:get_value(<<"unix_timestamp">>,CdrElement)),
    ?JSON_WRAPPER(lists:filter(FilterFun, CdrElement)
                 ++ recording_url(CdrElement, Context)
                 ++ customer_call_direction(proplists:get_value(<<"authorizing_id">>,CdrElement))
                 ).

%ensure_timezone(Seconds, Context) ->
%    case z_context:get_q("timezone", Context) of
%        'undefined' -> Seconds;
%        TZ ->
%            LocalDateTime = localtime:local_to_local(calendar:gregorian_seconds_to_datetime(Seconds), "UTC", TZ),
%            calendar:datetime_to_gregorian_seconds(LocalDateTime)
%    end.

recording_url(CdrElement, Context) ->
 % lager:info("CdrElement: ~p",[CdrElement]),
    AccountId = z_context:get_q("account_id", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    case proplists:get_value(<<"recording_url">>, CdrElement) of
        'undefined' -> [];
        _ -> [{<<"recording_url">>, kazoo_util:kz_kzattachment_link(AccountId
                                                                   ,proplists:get_value(<<"id">>, CdrElement)
                                                                   ,AuthToken
                                                                   ,"call_recording"
                                                                   ,Context)
             }]
    end.

customer_call_direction('undefined') ->
    [{<<"customer_call_direction">>, <<"inbound">>}];
customer_call_direction(<<>>) ->
    [{<<"customer_call_direction">>, <<"inbound">>}];
customer_call_direction(_) ->
    [{<<"customer_call_direction">>, <<"outbound">>}].


