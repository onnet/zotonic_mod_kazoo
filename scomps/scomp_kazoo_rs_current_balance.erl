-module(scomp_kazoo_rs_current_balance).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include("zotonic.hrl").

vary(_Params, _Context) -> nocache.

render(Params, Vars, Context) ->
    {ok, z_template:render("_rs_current_balance.tpl", Params ++ Vars, Context)}.
