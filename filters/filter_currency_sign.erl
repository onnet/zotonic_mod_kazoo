%% -*- coding: utf-8 -*-
-module(filter_currency_sign).
-export([
          currency_sign/2,
          currency_sign/3
]).

-include_lib("zotonic.hrl").
-include_lib("../include/mod_kazoo.hrl").

currency_sign('undefined', _Context) ->
    'undefined';
currency_sign(Amt, Context) ->
    build_a_fortune(Amt, Context).

currency_sign('undefined', _Args, _Context) ->
    'undefined';
currency_sign(Amt, _Args, Context) ->
    build_a_fortune(Amt, Context).

build_a_fortune([Amt], Context) ->
    build_a_fortune(Amt, Context);
build_a_fortune(Amt, Context) when is_list(Amt); is_binary(Amt) ->
    Amount = ?TO_FLT(re:replace(Amt, "[^A-Za-z0-9.]", "", [global, {return, binary}])),
    build_a_fortune(Amount, Context);
build_a_fortune(Amount, Context) ->
    CurrencySign = case z_context:get_session('currency_sign', Context) of
                       'undefined' -> <<"£"/utf8>>;
                       Sign -> Sign
                   end,
    case (Amount >= -0.0049) of
        'true' ->
            <<(?TO_BIN(CurrencySign))/binary, (filter_format_price:format_price(abs(Amount), Context))/binary>>;
        'false' ->
            <<"- ", (?TO_BIN(CurrencySign))/binary, (filter_format_price:format_price(abs(Amount), Context))/binary>>
    end.
