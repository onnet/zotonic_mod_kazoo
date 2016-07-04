-module(service_kazoo_auth).
-author("Kirill Sysoev").
-svc_title("Kazoo auth proxy.").
-svc_needauth(false).

-export([process_post/2]).

-include_lib("zotonic.hrl").

process_post(_ReqData, Context) ->
    PostDataStr = get_post_data(z_context:get_q_all_noz(Context)),
    lager:info("PostDataStr: ~p",[PostDataStr]),
    PostDataJObj = jiffy:decode(PostDataStr),
    lager:info("PostDataJObj: ~p",[PostDataJObj]),
    ReqJObj = modkazoo_util:get_value(<<"data">>, PostDataJObj),
    lager:info("ReqJObj: ~p",[ReqJObj]),
    case modkazoo_util:get_value(<<"api_key">>, ReqJObj) of
        'undefined' ->
            Login = modkazoo_util:get_value(<<"login">>, ReqJObj),
            Password = modkazoo_util:get_value(<<"password">>, ReqJObj),
            Account = modkazoo_util:get_value(<<"account">>, ReqJObj),
            reply_auth_result(kazoo_util:kz_user_creds(Login, Password, Account, Context), Context);
        API_Key ->
lager:info("kazoo_util:kz_api_key_creds: ~p",[kazoo_util:kz_api_key_creds(API_Key, Context)]),
            reply_auth_result(kazoo_util:kz_api_key_creds(API_Key, Context), Context)
    end.

get_post_data([{K,_}|T]) ->
    case string:str(K, "\"data\"") of
        0 -> get_post_data(T);
        _ -> K
    end.

reply_auth_result({ok, {_, _}, {'account_id', 'undefined'}, {_, _}, {_, _}, {_, _}}, Context) ->
    reply_auth_result(<<"Auth failure">>, Context);
reply_auth_result({ok, {_, _}, {_, _}, {'auth_token', <<>>}, {_, _}, {_, _}}, Context) ->
    reply_auth_result(<<"Auth failure">>, Context);
reply_auth_result({'ok', {_, _}, {'account_id', AccountId}, {'auth_token', AuthToken}, {_, _}, {'account_name', AccountName}}, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    lager:info("Successfully authenticated Kazoo user at ~p. IP address: ~p.", [AccountName, ClientIP]),
    Values = [{<<"status">>,<<"success">>}
             ,{<<"auth_token">>,AuthToken}
             ,{[<<"data">>,<<"account_id">>],AccountId}
             ],
    DataBag = modkazoo_util:set_values(Values,{[]}),
    jiffy:encode(DataBag);
reply_auth_result(_, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    lager:info("Failed to authenticate Kazoo user. IP address: ~p.", [ClientIP]),
    <<"{\"status\": \"authentication failure\"}">>.
