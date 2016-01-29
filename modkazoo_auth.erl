-module(modkazoo_auth).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([is_auth/1
    ,do_sign_in/4
    ,signout/1
    ,gcapture_check/1
    ,process_signup_form/1
    ,may_be_add_third_party_billing/1
    ,may_be_set_reseller_data/1
    ,may_be_set_user_data/1
    ,choose_page_to_redirect/1
    ,may_be_clean_third_party_billing/1
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

is_auth(Context) ->
    case kazoo_util:kz_get_acc_doc(Context) of
        <<>> -> 'false';
        _ -> 
            (modkazoo_util:is_defined(z_context:get_session(kazoo_auth_token, Context))
                andalso
             modkazoo_util:is_defined(z_context:get_session(kazoo_account_id, Context)))
    end.

do_sign_in(Login, Password, Account, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    case kazoo_util:kz_user_creds(Login, Password, Account, Context) of
        {ok, {'owner_id', _}, {account_id, 'undefined'}, {'auth_token', _}, {'crossbar', _}, {'account_name', _}} ->
            lager:info("Failed to authenticate Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            z_render:growl_error(?__("Admin auth failed.", Context), Context);
        {ok, {'owner_id', _}, {account_id, _}, {'auth_token', <<>>}, {'crossbar', _}, {'account_name', _}} ->
            lager:info("Failed to authenticate Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            z_render:growl_error(?__("Admin auth failed.", Context), Context);
        {'ok', {'owner_id', Owner_Id}, {'account_id', Account_Id}, {'auth_token', Auth_Token}, {'crossbar', _Crossbar_URL}, {'account_name', Account_Name}} ->
            lager:info("Succesfull authentication of Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            z_context:set_session(kazoo_owner_id, Owner_Id, Context),
            z_context:set_session(kazoo_auth_token, Auth_Token, Context),
            z_context:set_session(kazoo_account_id, Account_Id, Context),
            z_context:set_session(kazoo_account_name, Account_Name, Context),
            z_context:set_session(kazoo_login_name, Login, Context),
            _ = may_be_set_user_data(Context),
            _ = may_be_set_reseller_data(Context),
            _ = may_be_add_third_party_billing(Context),
            choose_page_to_redirect(z_render:wire({mask, [{target_id, "sign_in_form"}]}, Context));
        _ ->
            lager:info("Failed to authenticate Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            z_render:growl_error(?__("Auth failed.", Context), Context)
    end.

choose_page_to_redirect(Context) ->
    AccountDoc = kazoo_util:kz_get_acc_doc(Context),
    case (modkazoo_util:get_value(<<"is_reseller">>,AccountDoc) == 'true' orelse  modkazoo_util:get_value(<<"superduper_admin">>,AccountDoc) == 'true') of
        'true' ->
            z_render:wire({redirect, [{dispatch, "reseller_portal"}]}, Context);
        'false' -> 
            case z_dispatcher:url_for('dashboard',Context) of
                'undefined' -> 
                    case z_context:get_session('kazoo_account_admin', Context) of 
                        'true' -> z_render:wire({redirect, [{dispatch, "admin_settings"}]}, Context);
                        'false' -> z_render:wire({redirect, [{dispatch, "user_portal"}]}, Context)
                    end;
                _ ->
                    z_render:wire({redirect, [{dispatch, "dashboard"}]}, Context) 
            end
    end.

may_be_set_user_data(Context) ->
    case kazoo_util:kz_user_doc_field(<<"priv_level">>, Context) of
                <<"admin">> ->
                    z_context:set_session('kazoo_account_admin', 'true', Context);
                'undefined' ->
                    z_context:set_session('kazoo_account_admin', 'true', Context);
                _ ->
                    z_context:set_session('kazoo_account_admin', 'false', Context)
    end.

may_be_set_reseller_data(Context) ->
    AccountDoc = kazoo_util:kz_get_acc_doc(Context),
    z_context:set_session('kazoo_is_reseller', modkazoo_util:get_value(<<"is_reseller">>,AccountDoc,'false'), Context),
    z_context:set_session('kazoo_superduper_admin', modkazoo_util:get_value(<<"superduper_admin">>,AccountDoc,'false'), Context),
    case (modkazoo_util:get_value(<<"is_reseller">>,AccountDoc) == 'true' orelse  modkazoo_util:get_value(<<"superduper_admin">>,AccountDoc) == 'true') of
        'true' -> 
            AccountId = z_context:get_session(kazoo_account_id, Context),
            KazooOwnerId = z_context:get_session(kazoo_owner_id, Context),
            modkazoo_util:set_session_jobj('kazoo_reseller_user_tracking', AccountId, KazooOwnerId, ?EMPTY_JSON_OBJECT, Context),
            z_context:set_session(kazoo_reseller_owner_id, KazooOwnerId, Context),
            z_context:set_session(kazoo_reseller_account_id, AccountId, Context);
        'false' -> 'ok'
    end.

signout(Context) ->
    {ok, Context1} = z_session_manager:stop_session(Context),
    z_render:wire({redirect, [{dispatch, "home"}]}, Context1).

gcapture_check(Context) ->
    case z_context:get_session(kazoo_reseller_account_id, Context) of
        'undefined' ->
            CaptSecret = m_config:get_value('mod_kazoo', 'g_capture_secret', Context),
            GCaptureResp = z_context:get_q("g-recaptcha-response",Context),
            {ClientIP, _}  = webmachine_request:peer(z_context:get_reqdata(Context)),
            URL = list_to_binary(["https://www.google.com/recaptcha/api/siteverify?secret=", CaptSecret, "&response=", GCaptureResp, "&remoteip=", ClientIP]),
            {'ok', {{"HTTP/1.1", _ReturnCode, _State}, _Head, Body}} = httpc:request('get', {binary_to_list(URL), []}, [], []),
            {JsonData} = jiffy:decode(Body),
            proplists:get_value(<<"success">>, JsonData);
        _ -> 'true'
    end.

process_signup_form(Context) ->
    {'new_account_id', AccountId} = kazoo_util:create_kazoo_account(Context),
    spawn('kazoo_util', 'kz_create_default_callflow_sec', [20000, AccountId, Context]),
 %   _ = kazoo_util:add_service_plan(m_config:get_value('mod_kazoo', 'signup_service_plan', Context), AccountId, Context),
    case z_context:get_q("rs_sign_up",Context) of
        'undefined' -> z_render:update("sign_up_div", z_template:render("_registration_completed.tpl", [], Context), Context);
        _ -> 
            Context1 = z_render:dialog_close(Context),
            z_render:update("reseller_children_area", z_template:render("reseller_children.tpl", [{account_id, AccountId}], Context1), Context1)
    end.

may_be_add_third_party_billing(Context) ->
    case z_module_manager:active('mod_lb', Context) of
        'true' -> lb_auth:lb_auth_search(kazoo_util:kz_account_numbers(Context), Context);
        'false' -> 'ok'
    end.

may_be_clean_third_party_billing(Context) ->
    case z_module_manager:active('mod_lb', Context) of
        'true' -> lb_auth:lb_auth_clean_session(Context);
        'false' -> 'ok'
    end.
