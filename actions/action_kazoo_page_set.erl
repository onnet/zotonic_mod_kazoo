-module(action_kazoo_page_set).
-include("zotonic.hrl").
-export([
    render_action/4,
    event/2
]).

render_action(TriggerId, TargetId, Args, Context) -> 
    Key = proplists:get_value(key, Args),
    Value = proplists:get_value(value, Args),
lager:info("IAM page render_action: ~p:	~p", [Key, Value]),
    {PostbackMsgJS, _PickledPostback} = z_render:make_postback({page_set, Key, Value}, click, TriggerId, TargetId, ?MODULE, Context),
    {PostbackMsgJS, Context}.

event(#postback{message={page_set, Key, Value}}, Context) ->
lager:info("IAM page event: ~p:	~p", [Key, Value]),
    z_session_page:set(z_convert:to_atom(Key), Value, Context),
    Context.
