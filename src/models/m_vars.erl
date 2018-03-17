-module(m_vars).

-behaviour(gen_model).

-export([m_get/2
        ,get_value/2
        ,get_value/3
        ,get_value/4
]).

-include_lib("zotonic_core/include/zotonic.hrl").

-spec m_get( list(), z:context() ) -> {term(), list()}.
m_get(Key, Context) ->
    m_get(Key, m_site:get(visible_keys, Context), Context).

m_get([ Module, Key | Rest ], VisibleKeys, Context) when is_list(VisibleKeys) ->
    case lists:member(Key, VisibleKeys) of
        'true' ->
            case m_config:get_value(Module, Key, Context) of
                'undefined' -> {m_site:get(Key, Context)};
                Val -> {Val, Rest}
            end;
        'false' ->
            lager:error("~p lookup: key not allowed [ ~p | ~p ]", [?MODULE, Key, Rest]),
            {undefined, []}
    end;
m_get([ Key | Rest ], VisibleKeys, Context) when is_list(VisibleKeys) ->
    case lists:member(Key, VisibleKeys) of
        'true' ->
            Var = m_site:get(Key, Context),
            {Var, Rest};
        'false' ->
            lager:error("~p lookup: key not allowed [ ~p | ~p ]", [?MODULE, Key, Rest]),
            {undefined, []}
    end;
m_get(Key, _VisibleKeys, _Context) ->
    lager:error("~p lookup: key not allowed ~p", [?MODULE, Key]),
    {undefined, []}.

-spec get_value(atom(), z:context()) -> term().
get_value(Key, Context) ->
    case m_site:get(Key, Context) of
        'undefined' -> 'undefined';
        Val -> z_convert:to_binary(Val)
    end.

get_value(Module, Key, Context) ->
    case m_config:get_value(Module, Key, Context) of
        'undefined' -> get_value(Key, Context);
        Val -> z_convert:to_binary(Val)
    end.

get_value(Module, Key, Default, Context) ->
    case m_config:get_value(Module, Key, Context) of
        'undefined' ->
            case get_value(Key, Context) of
                'undefined' -> Default;
                Val -> z_convert:to_binary(Val)
            end;
        Val -> z_convert:to_binary(Val)
    end.
