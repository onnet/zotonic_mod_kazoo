-module(filter_inno_timestamp_expiried).
-export([inno_timestamp_expiried/2]).

inno_timestamp_expiried(Seconds, _Context) ->
    case Seconds of
        'undefined' ->
            <<"undefined">>;
        _ -> 
            case z_convert:to_integer(Seconds)
                   < calendar:datetime_to_gregorian_seconds(calendar:universal_time())
            of
                'true' -> <<"expiried">>;
                'false' -> <<"active">>
            end
    end.
