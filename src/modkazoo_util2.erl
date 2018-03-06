-module(modkazoo_util2).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([translit/1
        ,rand_hex_binary/1
        ,to_hex/1
        ,check_file_size_exceeded/3
        ,if_substring_in_json/2
        ,to_integer/2
        ,is_text/1
        ,encode_data/1
        ,maybe_encode_data/2
        ,decode_data/2
]).

-include_lib("zotonic.hrl").

-type(utf8_str() :: [integer()]).
-type(ascii_str() :: [byte()]).


-spec(translit(utf8_str()) -> ascii_str()).
translit(Data) when is_binary(Data) ->
    translit(z_convert:to_list(Data));
translit(Data) ->
    translit(Data, []).


-spec(translit(utf8_str(), list()) -> ascii_str()).
translit([], Acc) -> lists:flatten(lists:reverse(Acc));
translit([Last], Acc) -> lists:flatten(lists:reverse([Last | Acc]));
translit([C1, C2 | Rest], Acc) ->
    case proplists:get_value({C1, C2}, translit_map()) of
        undefined -> translit([C2 | Rest], [C1 | Acc]);
        {Str, _} -> translit(Rest, [Str | Acc])
    end.


translit_map() ->
    L1 = [{208, N} || N <- lists:seq(144, 191)],
    L2 = [{209, N} || N <- lists:seq(128, 143)],
    D1 = [{"A", "А"}, {"B", "Б"}, {"V", "В"}, {"G", "Г"}, {"D", "Д"}, {"E", "Е"},
          {"Zh", "Ж"}, {"Z", "З"}, {"I", "И"}, {"J", "Й"}, {"K", "К"}, {"L", "Л"},
          {"M", "М"}, {"N", "Н"}, {"O", "О"}, {"P", "П"}, {"R", "Р"}, {"S", "С"},
          {"T", "Т"}, {"U", "У"}, {"F", "Ф"}, {"H", "Х"}, {"Ts", "Ц"}, {"Ch", "Ч"},
          {"Sh", "Ш"}, {"Shh","Щ"}, {"#", "Ъ"}, {"Y", "Ы"}, {"'", "Ь"}, {"Je", "Э"},
          {"Ju", "Ю"}, {"Ja", "Я"},
          {"a", "а "}, {"b", "б"}, {"v", "в"}, {"g", "г"}, {"d", "д"}, {"e", "е"},
          {"zh", "ж"}, {"z", "з"}, {"i", "и"}, {"j", "й"}, {"k", "к"}, {"l", "л"},
          {"m", "м"}, {"n", "н"}, {"o", "о"}, {"p", "п"}],
    D2 = [{"r", "р"}, {"s", "с"}, {"t", "т"}, {"u", "у"}, {"f", "ф"}, {"h", "х"},
          {"ts", "ц"}, {"ch", "ч"}, {"sh", "ш"}, {"shh","щ"}, {"#", "ъ"}, {"y", "ы"},
          {"'", "ь"}, {"je", "э"}, {"ju", "ю"}, {"ja", "я"}],
    [{{208, 129}, {"Yo", "Ё"}},
     {{209, 145}, {"yo", "ё"}},
     {{194, 171}, {"\"", "«"}},
     {{194, 187}, {"\"", "»"}}
    ] ++ lists:zip(L1, D1) ++ lists:zip(L2, D2).

to_hex_binary(S) ->
    Bin = z_convert:to_binary(S),
    << <<(binary_to_hex_char(B div 16)), (binary_to_hex_char(B rem 16))>> || <<B>> <= Bin>>.

to_hex(S) ->
    string:to_lower(lists:flatten([io_lib:format("~2.16.0B", [H]) || H <- z_convert:to_list(S)])).

rand_hex_binary(Size) when is_integer(Size) andalso Size > 0 ->
    to_hex_binary(crypto:strong_rand_bytes(Size)).

binary_to_hex_char(N) when N < 10 -> $0 + N;
binary_to_hex_char(N) when N < 16 -> $a - 10 + N.

check_file_size_exceeded(Id, FileName, MaxSize) ->
    case filelib:file_size(FileName) > MaxSize of
        false ->
            false;
        true ->
            {true, Id}
    end.

if_substring_in_json(Substring, JObj) ->
    case re:run(jiffy:encode(JObj), Substring, []) of
        {match,_} -> 'true';
        _ -> 'false'
    end.

to_integer(Var, Default) ->
    case (catch z_convert:to_integer(Var)) of
        Num when is_integer(Num) -> Num;
        _ -> Default
    end.

%% @spec is_text(Mime) -> bool()
%% %% @doc Check if a mime type is textual
is_text("text/" ++ _) -> true;
is_text("application/x-javascript") -> true;
is_text("application/xhtml+xml") -> true;
is_text("application/xml") -> true;
is_text(_Mime) -> false.

%% Encode the data so that the identity variant comes first and then the gzip'ed variant
encode_data(Data) when is_binary(Data) ->
    {Data, zlib:gzip(Data)}.

maybe_encode_data(Data, Context) ->
    case z_context:get(encode_data, Context, false) of 
        true -> encode_data(Data);
        false -> Data
    end.

decode_data(gzip, Data) when is_binary(Data) ->
    zlib:gzip(Data);
decode_data(identity, Data) when is_binary(Data) ->
    Data;
decode_data(identity, {Data, _Gzip}) ->
    Data;
decode_data(gzip, {_Data, Gzip}) ->
    Gzip.
