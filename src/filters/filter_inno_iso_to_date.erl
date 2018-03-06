-module(filter_inno_iso_to_date).
-export([
          inno_iso_to_date/2,
          inno_iso_to_date/3
]).

inno_iso_to_date(ISOTime, _Context) when is_binary(ISOTime) ->
    <<Year:4/binary, _:1/binary, Month:2/binary, _:1/binary, Day:2/binary
     ,_:1/binary
     ,Hours:2/binary, _:1/binary, Minutes:2/binary, _:1/binary, Sec:2/binary, _/binary>> = ISOTime,

    {{z_convert:to_integer(Year),z_convert:to_integer(Month),z_convert:to_integer(Day)}
    ,{z_convert:to_integer(Hours),z_convert:to_integer(Minutes),z_convert:to_integer(Sec)}};

inno_iso_to_date(ISOTime, _Context) ->
    ISOTime.

inno_iso_to_date(Seconds, Args, _Context) ->
    lager:info("Args: ~p", [Args]),
    lager:info("Seconds: ~p", [Seconds]).
