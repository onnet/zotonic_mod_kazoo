-module(modkazoo_auth).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([is_auth/1
    ,is_superadmin_or_reseller/1
    ,refresh_superadmin_and_reseller_flags/1
    ,do_sign_in/4
    ,gcapture_check/1
    ,process_signup_form/1
    ,may_be_add_third_party_billing/1
    ,may_be_set_reseller_data/1
    ,may_be_set_user_data/1
    ,choose_page_to_redirect/1
    ,may_be_clean_third_party_billing/1
    ,set_session_billing_status_vars/1
    ,setup_environment/6
    ,is_peer_phiz_whitelisted/1
]).

-include_lib("zotonic_core/include/zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

is_auth(Context) ->
    case kazoo_util:kz_get_acc_doc(Context) of
        <<>> -> 'false';
        _ -> 
            (modkazoo_util:is_defined(z_context:get_session(kazoo_auth_token, Context))
                andalso
             modkazoo_util:is_defined(z_context:get_session(kazoo_account_id, Context)))
    end.

is_superadmin_or_reseller(Context) ->
    case z_context:get_session('kazoo_is_reseller', Context) of
        'undefined' ->
            _ = set_superadmin_and_reseller_flags(Context),
            z_context:get_session('kazoo_superduper_admin', Context, 'false')
                orelse z_context:get_session('kazoo_is_reseller', Context, 'false');
        _ ->
            z_context:get_session('kazoo_superduper_admin', Context, 'false')
                orelse z_context:get_session('kazoo_is_reseller', Context, 'false')
    end.

set_superadmin_and_reseller_flags(Context) ->
    AccountDoc = kazoo_util:kz_get_acc_doc(Context),
    z_context:set_session('kazoo_is_reseller', modkazoo_util:get_value(<<"is_reseller">>,AccountDoc,'false'), Context),
    z_context:set_session('kazoo_superduper_admin'
                         ,modkazoo_util:get_value(<<"superduper_admin">>,AccountDoc,'false')
                         ,Context).

clean_superadmin_and_reseller_flags(Context) ->
    z_context:set_session('kazoo_is_reseller', 'undefined', Context),
    z_context:set_session('kazoo_superduper_admin', 'undefined', Context).

refresh_superadmin_and_reseller_flags(Context) ->
    _ = clean_superadmin_and_reseller_flags(Context),
    _ = set_superadmin_and_reseller_flags(Context).

do_sign_in(Login, Password, Account, Context) ->
    ClientIP = cowmachine_req:peer(z_context:get_reqdata(Context)),
    case kazoo_util:kz_user_creds(modkazoo_util:to_lower_binary(Login), Password, Account, Context) of
        {'ok', {'owner_id', _}, {account_id, 'undefined'}, {'auth_token', _}, {'crossbar', _}, {'account_name', _}} ->
            lager:info("Failed to authenticate Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            z_render:growl_error(?__("Admin auth failed.", Context), Context);
        {'ok', {'owner_id', _}, {account_id, _}, {'auth_token', <<>>}, {'crossbar', _}, {'account_name', _}} ->
            lager:info("Failed to authenticate Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            z_render:growl_error(?__("Admin auth failed.", Context), Context);
        {'ok',{'owner_id', Owner_Id}
             ,{'account_id', Account_Id}
             ,{'auth_token', Auth_Token}
             ,{'crossbar', _Crossbar_URL}
             ,{'account_name', Account_Name}
        } ->
            lager:info("Succesfull authentication of Kazoo user ~p@~p. IP address: ~p.", [Login,Account,ClientIP]),
            lager:info("Session ID: ~p.", [z_session_manager:get_session_id(Context)]),
            lager:info("AuthToken: ~p.", [Auth_Token]),
            mod_signal:emit({page_mask_signal
                            ,?SIGNAL_FILTER(Context) ++ [{'target', "sign_in_form"}]
                            }
                           ,Context),
            mod_signal:emit({emit_growl_signal
                            ,?SIGNAL_FILTER(Context) ++ [{'text',?__("Signing in ...", Context)},{'type', 'notice'}]
                            }
                           ,Context),
            AccountDoc = kazoo_util:kz_get_acc_doc_by_account_id_and_authtoken(Account_Id, Auth_Token, Context),
            case modkazoo_util:get_value(<<"crossbar_ip_acl">>, AccountDoc) of
                'undefined' ->
                    setup_environment(Owner_Id, Auth_Token, Account_Id, Account_Name, Login, Context);
                ACL ->
                    maybe_setup_environment(Owner_Id, Auth_Token, Account_Id, Account_Name, Login, ACL, ClientIP, Context)
            end;
        {'badauth', Code, Data} ->
            lager:info("SessionID: ~p.", [z_session_manager:get_session_id(Context)]),
            lager:info("Failed (badauth) to authenticate Kazoo user ~p@~p. IP address: ~p. Data: ~p.", [Login,Account,ClientIP,Data]),
            lager:info("Failed to authenticate Kazoo user ~p@~p. Code: ~p.", [Login,Account,Code]),
            lager:info("Failed to authenticate Kazoo user ~p@~p. Data: ~p.", [Login,Account,Data]),
            growl_login_error(Data, Context);
        _E ->
            lager:info("Failed (E) to authenticate Kazoo user ~p@~p. IP address: ~p. Error: ~p", [Login,Account,ClientIP, _E]),
            z_render:growl_error(?__("Auth failed.", Context), Context)
    end.

growl_login_error(Data, Context) ->
    case modkazoo_util:get_value([<<"account">>,<<"disabled">>], Data) of
        'undefined' ->
            z_render:growl_error(?__("Auth failed.", Context), Context);
        _ ->
            z_render:growl_error(?__("Account disabled.", Context), Context)
    end.

maybe_setup_environment(Owner_Id, Auth_Token, Account_Id, Account_Name, Login, ACL, ClientIP, Context) ->
    case run_ip_acl(ACL, ClientIP) of
        'true' ->
            setup_environment(Owner_Id, Auth_Token, Account_Id, Account_Name, Login, Context);
        _ -> 
            lager:info("Failed to pass IP ACL check ~p. IP address: ~p.", [ACL,ClientIP]),
            z_render:growl_error(?__("ACL violation.", Context), Context)
    end.

setup_environment(Owner_Id, Auth_Token, Account_Id, Account_Name, Login, Context0) ->
    {'ok', Context} = z_session_manager:ensure_session(Context0),
    z_context:set_session(auth_timestamp, calendar:universal_time(), Context),
    z_context:set_session(kazoo_owner_id, Owner_Id, Context),
    z_context:set_session(kazoo_auth_token, Auth_Token, Context),
    z_context:set_session(kazoo_account_id, Account_Id, Context),
    z_context:set_session(kazoo_account_name, Account_Name, Context),
    z_context:set_session(kazoo_login_name, Login, Context),
    _ = may_be_set_user_data(Context),
    _ = may_be_set_reseller_data(Context),
    _ = may_be_add_third_party_billing(Context),
    _ = set_session_billing_status_vars(Context),
    choose_page_to_redirect(Context).

choose_page_to_redirect(Context) ->
    case is_superadmin_or_reseller(Context) of
        'true' ->
            z_render:wire({redirect, [{dispatch, reseller_portal}]}, Context);
        'false' -> 
            case z_dispatcher:url_for('dashboard', Context) of
                'undefined' -> 
                    case z_context:get_session('kazoo_account_admin', Context) of 
                        'true' ->
                            z_render:wire({redirect, [{dispatch, admin_settings}]}, Context);
                        'false' ->
                            z_render:wire({redirect, [{dispatch, user_portal}]}, Context)
                    end;
                _D ->
                    z_render:wire({redirect, [{dispatch, dashboard}]}, Context) 
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
    _ = clean_superadmin_and_reseller_flags(Context),
    case is_superadmin_or_reseller(Context) of
        'true' -> 
            AccountId = z_context:get_session(kazoo_account_id, Context),
            KazooOwnerId = z_context:get_session(kazoo_owner_id, Context),
            modkazoo_util:set_session_jobj('kazoo_reseller_user_tracking', AccountId, KazooOwnerId, ?EMPTY_JSON_OBJECT, Context),
            z_context:set_session(kazoo_reseller_owner_id, KazooOwnerId, Context),
            z_context:set_session(kazoo_reseller_account_id, AccountId, Context);
        'false' ->
            clean_superadmin_and_reseller_flags(Context)
    end.

gcapture_check(Context) ->
    case z_context:get_session(kazoo_reseller_account_id, Context) of
        'undefined' ->
            CaptSecret = m_vars:get_value('mod_kazoo', 'g_capture_secret', Context),
            GCaptureResp = z_context:get_q(<<"g-recaptcha-response">>,Context),
            ClientIP = cowmachine_req:peer(z_context:get_reqdata(Context)),
            URL = <<"https://www.google.com/recaptcha/api/siteverify?secret="
                   ,CaptSecret/binary
                   ,"&response="
                   ,GCaptureResp/binary
                   ,"&remoteip="
                   ,ClientIP/binary>>,
            {'ok', {{"HTTP/1.1", _ReturnCode, _State}, _Head, Body}} = httpc:request('get', {z_convert:to_list(URL), []}, [], []),
            {JsonData} = jiffy:decode(Body),
            proplists:get_value(<<"success">>, JsonData);
        _ -> 'true'
    end.

process_signup_form(Context) ->
    {'new_account_id', AccountId} = kazoo_util:create_kazoo_account(Context),
    case z_context:get_q("rs_sign_up",Context) of
        'undefined' ->
            z_render:update("sign_up_div", z_template:render("_registration_completed.tpl", [], Context), Context);
        _ -> 
            Context1 = z_render:dialog_close(Context),
            z_context:set_session(rs_selected_account_id, AccountId, Context),
            z_render:update("reseller_children_area", z_template:render("reseller_children.tpl", [], Context1), Context1)
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

run_ip_acl([H|T], ClientIP) ->
    case orber_acl:verify(z_convert:to_list(ClientIP), z_convert:to_list(H), inet) of
        true -> true;
        _ -> run_ip_acl(T,ClientIP)
    end;
run_ip_acl(_,_) -> false.

set_session_billing_status_vars(Context) ->
    Vars = onbill_util:billing_status(Context),
    z_context:set_session('display_billing'
                         ,modkazoo_util:get_value(<<"display_billing">>,Vars,'true')
                         ,Context),
    z_context:set_session('display_e911'
                         ,modkazoo_util:get_value(<<"display_e911">>,Vars,'true')
                         ,Context),
    z_context:set_session('currency_sign'
                         ,modkazoo_util:get_value(<<"currency_sign">>,Vars,<<"₽"/utf8>>)
                         ,Context).

is_peer_phiz_whitelisted(Context) ->
    z_ip_address:ip_match(m_req:get(peer, Context), ip_whitelist(Context)).

ip_whitelist(Context) ->
    SiteWhitelist = m_vars:get_value(phiz_ip_whitelist, Context),
    case z_utils:is_empty(SiteWhitelist) of
        true -> z_config:get(ip_whitelist);
        false -> SiteWhitelist
    end.

