-module(filter_cleanout).
-export([
          cleanout/2,
          cleanout/3
]).

cleanout('undefined', _Context) ->
    'undefined';
cleanout(String, _Context) ->
    re:replace(String, "[^A-Za-z0-9]", "", [global, {return, binary}]).


cleanout('undefined', _Args, _Context) ->
    'undefined';
cleanout(String, _Args, _Context) ->
    String.
