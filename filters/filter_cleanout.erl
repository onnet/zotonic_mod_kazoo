-module(filter_cleanout).
-export([
          cleanout/2,
          cleanout/3
]).

cleanout(String, _Context) when is_list(String) ->
lager:info("Cleanout1: ~p",[String]),
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]);
cleanout(String, _Context) when is_binary(String) ->
lager:info("Cleanout2: ~p",[String]),
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]);
cleanout(String, _Context) ->
lager:info("Cleanout3: ~p",[String]),
    <<"iam_no_cleanout">>.

cleanout(String, _Args, _Context) ->
lager:info("Cleanout4: ~p",[String]),
    String.
