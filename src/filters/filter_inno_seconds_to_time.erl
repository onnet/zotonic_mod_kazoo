-module(filter_inno_seconds_to_time).
-export([
          inno_seconds_to_time/2,
          inno_seconds_to_time/3
]).

inno_seconds_to_time(Seconds, _Context) ->
    case Seconds of
        'undefined' -> <<"00:00">>;
        _ ->
            {_,{Hours,Minutes,_}} = calendar:seconds_to_daystime(z_convert:to_integer(Seconds)),
            z_convert:to_binary(io_lib:format("~2..0w:~2..0w",[Hours, Minutes]))
    end.

inno_seconds_to_time(Seconds, Args, _Context) ->
    case Args of
        <<"hm">> ->
            case Seconds of
                'undefined' -> <<"00:00">>;
                _ ->
                    {_,{Hours,Minutes,_}} = calendar:seconds_to_daystime(z_convert:to_integer(Seconds)),
                    z_convert:to_binary(io_lib:format("~2..0w:~2..0w",[Hours, Minutes]))
            end;
        <<"hms">> ->
            case Seconds of
                'undefined' -> <<"00:00:00">>;
                _ ->
                    {_,{Hours,Minutes,Secs}} = calendar:seconds_to_daystime(z_convert:to_integer(Seconds)),
                    z_convert:to_binary(io_lib:format("~2..0w:~2..0w:~2..0w",[Hours, Minutes, Secs]))
            end;
        _ ->
            <<"Undefined seconds_to_time argument">>
    end.
