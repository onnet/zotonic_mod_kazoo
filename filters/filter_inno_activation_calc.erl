-module(filter_inno_activation_calc).

-export([
          inno_activation_calc/2
]).

inno_activation_calc(InitialCharge, _Context) ->
    inno_util:count_activation_charge(InitialCharge).
