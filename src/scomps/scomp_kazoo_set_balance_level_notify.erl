-module(scomp_kazoo_set_balance_level_notify).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include_lib("zotonic_core/include/zotonic.hrl").

vary(_Params, _Context) -> nocache.

render(Params, Vars, Context) ->
    case z_convert:to_bool(m_vars:get_value('mod_kazoo', show_finance_info, 'false', Context)) of
        'true' -> {'ok', z_template:render("_set_notify_level.tpl", Params ++ Vars, Context)};
        'false' -> {'ok', 'undefined'}
    end.
