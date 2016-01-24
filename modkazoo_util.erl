-module(modkazoo_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([new/0
    ,is_defined/1
    ,pad_month/1
    ,get_keys/1
    ,get_keys/2
    ,delete_key/2
    ,delete_keys/2
    ,get_value_bin/2
    ,get_value/2
    ,get_value/3
    ,get_value1/3
    ,get_values/1
    ,get_values/2
    ,set_value/3
    ,set_values/2
    ,get_json_value/2
    ,get_json_value/3
    ,check_field_filled/2
    ,normalize_account_name/1
    ,to_lower_binary/1
    ,to_lower_string/1
    ,to_upper_binary/1
    ,to_upper_string/1
    ,to_upper_char/1
    ,to_proplist/1
    ,to_proplist/2
    ,ucfirst_binary/1
    ,lcfirst_binary/1
    ,rand_hex_binary/1
    ,on_to_true/1
    ,current_tstamp/1
    ,today_begins_tstamp/1
    ,today_ends_tstamp/1
    ,day_begins_tstamp/2
    ,day_ends_tstamp/2
    ,day_ago_tstamp/1
    ,week_ago_tstamp/1
    ,month_ago_tstamp/1
    ,filter_undefined/1
    ,filter_empty/1
    ,check_file_size_exceeded/3
    ,prune/2
    ,no_prune/2
    ,is_json_object/2
    ,is_valid_json_object/1
    ,count_activation_charge/1
    ,set_session_jobj/5
    ,delete_session_jobj_key/3
    ,get_session_jobj_value/3
    ,split_b/2
    ,format_account_id/2
    ,get_q_bin/2
    ,get_q_atom/2
    ,get_q_integer/2
    ,cleanout/1
    ,props_get_values/2
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_kazoo.hrl").

is_defined(Var) ->
    case Var of
        'undefined' -> false;
        "" -> false;
        <<"">> -> false;
        _ -> true
    end.

pad_month(Month) when Month < 10 ->
    <<"0", (z_convert:to_binary(Month))/binary>>;
pad_month(Month) ->
    z_convert:to_binary(Month).

get_keys(JObj) -> get_keys1(JObj).

get_keys([], JObj) -> get_keys1(JObj);
get_keys(Keys, JObj) -> get_keys1(get_value(Keys, JObj, new())).

get_keys1(KVs) when is_list(KVs) -> lists:seq(1,length(KVs));
get_keys1(JObj) -> proplists:get_keys(to_proplist(JObj)).

to_proplist(JObjs) when is_list(JObjs) -> [to_proplist(JObj) || JObj <- JObjs];
to_proplist(?JSON_WRAPPER(Prop)) -> Prop.

%% convert everything starting at a specific key
to_proplist(Key, JObj) -> to_proplist(get_json_value(Key, JObj, new())).

get_json_value(Key, JObj) -> get_json_value(Key, JObj, 'undefined').
get_json_value(Key, ?JSON_WRAPPER(_)=JObj, Default) ->
    case get_value(Key, JObj) of
        'undefined' -> Default;
        ?JSON_WRAPPER(_)=V -> V;
        _ -> Default
    end;
get_json_value(_, _, Default) ->
    Default.

get_value_bin(Key, JObj) ->
    z_convert:to_binary(get_value(Key, JObj)).

get_value(Key, JObj) ->
    get_value(Key, JObj, 'undefined').

get_value([Key|Ks], L, Default) when is_list(L) ->
    try
        get_value1(Ks, lists:nth(z_convert:to_integer(Key), L), Default)
    catch
        'error':'badarg' -> Default;
        'error':'badarith' -> Default;
        'error':'function_clause' -> Default
    end;
get_value(K, Doc, Default) -> get_value1(K, Doc, Default).

get_value1([], JObj, _Default) ->
    JObj;
get_value1(Key, JObj, Default) when not is_list(Key)->
    get_value1([Key], JObj, Default);
get_value1([K|Ks], JObjs, Default) when is_list(JObjs) ->
    try lists:nth(z_convert:to_integer(K), JObjs) of
        'undefined' -> Default;
        JObj1 -> get_value1(Ks, JObj1, Default)
    catch
        _:_ -> Default
    end;
get_value1([K|Ks], ?JSON_WRAPPER(Props)=_JObj, Default) ->
    get_value1(Ks, proplists:get_value(K, Props, Default), Default);
get_value1(_, _, Default) -> Default.

%% split the json object into values and the corresponding keys
get_values(JObj) ->
    lists:foldr(fun(Key, {Vs, Ks}) ->
                        {[get_value(Key, JObj)|Vs], [Key|Ks]}
                end, {[], []}, ?MODULE:get_keys(JObj)).

get_values(Key, JObj) ->
    get_values(get_value(Key, JObj, new())).
  
%% Figure out how to set the current key among a list of objects
set_values(KVs, JObj) when is_list(KVs) ->
    lists:foldr(fun({K,V}, JObj0) -> set_value(K, V, JObj0) end, JObj, KVs).

set_value(Keys, Value, JObj) when is_list(Keys) -> 
    KeysL = case is_list(hd(Keys)) orelse is_binary(hd(Keys)) of
        'false' -> [z_convert:to_binary(Keys)];
        'true' -> lists:map(fun(Field) -> z_convert:to_binary(Field) end, Keys)
    end,
    set_value1(KeysL, Value, JObj);
set_value(Key, Value, JObj) -> set_value1([Key], Value, JObj).

set_value1([Key|_]=Keys, Value, []) when not is_integer(Key) -> set_value1(Keys, Value, new());
set_value1([Key|T], Value, JObjs) when is_list(JObjs) ->
    Key1 = z_convert:to_integer(Key),
    case Key1 > length(JObjs) of
        %% The object index does not exist so try to add a new one to the list
        'true' ->
            try
                %% Create a new object with the next key as a property
                JObjs ++ [ set_value1(T, Value, set_value1([hd(T)], [], new())) ]
            catch
                %% There are no more keys in the list, add it unless not an object
                _:_ ->
                    try
                        JObjs ++ [Value]
                    catch _:_ -> erlang:error('badarg')
                    end
            end;
        %% The object index exists so iterate into the object and update it
        'false' ->
            element(1, lists:mapfoldl(fun(E, {Pos, Pos}) ->
                                              {set_value1(T, Value, E), {Pos + 1, Pos}};
                                         (E, {Pos, Idx}) ->
                                              {E, {Pos + 1, Idx}}
                                      end, {1, Key1}, JObjs))
    end;
%% Figure out how to set the current key in an existing object
set_value1([Key1|T], Value, ?JSON_WRAPPER(Props)) ->
    case lists:keyfind(Key1, 1, Props) of
        {Key1, ?JSON_WRAPPER(_)=V1} ->
            %% Replace or add a property in an object in the object at this key
            ?JSON_WRAPPER(lists:keyreplace(Key1, 1, Props, {Key1, set_value1(T, Value, V1)}));
        {Key1, V1} when is_list(V1) ->
            %% Replace or add a member in an array in the object at this key
            ?JSON_WRAPPER(lists:keyreplace(Key1, 1, Props, {Key1, set_value1(T, Value, V1)}));
        {Key1, _} when T == [] ->
            %% This is the final key and the objects property should just be replaced
            ?JSON_WRAPPER(lists:keyreplace(Key1, 1, Props, {Key1, Value}));
        {Key1, _} ->
            %% This is not the final key and the objects property should just be
            %% replaced so continue looping the keys creating the necessary json as we go
            ?JSON_WRAPPER(lists:keyreplace(Key1, 1, Props, {Key1, set_value1(T, Value, new())}));
        'false' when T == [] ->
            %% This is the final key and doesnt already exist, just add it to this
            %% objects existing properties
            ?JSON_WRAPPER(Props ++ [{Key1, Value}]);
        'false' ->
            %% This is not the final key and this object does not have this key
            %% so continue looping the keys creating the necessary json as we go
            ?JSON_WRAPPER(Props ++ [{Key1, set_value1(T, Value, new())}])
    end;
%% There are no more keys to iterate through! Override the value here...
set_value1([], Value, _JObj) -> Value.

new() -> ?JSON_WRAPPER([]).

check_field_filled(Field, Context) ->
    case z_context:get_q(Field, Context) of
        [] ->
           false;
        undefined ->
           false;
         _ ->
           ok
    end.

normalize_account_name('undefined') -> 'undefined';
normalize_account_name(AccountName) ->
    << <<Char>>
       || <<Char>> <= modkazoo_util:to_lower_binary(AccountName),
          (Char >= $a andalso Char =< $z)
              orelse (Char >= $0 andalso Char =< $9)
    >>.

to_lower_binary('undefined') -> 'undefined';
to_lower_binary(Bin) when is_binary(Bin) -> << <<(to_lower_char(B))>> || <<B>> <= Bin>>;
to_lower_binary(Else) -> to_lower_binary(z_convert:to_binary(Else)).

-spec to_lower_string(term()) -> 'undefined' | list().
to_lower_string('undefined') -> 'undefined';
to_lower_string(L) when is_list(L) ->
    [to_lower_char(C) || C <- L];
to_lower_string(Else) ->
    to_lower_string(z_convert:to_list(Else)).

ucfirst_binary(<<F:8, Bin/binary>>) -> <<(to_upper_char(F)):8, Bin/binary>>.

lcfirst_binary(<<F:8, Bin/binary>>) -> <<(to_lower_char(F)):8, Bin/binary>>.

-spec to_lower_char(char()) -> char().
to_lower_char(C) when is_integer(C), $A =< C, C =< $Z -> C + 32;
to_lower_char(C) when is_integer(C), 16#C0 =< C, C =< 16#D6 -> C + 32; % from string:to_lower
to_lower_char(C) when is_integer(C), 16#D8 =< C, C =< 16#DE -> C + 32; % so we only loop once
to_lower_char(C) -> C.

to_upper_binary('undefined') -> 'undefined';
to_upper_binary(Bin) when is_binary(Bin) -> << <<(to_upper_char(B))>> || <<B>> <= Bin>>;
to_upper_binary(Else) -> to_upper_binary(z_convert:to_binary(Else)).

-spec to_upper_string(term()) -> 'undefined' | list().
to_upper_string('undefined') -> 'undefined';
to_upper_string(L) when is_list(L) -> [to_upper_char(C) || C <- L];
to_upper_string(Else) -> to_upper_string(z_convert:to_list(Else)).

-spec to_upper_char(char()) -> char().
to_upper_char(C) when is_integer(C), $a =< C, C =< $z -> C - 32;
to_upper_char(C) when is_integer(C), 16#E0 =< C, C =< 16#F6 -> C - 32;
to_upper_char(C) when is_integer(C), 16#F8 =< C, C =< 16#FE -> C - 32;
to_upper_char(C) -> C.


to_hex_binary(S) ->
    Bin = z_convert:to_binary(S),
    << <<(binary_to_hex_char(B div 16)), (binary_to_hex_char(B rem 16))>> || <<B>> <= Bin>>.

rand_hex_binary(Size) when is_integer(Size) andalso Size > 0 ->
    to_hex_binary(crypto:rand_bytes(Size)).

binary_to_hex_char(N) when N < 10 -> $0 + N;
binary_to_hex_char(N) when N < 16 -> $a - 10 + N.

on_to_true(Res) ->
    case Res of
        "on" -> 'true';
        ["on"] -> 'true';
        _ -> 'false'
    end.

current_tstamp(Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt(calendar:universal_time(), Context)).

today_begins_tstamp(Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt({erlang:date(),{0,0,0}}, Context)).

today_ends_tstamp(Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt({erlang:date(),{23,59,59}}, Context)).

day_begins_tstamp(Day, Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt({Day,{0,0,0}}, Context)).

day_ends_tstamp(Day, Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt({Day,{23,59,59}}, Context)).

day_ago_tstamp(Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt(calendar:universal_time(), Context)) - 86400.

week_ago_tstamp(Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt(calendar:universal_time(), Context)) - 604800.

month_ago_tstamp(Context) ->
    calendar:datetime_to_gregorian_seconds(back_to_gmt(calendar:universal_time(), Context)) - 2678400.

back_to_gmt(DateTime, Context) ->
    localtime:local_to_local(DateTime, z_convert:to_list(kazoo_util:may_be_get_timezone(Context)), "GMT").

filter_undefined(Props) ->
    [KV || KV <- Props,
           case KV of
               {_, 'undefined'} -> 'false';
               _ -> 'true'
           end
    ].

filter_empty(Props) ->
    [KV || KV <- Props,
           case KV of
               {_, 'undefined'} -> 'false';
               {_, []} -> 'false';
               {_, <<>>} -> 'false';
               _ -> 'true'
           end
    ].

check_file_size_exceeded(Id, FileName, MaxSize) ->
    case filelib:file_size(FileName) > MaxSize of
        false ->
            false;
        true ->
            {true, Id}
    end.

delete_key(Key, JObj) when not is_list(Key) -> delete_key([Key], JObj, 'no_prune');
delete_key(Keys, JObj) -> 
    KeysL = case is_list(hd(Keys)) orelse is_binary(hd(Keys)) of
        'false' -> [z_convert:to_binary(Keys)];
        'true' -> lists:map(fun(Field) -> z_convert:to_binary(Field) end, Keys)
    end,
    delete_key(KeysL, JObj, 'no_prune').

delete_key(Key, JObj, PruneOpt) when not is_list(Key) ->
    ?MODULE:PruneOpt([Key], JObj);
delete_key(Keys, JObj, PruneOpt) ->
    ?MODULE:PruneOpt(Keys, JObj).

delete_keys(Keys, JObj) when is_list(Keys) ->
    lists:foldr(fun(K, JObj0) -> delete_key(K, JObj0) end, JObj, Keys).

prune([], JObj) ->
    JObj;
prune([K], JObj) when not is_list(JObj) ->
    case lists:keydelete(K, 1, to_proplist(JObj)) of
        [] -> new();
        L -> from_list(L)
    end;
prune([K|T], JObj) when not is_list(JObj) ->
    case get_value(K, JObj) of
        'undefined' -> JObj;
        V ->
            case prune(T, V) of
                ?EMPTY_JSON_OBJECT -> from_list(lists:keydelete(K, 1, to_proplist(JObj)));
                [] -> from_list(lists:keydelete(K, 1, to_proplist(JObj)));
                V1 -> from_list([{K, V1} | lists:keydelete(K, 1, to_proplist(JObj))])
            end
    end;
prune(_, []) -> [];
prune([K|T], [_|_]=JObjs) ->
    V = lists:nth(wh_util:to_integer(K), JObjs),
    case prune(T, V) of
        ?EMPTY_JSON_OBJECT -> replace_in_list(K, 'undefined', JObjs, []);
        V -> replace_in_list(K, 'undefined', JObjs, []);
        V1 -> replace_in_list(K, V1, JObjs, [])
    end.

no_prune([], JObj) ->
    JObj;
no_prune([K], JObj) when not is_list(JObj) ->
    case lists:keydelete(K, 1, to_proplist(JObj)) of
        [] -> new();
        L -> from_list(L)
    end;
no_prune([K|T], Array) when is_list(Array) ->
    {Less, [V|More]} = lists:split(wh_util:to_integer(K)-1, Array),
    case {is_json_object(V), T, V} of
        {'true', [_|_]=Keys, JObj} ->
            Less ++ [no_prune(Keys, JObj)] ++ More;
        {'false', [_|_]=Keys, Arr} when is_list(Arr) ->
            Less ++ 'no_prune'(Keys, Arr) ++ More;
        {_,_,_} -> Less ++ More
    end;
no_prune([K|T], JObj) ->
    case get_value(K, JObj) of
        'undefined' -> JObj;
        V ->
            from_list([{K, no_prune(T, V)} | lists:keydelete(K, 1, to_proplist(JObj))])
    end;
no_prune(_, []) -> [];
no_prune([K|T], [_|_]=JObjs) when is_integer(K) ->
    V = lists:nth(wh_util:to_integer(K), JObjs),
    V1 = no_prune(T, V),
    case V1 =:= V of
        'true' ->
            replace_in_list(K, 'undefined', JObjs, []);
        'false' ->
            replace_in_list(K, V1, JObjs, [])
    end.

replace_in_list(N, _, _, _) when N < 1 ->
    exit('badarg');
replace_in_list(1, 'undefined', [_OldV | Vs], Acc) ->
    lists:reverse(Acc) ++ Vs;
replace_in_list(1, V1, [_OldV | Vs], Acc) ->
    lists:reverse([V1 | Acc]) ++ Vs;
replace_in_list(N, V1, [V | Vs], Acc) ->
    replace_in_list(N-1, V1, Vs, [V | Acc]).

from_list([]) -> new();
from_list(L) when is_list(L) -> ?JSON_WRAPPER(L).

is_json_object(?JSON_WRAPPER(P)) when is_list(P) -> 'true';
is_json_object(_) -> 'false'.

is_json_object(Key, JObj) ->
    is_json_object(get_value(Key, JObj)).

is_valid_json_object(MaybeJObj) ->
    try
        lists:all(fun(K) ->
                          is_json_term(get_value([K], MaybeJObj))
                  end, ?MODULE:get_keys(MaybeJObj))
    catch
        'throw':_ -> 'false';
        'error':_ -> 'false'
    end.

is_json_term('undefined') -> throw({'error', 'no_undefined_atom_in_jobj_please'});
is_json_term(V) when is_atom(V) -> 'true';
is_json_term(V) when is_binary(V) -> 'true';
is_json_term(V) when is_bitstring(V) -> 'true';
is_json_term(V) when is_integer(V) -> 'true';
is_json_term(V) when is_float(V) -> 'true';
is_json_term(Vs) when is_list(Vs) ->
    lists:all(fun is_json_term/1, Vs);
is_json_term({'json', IOList}) when is_list(IOList) -> 'true';
is_json_term(MaybeJObj) ->
    is_json_object(MaybeJObj).

count_activation_charge(InitialCharge) ->
    (z_convert:to_float(InitialCharge)+5.00)*1.2.

set_session_jobj(SessionKey, K, V, Default_JObj, Context) ->
    CurrentJObj = case z_context:get_session(SessionKey, Context) of 
        'undefined' -> Default_JObj;
        JObj -> JObj
    end,
    z_context:set_session(SessionKey,set_value(K,V,CurrentJObj), Context).

delete_session_jobj_key(SessionKey, K, Context) ->
    case z_context:get_session(SessionKey, Context) of
        'undefined' -> 'ok';
        JObj -> z_context:set_session(SessionKey,delete_key(K,JObj), Context)
    end.

get_session_jobj_value(SessionKey, K, Context) ->
    get_value(K, z_context:get_session(SessionKey, Context)).
 
split_b(String,Divider) ->
    lists:map(fun (K) -> z_convert:to_binary(K) end, z_string:split(String,Divider)).

format_account_id(AccountId, 'encoded') when is_binary(AccountId) ->
    [Id1, Id2, Id3, Id4 | IdRest] = z_convert:to_list(AccountId),
    z_convert:to_binary(["account%2F", Id1, Id2, "%2F", Id3, Id4, "%2F", IdRest]);
format_account_id(AccountId, 'raw') -> AccountId.

get_q_bin(Key, Context) ->
    z_convert:to_binary(z_context:get_q(Key, Context)).

get_q_atom(Key, Context) ->
    z_convert:to_atom(z_context:get_q(Key, Context)).

get_q_integer(Key, Context) ->
    z_convert:to_integer(z_context:get_q(Key, Context)).

cleanout(String) when is_list(hd(String)) orelse is_binary(hd(String)) ->
    lists:map(fun(X) -> re:replace(X, "[^A-Za-z0-9]", "", [global, {return, binary}]) end, String);
cleanout(String) when is_list(String) ->
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]);
cleanout(String) when is_binary(String) ->
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]);
cleanout(String) ->
    String.

props_get_values(K,L) ->
    lists:map(fun(X) -> modkazoo_util:get_value(K, X) end, L).


