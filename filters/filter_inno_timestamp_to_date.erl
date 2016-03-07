-module(filter_inno_timestamp_to_date).
-export([
          inno_timestamp_to_date/2,
          inno_timestamp_to_date/3
]).

inno_timestamp_to_date(Seconds, Context) ->
    case Seconds of
        'undefined' -> {{0000,0,00},{00,00,0}};
        _ -> 
            DateTime = calendar:gregorian_seconds_to_datetime(z_convert:to_integer(Seconds)),
            localtime:local_to_local(DateTime, "UTC", z_convert:to_list(kazoo_util:may_be_get_timezone(Context)))
    end.

inno_timestamp_to_date(Seconds, "show_tz_name", Context) ->
    DateTime = calendar:gregorian_seconds_to_datetime(z_convert:to_integer(Seconds)),
    {TZN1, _TZN2} = localtime:tz_name(DateTime, z_convert:to_list(kazoo_util:may_be_get_timezone(Context))),
    TZN1;

inno_timestamp_to_date(Seconds, Args, _Context) ->
    case Seconds of
        'undefined' -> {{0000,0,00},{00,00,0}};
         _ -> TZOffset = z_convert:to_integer(Args)*60*60,
              calendar:gregorian_seconds_to_datetime(z_convert:to_integer(Seconds) + TZOffset)
    end.
