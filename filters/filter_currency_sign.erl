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
currency_sign(Amount, Context) ->
    build_a_fortune(?TO_FLT(Amount), Context).

currency_sign('undefined', _Args, _Context) ->
    'undefined';
currency_sign(Amount, _Args, Context) ->
    build_a_fortune(?TO_FLT(Amount), Context).

build_a_fortune(Amount, Context) ->
    CurrencySign = case z_context:get_session('currency_sign', Context) of
                       'undefined' -> <<"£"/utf8>>;
                       Sign -> Sign
                   end,
lager:info("IAM Amount: ~p",[Amount]),
    case (Amount >= -0.0049) of
        'true' ->
            <<(?TO_BIN(CurrencySign))/binary, (filter_format_price:format_price(abs(Amount), Context))/binary>>;
        'false' ->
            <<"- ", (?TO_BIN(CurrencySign))/binary, (filter_format_price:format_price(abs(Amount), Context))/binary>>
    end.
