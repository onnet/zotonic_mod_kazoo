-module(filter_currency_sign).
-export([
          currency_sign/2,
          currency_sign/3
]).

-include_lib("zotonic.hrl").
-include_lib("../include/mod_kazoo.hrl").

currency_sign('undefined', _Context) ->
    'undefined';
currency_sign(Amount, Context) when is_integer(Amount) ->
    build_a_fortune(Amount, Context);
currency_sign(Amount, Context) when is_float(Amount) ->
    build_a_fortune(Amount, Context);
currency_sign(Amount, Context) ->
    build_a_fortune(z_convert:to_float(Amount), Context).

currency_sign('undefined', _Args, _Context) ->
    'undefined';
currency_sign(Amount, _Args, Context) ->
    build_a_fortune(z_convert:to_float(Amount), Context).

build_a_fortune(Amount, Context) ->
    CurrencySign = m_config:get_value(mod_kazoo, local_currency_sign, Context),
    case (Amount >= 0) of
        'true' ->
            <<(?TO_BIN(CurrencySign))/binary, (filter_format_price:format_price(Amount, Context))/binary>>;
        'false' ->
            <<"- ", (?TO_BIN(CurrencySign))/binary, (filter_format_price:format_price(abs(Amount), Context))/binary>>
    end.
