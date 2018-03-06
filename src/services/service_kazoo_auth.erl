%%
%% Auth options.
%%
%% By user credentials:
%% curl -X POST https://domain.tld/api/kazoo/auth -d '{"data":{"login": "my_login", "password": "my_pwd", "account_name":"my_account_name_here"}}'
%%
%% By md5 hash
%% Creds = io_lib:format("~s:~s", ["my_login","my_pwd"]).
%% Md5Hash = iolist_to_binary([io_lib:format("~2.16.0b", [C]) || <<C>> <= erlang:md5(Creds)]).
%% curl -X POST https://domain.tld/api/kazoo/auth -d '{"data":{"credentials": "my_md5_hash", "account_name":"my_account_name_here"}}
%%
%% By api_key
%% curl -X POST https://domain.tld/api/kazoo/auth -d '{"data":{"api_key" : "4dd6ea7be0c26ndhdb______________86veeveewveeyum793"}}'
%%

-module(service_kazoo_auth).
-author("Kirill Sysoev").
-svc_title("Kazoo auth proxy.").
-svc_needauth(false).

-export([process_post/1]).

-include_lib("zotonic.hrl").

process_post(Context) ->
    PostDataStr = get_post_data(z_context:get_q_all_noz(Context)),
    PostDataJObj = jiffy:decode(PostDataStr),
    ReqJObj = modkazoo_util:get_value(<<"data">>, PostDataJObj),
    case modkazoo_util:get_value(<<"api_key">>, ReqJObj) of
        'undefined' ->
            maybe_password_auth(ReqJObj, Context);
        API_Key ->
            reply_auth_result(kazoo_util:kz_api_key_creds(API_Key, Context), Context)
    end.

maybe_password_auth(ReqJObj, Context) ->
    AccountName = modkazoo_util:get_value(<<"account_name">>, ReqJObj),
    case modkazoo_util:get_value(<<"credentials">>, ReqJObj) of
        'undefined' ->
            Login = modkazoo_util:get_value(<<"login">>, ReqJObj),
            Password = modkazoo_util:get_value(<<"password">>, ReqJObj),
            reply_auth_result(kazoo_util:kz_user_creds(Login, Password, AccountName, Context), Context);
        Md5Hash ->
            reply_auth_result(kazoo_util:kz_user_creds(Md5Hash, AccountName, Context), Context)
    end.

get_post_data([{<<"{\"data\":", _/binary>> = DataBStr,_}|_T]) ->
    DataBStr;
get_post_data([{_,_}|T]) ->
    get_post_data(T).

reply_auth_result({ok, {_, _}, {'account_id', 'undefined'}, {_, _}, {_, _}, {_, _}}, Context) ->
    reply_auth_result(<<"Auth failure">>, Context);
reply_auth_result({ok, {_, _}, {_, _}, {'auth_token', <<>>}, {_, _}, {_, _}}, Context) ->
    reply_auth_result(<<"Auth failure">>, Context);
reply_auth_result({'ok', {_, _}, {'account_id', AccountId}, {'auth_token', AuthToken}, {_, _}, {'account_name', AccountName}}, Context) ->
    ClientIP = cowmachine_req:peer(z_context:get_reqdata(Context)),
    lager:info("Successfully authenticated Kazoo user at ~p. IP address: ~p.", [AccountName, ClientIP]),
    Values = [{<<"status">>,<<"success">>}
             ,{<<"auth_token">>,AuthToken}
             ,{[<<"data">>,<<"account_id">>],AccountId}
             ],
    DataBag = modkazoo_util:set_values(Values,{[]}),
    jiffy:encode(DataBag);
reply_auth_result(_, Context) ->
    ClientIP = cowmachine_req:peer(z_context:get_reqdata(Context)),
    lager:info("Failed to authenticate Kazoo user. IP address: ~p.", [ClientIP]),
    <<"{\"status\": \"authentication failure\"}">>.
