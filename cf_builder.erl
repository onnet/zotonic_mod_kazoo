-module(cf_builder).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([cf_add_number/2
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
    ,cf_build_ring_group_endpoints/1
    ,cf_build_page_group_endpoints/1
    ,cf_calculate_ring_group_timeout/1
    ,cf_child/2
    ,cf_load_to_session/2
    ,cf_may_be_add_child/4
    ,cf_delete_element/2
    ,cf_park_element/2
    ,cf_get_element_by_id/2
    ,cf_handle_drop/2
    ,cf_choose_new_switch/3
    ,cf_set_new_switch/3
    ,cf_time_of_the_day/1
    ,cf_delete_time_of_the_day_rule/2
    ,cf_get_module_info/3
    ,may_be_check_cid_children_clean/1
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

cf_add_number(Number, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context, ?EMPTY_CALLFLOW) of
        'undefined' -> ?EMPTY_CALLFLOW;
        <<>> -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    Numbers = modkazoo_util:get_value([<<"numbers">>], CurrentCallflow, []) ++ [?TO_BIN(Number)],
    z_context:set_session('current_callflow', modkazoo_util:set_value([<<"numbers">>], Numbers, CurrentCallflow), Context).

cf_add_pattern(Pattern, Context) ->
    CurrentCallflow = case z_context:get_session('current_callflow', Context, ?EMPTY_CALLFLOW) of
        'undefined' -> ?EMPTY_CALLFLOW;
        <<>> -> ?EMPTY_CALLFLOW;
        Callflow -> Callflow
    end,
    Patterns = modkazoo_util:get_value([<<"patterns">>], CurrentCallflow, []) ++ [?TO_BIN(Pattern)],
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
        <<>> -> ?EMPTY_CALLFLOW;
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
            case kazoo_util:crossbar_account_request('put', API_String, DataBag, Context) of
                <<>> -> z_render:growl_error(?__("Something wrong happened.", Context), Context); 
                Result ->
                    cf_set_session('current_callflow', <<"id">>, modkazoo_util:get_value(<<"id">>,Result), Context),
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
                    z_render:growl(?__("Callflow saved", Context), Context)
            end;
        Id ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?CALLFLOWS/binary, "/", ?TO_BIN(Id)/binary>>,
            case kazoo_util:crossbar_account_request('post', API_String, ?MK_DATABAG(z_context:get_session('current_callflow', Context)), Context) of
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
            kazoo_util:crossbar_account_request('delete', API_String, [], Context),
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

cf_child([{tool_name,ToolName},{drop_id,DropId},{drop_parent,DropParent},{branch_id,BranchId},{switch,Switch}],Context) ->
    PathToChildren = case BranchId of
        <<"flow0">> -> <<"flow-root">>;
        _ -> <<DropId/binary, "-children">>
    end,
    ElementId = case BranchId of
        <<"flow0">> -> DropId;
        _ -> <<DropId/binary, "-children-", Switch/binary>>
    end,
    lager:info("Drop Switch: ~p",[Switch]),
    lager:info("Drop PathToChildren: ~p",[PathToChildren]),
    lager:info("Drop ElementId: ~p",[ElementId]),
    lager:info("Drop DropParent: ~p",[DropParent]),
    lager:info("Drop ToolName: ~p",[ToolName]),
    lager:info("Element doesn't exist: ~p",[cf_child_not_exists(ElementId, Context)]),
    'true' = cf_child_not_exists(ElementId, Context),
    case ToolName of
        <<"branch_recovery">> ->
            case z_context:get_session('cf_park_slot1', Context) of
                'undefined' -> 
                    Context2 = z_render:dialog_close(Context),
                    z_render:growl(?__("No saved brunch", Context2), Context2);
                ParkedBranch ->
                    _ = cf_set_session('current_callflow', binary:split(ElementId,<<"-">>,[global]), ParkedBranch, Context),
                    mod_signal:emit({update_cf_builder_area, ?SIGNAL_FILTER(Context)}, Context),
                    z_render:dialog_close(Context)
            end;
        <<"dead_air">> ->
            cf_set_session('current_callflow', binary:split(ElementId,<<"-">>,[global])++[<<"module">>], ToolName, Context),
            cf_set_session('current_callflow', binary:split(ElementId,<<"-">>,[global])++[<<"children">>], {[]}, Context),
            cf_set_session('current_callflow', binary:split(ElementId,<<"-">>,[global])++[<<"data">>], {[]}, Context),
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
            ModalHeader =
                case ToolName of
                    <<"disa">> -> <<"Configure">>;
                    <<"response">> -> <<"Configure">>;
                    _ -> <<"Select">>
                end,
            cf_set_session('current_callflow', binary:split(ElementId,<<"-">>,[global])++[<<"module">>], ToolName, Context),
            cf_set_session('current_callflow', binary:split(ElementId,<<"-">>,[global])++[<<"children">>], {[]}, Context),
            z_render:dialog(<<(?__(ModalHeader, Context1))/binary, " ">>
                           ,<<"_cf_select_", ToolName/binary, ".tpl">>
                           ,[{element_id, ElementId},{tool_name,ToolName}], Context1)
    end.

cf_child_not_exists(ElementId, Context) ->
    'undefined' == modkazoo_util:get_value(cf_element_path(<<ElementId/binary, "-module">>)
                                          ,z_context:get_session('current_callflow', Context)).

cf_load_to_session(CallflowId,Context) ->
    case CallflowId of
        [] -> 'ok';
        'undefined' -> 'ok';
        <<>> -> 'ok';
        <<"new">> -> z_context:set_session('current_callflow', ?EMPTY_CALLFLOW, Context);
        _ -> z_context:set_session('current_callflow', kazoo_util:kz_get_account_callflow(CallflowId, Context), Context)
    end.

cf_may_be_add_child(BranchId,DropId,DropParent,Context) ->
    case BranchId of
        <<"flow0">> -> cf_may_be_add_root_child(Context);
        _ -> cf_may_be_add_desc_child(BranchId,DropId,DropParent,Context)
    end.

cf_may_be_add_root_child(Context) ->
    lager:info("=============== Root child ======================="),
    case modkazoo_util:get_value([<<"flow">>,<<"module">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> Context;
        ModuleName ->
            lager:info("may_be_add_child ModuleName: ~p",[ModuleName]),
            [KzElementId, KzElementName] = cf_get_module_info(ModuleName,[<<"flow">>],Context),
            lager:info("may_be_add_child KzElementId: ~p",[KzElementId]),
            lager:info("may_be_add_child KzElementName: ~p",[KzElementName]),
            z_render:insert_bottom(<<"flow-root">>, z_template:render("_cf_child.tpl",[{tool_name,ModuleName}
                                                                                      ,{element_id,<<"flow">>}
                                                                                      ,{kz_element_id, KzElementId}
                                                                                      ,{kz_element_name, KzElementName}
                                                                                      ,{drop_parent,<<"root">>}],Context),Context)
    end.

cf_may_be_add_desc_child(BranchId,DropId,DropParent,Context) ->
    lager:info("================ May be Descendant Child ======================"),
    lager:info("cf_may_be_add_desc_child BranchId: ~p",[BranchId]),
    lager:info("cf_may_be_add_desc_child DropId: ~p",[DropId]),
    lager:info("cf_may_be_add_desc_child DropParent: ~p",[DropParent]),
    ElementPath = binary:split(BranchId, <<"-">>, [global]),
    lager:info("cf_may_be_add_desc_child ElementPath: ~p",[ElementPath]),
    case modkazoo_util:get_value(ElementPath++[<<"children">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> Context;
        {[]} -> Context;
        Children ->
            lager:info("cf_may_be_add_desc_child Children: ~p",[Children]),
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
    PathToChildren = <<BranchId/binary, "-children">>,
    lager:info("cf_add_desc_child PathToChildren: ~p",[PathToChildren]),
    ElementId = <<PathToChildren/binary, "-", Switch/binary>>,
    lager:info("cf_add_desc_child ElementId: ~p",[ElementId]),
    ElementPath = binary:split(BranchId,<<"-">>,[global]),
    ParentModuleName = modkazoo_util:get_value(ElementPath++[<<"module">>],z_context:get_session('current_callflow', Context)),
    lager:info("cf_add_desc_child ParentModuleName: ~p",[ParentModuleName]),
    ModulePath = ElementPath++[<<"children">>,Switch],
    lager:info("cf_add_desc_child ModulePath: ~p",[ModulePath]),
    ModuleName = modkazoo_util:get_value(ModulePath++[<<"module">>],z_context:get_session('current_callflow', Context)),
    lager:info("cf_add_desc_child ModuleName: ~p",[ModuleName]),
    [KzElementId, KzElementName] = cf_get_module_info(ModuleName,ModulePath,Context),
    z_render:insert_bottom(PathToChildren
                          ,z_template:render(<<"_cf_child.tpl">>
                                            ,[{tool_name, ModuleName}
                                             ,{element_id, ElementId}
                                             ,{kz_element_id, KzElementId}
                                             ,{kz_element_name, KzElementName}
                                             ,{drop_parent, ParentModuleName}
                                             ,{switch, Switch}
                                             ]
                                            ,Context)
                          ,Context).

cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"user">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            UserDoc = kazoo_util:kz_get_user_doc(Id, Context),
            [Id,<<(modkazoo_util:get_value(<<"first_name">>,UserDoc))/binary
                 ,<<" ">>/binary
                 ,(modkazoo_util:get_value(<<"last_name">>,UserDoc))/binary>>];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"device">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' ->
            DeviceDoc = kazoo_util:kz_get_device_doc(Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,DeviceDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"voicemail">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            VMBoxDoc = kazoo_util:kz_list_user_vmbox_details(Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,VMBoxDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"play">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            MediaDoc = kazoo_util:kz_get_account_prompt(Id, Context),
            [Id,modkazoo_util:get_value(<<"name">>,MediaDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"menu">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            MenuDoc = kazoo_util:kz_menu('get', Id, Context),
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
            CallflowDoc = kazoo_util:kz_get_account_callflow(Id, Context),
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
            UserDoc = kazoo_util:kz_get_user_doc(Id, Context),
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
    List = kazoo_util:kz_get_account_list(ListId, Context),
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
            Doc = kazoo_util:kz_conference('get', Id,Context),
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
                'undefined' -> [Id, kazoo_util:kz_get_name(Id, Type, Context)];
                Name -> [Id,Name]
            end
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"response">> ->
    Code = modkazoo_util:get_value_bin(ModulePath++[<<"data">>,<<"code">>],z_context:get_session('current_callflow', Context)), 
    ['undefined', <<"SIP Code: ", Code/binary>>];
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"acdc_member">> ->
    Id = modkazoo_util:get_value(ModulePath++[<<"data">>,<<"id">>],z_context:get_session('current_callflow', Context)),
    case modkazoo_util:get_value([<<"metadata">>,Id,<<"name">>],z_context:get_session('current_callflow', Context)) of
        'undefined' -> 
            AccountId = z_context:get_session('kazoo_account_id', Context),
            QueueDoc = kazoo_util:queue('get', Id, AccountId, [], Context),
            [Id,modkazoo_util:get_value(<<"name">>,QueueDoc)];
        Name -> [Id, Name]
    end;
cf_get_module_info(ModuleName,ModulePath,Context) when ModuleName == <<"acdc_agent">> ->
    case modkazoo_util:get_value(ModulePath++[<<"data">>,<<"action">>]
                                ,z_context:get_session('current_callflow', Context)
                                )
    of
        <<"login">> -> ['undefined', <<"Login">>];
        <<"logout">> -> ['undefined', <<"Logout">>];
        <<"pause">> -> ['undefined', <<"Pause">>];
        <<"resume">> -> ['undefined', <<"Resume">>]
    end;
cf_get_module_info(_ModuleName,_ModulePath,_Context) ->
    ['undefined','undefined'].

cf_delete_element(ElementId,Context) ->
    modkazoo_util:delete_session_jobj_key('current_callflow', cf_element_path(ElementId), Context).
    
cf_park_element(ElementId,Context) ->
    ParkCandidate = modkazoo_util:get_value(cf_element_path(ElementId), z_context:get_session('current_callflow', Context)),
    z_context:set_session('cf_park_slot1', ParkCandidate, Context),
    z_render:growl(?__("Branch saved", Context), Context).

cf_element_path(ElementId) ->
    binary:split(ElementId, <<"-">>, [global]).

cf_get_element_by_id(ElementId, Context) ->
    modkazoo_util:get_value(cf_element_path(ElementId), z_context:get_session('current_callflow', Context)). 

cf_handle_drop({drop,{dragdrop,{drag_args,[{tool_name,ToolName}]},mod_kazoo,_}
                    ,{dragdrop,{drop_args,[{drop_id,DropId},{drop_parent,DropParent}]},mod_kazoo,BranchId}}
              ,Context) ->
    case DropParent of
        <<"cidlistmatch">> ->
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
        <<"check_cid">> ->
            [KeysList,AddOn] =
                case modkazoo_util:get_value(cf_element_path(BranchId)++[<<"data">>,<<"use_absolute_mode">>]
                                            ,z_context:get_session('current_callflow', Context))
                of
                    'false' -> [[<<"nomatch">>,<<"match">>],[]];
                    'true' -> [[<<"_">>],[<<"caller_id">>]] 
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
        <<"menu">> ->
            z_render:dialog(?__("Menu option",Context)
                                 ,"_cf_select_option.tpl"
                                 ,[{tool_name,ToolName}
                                  ,{drop_id,DropId}
                                  ,{drop_parent,DropParent}
                                  ,{branch_id,BranchId}
                                  ,{available_keys,cf_available_keys(?MENU_KEYS_LIST,cf_element_path(BranchId),Context)}]
                                 ,Context);
        <<"temporal_route">> ->
            KeysList = [<<"_">>]++lists:map(fun(X) -> modkazoo_util:get_value(<<"id">>,X) end, kazoo_util:kz_list_account_temporal_rules(Context)),
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
                <<"flow0">> -> <<"">>;
                _ -> <<"_">>
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
        <<"cidlistmatch">> ->
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
        <<"check_cid">> ->
            [KeysList,AddOn] =
                case modkazoo_util:get_value(lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))
                                               ++[<<"data">>,<<"use_absolute_mode">>]
                                            ,z_context:get_session('current_callflow', Context))
                of
                    'false' -> [[<<"nomatch">>,<<"match">>],[]];
                    'true' -> [[<<"_">>],[<<"caller_id">>]]
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
        <<"menu">> ->
            z_render:dialog(?__("Menu option",Context)
                               , "_cf_select_option.tpl"
                               ,[{existing_element_id,ExistingElementId}
                                ,{kz_element_id,hd(lists:reverse(binary:split(ExistingElementId,<<"-">>,[global])))}
                                ,{available_keys,cf_available_keys(?MENU_KEYS_LIST
                                                                  ,lists:reverse(tl(tl(lists:reverse(cf_element_path(ExistingElementId)))))
                                                                  ,Context)}]
                            ,Context);
        <<"temporal_route">> ->
            KeysList = [<<"_">>]++lists:map(fun(X) -> modkazoo_util:get_value(<<"id">>,X) end, kazoo_util:kz_list_account_temporal_rules(Context)),
            z_render:dialog(?__("Menu option",Context)
                                 ,"_cf_select_option_temporal_route.tpl"
                               ,[{existing_element_id,ExistingElementId}
                                ,{kz_element_id,hd(lists:reverse(binary:split(ExistingElementId,<<"-">>,[global])))}
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
    StartDate = calendar:datetime_to_gregorian_seconds({{z_convert:to_integer(z_string:trim(StartYear))
                                                        ,z_convert:to_integer(z_string:trim(StartMonth))
                                                        ,z_convert:to_integer(z_string:trim(StartDay))}
                                                        ,{0,0,0}}),
    Id = z_context:get_q("id",Context),
    Props = [{<<"time_window_start">>, ?TO_BIN(TimeWindowStart)}
            ,{<<"time_window_stop">>, ?TO_BIN(TimeWindowStop)}
            ,{<<"wdays">>, case Wdays of 'undefined' -> 'undefined'; _ -> lists:map(fun(Wday) -> ?TO_BIN(Wday) end, Wdays) end}
            ,{<<"days">>, case Days of 'undefined' -> 'undefined'; _ -> lists:map(fun(Day) -> ?TO_BIN(Day) end, [Days]) end}
            ,{<<"interval">>, z_context:get_q(interval,Context)}
            ,{<<"cycle">>, z_context:get_q(cycle,Context)}
            ,{<<"name">>, z_context:get_q(name,Context)}
            ,{<<"type">>, z_context:get_q(type,Context)}
            ,{<<"start_date">>, StartDate}
            ,{<<"id">>, ?TO_BIN(Id)}
            ,{<<"enabled">>, z_convert:to_atom(z_context:get_q("enabled",Context))}
            ,{<<"ordinal">>, z_context:get_q(ordinal,Context)}
            ,{<<"month">>, z_context:get_q(month,Context)}],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case Id of
        'undefined'->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary>>,
            kazoo_util:crossbar_account_request('put', API_String, DataBag, Context);
        _ ->
            API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary, "/", ?TO_BIN(Id)/binary>>,
            kazoo_util:crossbar_account_request('post', API_String, DataBag, Context)
    end.

cf_delete_time_of_the_day_rule(RuleId,Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS(Context)/binary, ?TEMPORAL_RULES/binary, "/", ?TO_BIN(RuleId)/binary>>,
    kazoo_util:crossbar_account_request('delete', API_String, [], Context).

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
