-module(filter_pretty_freeforall).
-export([
          pretty_freeforall/2,
          pretty_freeforall/3
]).

pretty_freeforall('undefined', _Context) ->
    'undefined';
pretty_freeforall(<<"hosted_pbx">>, _Context) ->
    <<"Hosted PBX">>;
pretty_freeforall(<<"did_uk">>, _Context) ->
    <<"UK DID">>;
pretty_freeforall(Applicant, _Context) ->
    Applicant.

pretty_freeforall('undefined', _Args, _Context) ->
    'undefined';
pretty_freeforall(Applicant, _Args, _Context) ->
    Applicant.

