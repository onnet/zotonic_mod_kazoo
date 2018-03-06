-module(filter_units_to_money).
-export([
          units_to_money/2,
          units_to_money/3
]).

-define(MONEY_TO_UNIT, 10000).

units_to_money('undefined', _Context) ->
    'undefined';
units_to_money(Units, _Context) ->
    units_to_money(Units).

units_to_money('undefined', _Args, _Context) ->
    'undefined';
units_to_money(Units, _Args, _Context) ->
    units_to_money(Units).

units_to_money(Units) when is_number(Units) ->
    trunc(Units) / ?MONEY_TO_UNIT;
units_to_money(Units) ->
    units_to_money(kz_util:to_integer(Units)).

