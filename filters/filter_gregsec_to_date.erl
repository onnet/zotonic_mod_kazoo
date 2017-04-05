-module(filter_gregsec_to_date).
-export([gregsec_to_date/2
     %   ,gregsec_to_date/3
]).

gregsec_to_date(Seconds, _Context) ->
    case Seconds of
        'undefined' -> {{0000,0,00},{00,00,0}};
        _ -> 
            calendar:gregorian_seconds_to_datetime(z_convert:to_integer(Seconds))
    end.
