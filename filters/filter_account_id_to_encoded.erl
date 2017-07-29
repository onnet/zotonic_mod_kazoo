-module(filter_account_id_to_encoded).
-export([account_id_to_encoded/2
        ,account_id_to_encoded/3
]).

account_id_to_encoded(String, _Context) ->
    modkazoo_util:format_account_id(z_convert:to_binary(String), 'encoded').

account_id_to_encoded(String, _Args, _Context) ->
    String.
