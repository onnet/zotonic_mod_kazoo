-module(filter_vartrans).
-export([vartrans/2]).

vartrans(undefined, _Context) ->
    undefined;
vartrans([N|_]=M, Context) ->
	try
	    z_trans:trans(N, Context)
	catch
		_:_ -> M
	end;
vartrans(N, Context) ->
	try
	    z_trans:trans(N, Context)
	catch
		_:_ -> N
	end.

