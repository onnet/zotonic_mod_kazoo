-module(m_vars).

-behaviour(gen_model).

-export([m_get/2
        ,get_value/2
        ,get_value/3
        ,get_value/4
]).

-include_lib("zotonic_core/include/zotonic.hrl").

-spec m_get( list(), z:context() ) -> {term(), list()}.
m_get([ Key | Rest ], Context) ->
    case m_site:get(visible_keys, Context) of
        'undefined' ->
            lager:error("~p lookup: key not allowed ~p", [?MODULE, Key]),
            {undefined, []};
        VisibleKeys when is_list(VisibleKeys) ->
            case lists:member(Key, VisibleKeys) of
                'true' ->
                    Var = m_site:get(Key, Context),
                    {Var, Rest};
                'false' ->
                    lager:error("~p lookup: key not allowed ~p", [?MODULE, Key]),
                    {undefined, []}
            end
    end.

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
