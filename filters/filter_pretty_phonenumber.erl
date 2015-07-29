-module(filter_pretty_phonenumber).
-export([
          pretty_phonenumber/2,
          pretty_phonenumber/3
]).

pretty_phonenumber('undefined', _Context) ->
    'undefined';
pretty_phonenumber(Number, _Context) ->
    RegExps = ["7812000000000000", "0000000000000", "^\\d{7}$", "^[7,8]\\d{10}$", "^\\d{10}$", "^8\\d{7}$"],
    multiregexp(RegExps,Number).

pretty_phonenumber('undefined', _Args, _Context) ->
    'undefined';
pretty_phonenumber(Number, _Args, _Context) ->
    Number.

multiregexp([],Number) ->
    Number;
multiregexp([RE|RegExps],Number) ->
    case re:run(Number,RE) of
    {match,[{0,16}]} ->
        re:replace(Number,RE,"",[{return,list}]);
    {match,[{0,13}]} ->
        re:replace(Number,RE,"",[{return,list}]);
    {match,[{0,11}]} ->
        [[], _, Code, ShortNumber] = re:split(Number,"(.)(...)(.......)",[{return,list},{parts,0}]),
        lists:flatten(["(", Code, ") ", ShortNumber]);
    {match,[{0,10}]} ->
        [[], Code, ShortNumber] = re:split(Number,"(...)(.......)",[{return,list},{parts,0}]),
        lists:flatten(["(", Code, ") ", ShortNumber]);
    {match,[{0,8}]} ->
        [[], _, ShortNumber] = re:split(Number,"(.)(.......)",[{return,list},{parts,0}]),
        lists:flatten(["(812) ", ShortNumber]);
    {match,[{0,7}]} ->
        lists:flatten(["(812) ", Number]);
    nomatch ->
        multiregexp(RegExps,Number)
    end.
