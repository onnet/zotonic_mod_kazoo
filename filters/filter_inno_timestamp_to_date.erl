-module(filter_inno_timestamp_to_date).
-export([
          inno_timestamp_to_date/2,
          inno_timestamp_to_date/3
]).

inno_timestamp_to_date(Seconds, _Context) ->
    case Seconds of
        'undefined' -> {{0000,0,00},{00,00,0}};
        _ -> 
            GMT = calendar:gregorian_seconds_to_datetime(z_convert:to_integer(Seconds)),
            localtime:local_to_local(GMT, "GMT", "Europe/Moscow")
    end.

inno_timestamp_to_date(Seconds, Args, _Context) ->
    case Seconds of
        'undefined' -> {{0000,0,00},{00,00,0}};
         _ -> TZOffset = z_convert:to_integer(Args)*60*60,
              calendar:gregorian_seconds_to_datetime(z_convert:to_integer(Seconds) + TZOffset)
    end.
