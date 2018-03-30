-module(controller_auth_kazoo_token).

-export([
    service_available/1,
    charsets_provided/1,
    content_types_provided/1,
    resource_exists/1,
    previously_existed/1,
    moved_temporarily/1

]).

-include_lib("zotonic_core/include/zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

service_available(Context) ->
    Context2 = z_context:ensure_all(Context),
    {true, Context2}.

charsets_provided(Context) ->
    {[<<"utf-8">>], Context}.

content_types_provided(Context) ->
    {[{<<"text/html">>, provide_content}], Context}.

resource_exists(Context) ->
    {false, Context}.

previously_existed(Context) ->
    {true, Context}.

moved_temporarily(Context) ->
?PRINT(z_context:get_q_all(Context)),
    AuthToken = z_context:get_q(<<"auth_token">>,Context),
    DispatchRule = z_context:get_q(<<"dispatch_rule">>,Context),
    ClientIP = cowmachine_req:peer(z_context:get_reqdata(Context)),
    case kazoo_util:kz_auth_token_creds(AuthToken, Context) of
        {'ok', {'owner_id', _}, {account_id, 'undefined'}, {'auth_token', _}, {'crossbar', _}, {'account_name', _}} ->
            {false, Context};
        {'ok', {'owner_id', _}, {account_id, _}, {'auth_token', <<>>}, {'crossbar', _}, {'account_name', _}} ->
            {false, Context};
        {'ok',{'owner_id', Owner_Id}
             ,{'account_id', Account_Id}
             ,{'auth_token', AuthToken}
             ,{'crossbar', _Crossbar_URL}
             ,{'account_name', Account_Name}
        } ->
            lager:info("Succesfull authentication. IP address: ~p.", [ClientIP]),
            lager:info("Session ID: ~p.", [z_session_manager:get_session_id(Context)]),
            lager:info("AuthToken: ~p.", [AuthToken]),
            Ctx = modkazoo_auth:setup_environment(Owner_Id, AuthToken, Account_Id, Account_Name, <<"test">>, Context),
            AbsUrl = z_context:abs_url(DispatchRule, Context),
            {{true, AbsUrl}, Ctx};
        {'badauth', _Code, Data} ->
            lager:info("SessionID: ~p.", [z_session_manager:get_session_id(Context)]),
            lager:info("Failed (badauth) to authenticate. IP address: ~p. Data: ~p.", [ClientIP,Data]),
            {false, Context};
        _E ->
            lager:info("Failed (E) to authenticate. IP address: ~p. Error: ~p", [ClientIP, _E]),
            {false, Context}
    end.

