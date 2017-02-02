-module(filter_inno_timestamp_seconds_from_now).
-export([inno_timestamp_seconds_from_now/2]).

inno_timestamp_seconds_from_now(Seconds, _Context) ->
    case Seconds of
        'undefined' ->
            <<"undefined">>;
        _ -> 
            z_convert:to_integer(Seconds)
            + calendar:datetime_to_gregorian_seconds(calendar:universal_time())
    end.
