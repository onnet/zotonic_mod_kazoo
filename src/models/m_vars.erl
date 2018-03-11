-module(m_vars).

-behaviour(gen_model).

-export([m_get/2
        ,get_value/2
%        ,get_value/3
%        ,get_value/4
]).

-include_lib("zotonic_core/include/zotonic.hrl").

-define(ALLOWED_KEYS
       ,[color1
        ,color2
        ,color3
        ,color4
        ,page_header
        ,page_header_short
        ,default_kazoo_timezone
        ,user_agent_string
        ,wss_port
        ,default_country
        ,sip_registrar
        ,signup_service_plan
        ,local_currency_sign
        ,sender_name
        ,sales_email
        ,kazoo_blackhole_url
        ,callback_number
        ,callingcards_number
        ,placeholder_phone
        ,g_capture_site_key
        ,g_capture_secret
        ,reseller_id
        ,google_analytics_code
        ,invoice_incl_vat_docid
        ,invoice_excl_vat_docid
        ,calls_reports_pdf_docid
        ,excl_vat_accounting

        ,iam

        ]
       ).

-spec m_get( list(), z:context() ) -> {term(), list()}.
m_get([ Key | Rest ], Context) ->
    case lists:member(Key, ?ALLOWED_KEYS) of
        'true' ->
            Var = m_site:get(Key, Context),
            {Var, Rest};
        'false' ->
            lager:error("~p lookup: key not allowed ~p", [?MODULE, Key]),
            {undefined, []}
    end.

-spec get_value(atom(), z:context()) -> term().
get_value(Key, Context) ->
    m_config:get_value(Key, Context).
