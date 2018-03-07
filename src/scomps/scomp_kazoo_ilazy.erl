-module(scomp_kazoo_ilazy).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include_lib("zotonic_core/include/zotonic.hrl").

vary(_Params, _Context) -> nocache.

render(Params, Vars, Context) ->
    Id = case proplists:get_value(id, Params) of
             undefined -> z_ids:identifier();
             FixedId -> FixedId
         end,
    Class  = proplists:get_value(class, Params, "z-lazy"),
    Params1 = [{id, Id}, {type, "visible"} | proplists:delete(id, Params)],
    Html = [<<"<div id='">>, Id, <<"'><i class='">>, Class, <<"'></i></div>">>],
    case scomp_base_wire:render(Params1, Vars, Context) of
        {ok, Result} -> {ok, [Html, z_context:prune_for_template(Result)]};
        {error, _Reason} = Error -> Error
    end.
