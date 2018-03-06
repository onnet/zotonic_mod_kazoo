-module(filter_inno_timestamp_expired).
-export([inno_timestamp_expired/2]).

inno_timestamp_expired(Seconds, _Context) ->
    case Seconds of
        'undefined' ->
            <<"undefined">>;
        _ -> 
            case z_convert:to_integer(Seconds)
                   < calendar:datetime_to_gregorian_seconds(calendar:universal_time())
            of
                'true' -> <<"expired">>;
                'false' -> <<"active">>
            end
    end.
