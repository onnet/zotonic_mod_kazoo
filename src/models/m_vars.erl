-module(m_vars).

-behaviour(gen_model).

-export([m_get/2
]).

-include_lib("zotonic_core/include/zotonic.hrl").

-define(ALLOWED_KEYS
       ,[color1
        ,color2
        ,color3
        ,color4
        ,page_header
        ,page_header_short
        ]
       ).

-spec m_get( list(), z:context() ) -> {term(), list()}.
m_get([ Key | Rest ], Context) ->
    case lists:member(Key, ?ALLOWED_KEYS) of
        'true' ->
            Var = m_site:get(Key, Context),
            {Var, Rest};
        'false' ->
            lager:error("~p lookup: key not allowed ~p", [?MODULE, Key]),
            {undefined, []}
    end.
