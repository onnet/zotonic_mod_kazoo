-module(filter_cleanout).
-export([
          cleanout/2,
          cleanout/3
]).

cleanout(String, _Context) when is_list(hd(String)) orelse is_binary(hd(String)) ->
    lists:map(fun(X) -> re:replace(X, "[^A-Za-z0-9]", "", [global, {return, binary}]) end, String);
cleanout(String, _Context) when is_list(String) ->
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]);
cleanout(String, _Context) when is_binary(String) ->
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]);
cleanout(String, _Context) ->
    String.

cleanout(String, _Args, _Context) ->
    String.
