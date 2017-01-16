-module(scomp_kazoo_e911_reminder).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include("zotonic.hrl").

vary(_Params, _Context) -> nocache.

render(_Params, _Vars, Context) ->
    Numbers = kazoo_util:kz_account_numbers_info(Context),
  lager:info("IAM Numbers: ~p",[Numbers]),
    Features = lists:foldr(fun({_,Number}, Acc) -> modkazoo_util:get_value(<<"features">>, Number) ++ Acc end, [], Numbers),
  lager:info("IAM Features: ~p",[Features]),
    case lists:member(<<"e911">>, Features) of 
        'false' ->
            {'ok', <<"<span class='reminder911'>Please configure E911 addresses!</span>">>};
        'true' ->
            {'ok', 'undefined'}
    end.
