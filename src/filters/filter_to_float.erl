-module(filter_to_float).
-export([to_float/2]).

to_float(undefined, _Context) ->
    undefined;
to_float([N|_], _Context) ->
	try
	    z_convert:to_float(N)
	catch
		_:_ -> undefined
	end;
to_float(N, _Context) ->
	try
	    z_convert:to_float(N)
	catch
		_:_ -> undefined
	end.

