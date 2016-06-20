-module(scomp_kazoo_set_balance_level_notify).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include("zotonic.hrl").

vary(_Params, _Context) -> nocache.

render(Params, Vars, Context) ->
    {ok, z_template:render("_set_notify_level.tpl", Params ++ Vars, Context)}.
