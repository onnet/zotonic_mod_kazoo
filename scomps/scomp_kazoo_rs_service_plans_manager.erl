-module(scomp_kazoo_rs_service_plans_manager).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include("zotonic.hrl").

vary(_Params, _Context) -> nocache.

render(Params, Vars, Context) ->
    case z_convert:to_bool(m_config:get_value('mod_kazoo', show_finance_info, 'false', Context)) of
        'true' -> {ok, z_template:render("_rs_service_plans_manager.tpl", Params ++ Vars, Context)};
        'false' -> {ok, 'undefined'}
    end.
