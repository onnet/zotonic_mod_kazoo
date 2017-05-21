-define(JSON_WRAPPER(Proplist), {Proplist}).
-define(EMPTY_JSON_OBJECT, ?JSON_WRAPPER([])).
-define(MK_DATABAG(JObj), {[{<<"data">>, JObj}]}).
-define(TO_BIN(Var), <<(z_convert:to_binary(Var))/binary>>).
-define(TO_INT(Var), z_convert:to_integer(Var)).
-define(TO_INT(Var, Default), modkazoo_util2:to_integer(Var, Default)).
-define(TO_FLT(Var), z_convert:to_float(Var)).
-define(TO_LST(Var), z_convert:to_list(Var)).
-define(TO_ATM(Var), z_convert:to_atom(Var)).
-define(SIGNAL_FILTER(Context), [{'signal_filter', z_session_manager:get_session_id(Context)}]).

-define(TIMEZONES_LIST, [<<"Africa/Abidjan">>,
             <<"Africa/Accra">>,
             <<"Africa/Addis_Ababa">>,
             <<"Africa/Algiers">>,
             <<"Africa/Asmera">>,
             <<"Africa/Bamako">>,
             <<"Africa/Bangui">>,
             <<"Africa/Banjul">>,
             <<"Africa/Bissau">>,
             <<"Africa/Blantyre">>,
             <<"Africa/Brazzaville">>,
             <<"Africa/Bujumbura">>,
             <<"Africa/Cairo">>,
             <<"Africa/Casablanca">>,
             <<"Africa/Ceuta">>,
             <<"Africa/Conakry">>,
             <<"Africa/Dakar">>,
             <<"Africa/Dar_es_Salaam">>,
             <<"Africa/Djibouti">>,
             <<"Africa/Douala">>,
             <<"Africa/El_Aaiun">>,
             <<"Africa/Freetown">>,
             <<"Africa/Gaborone">>,
             <<"Africa/Harare">>,
             <<"Africa/Johannesburg">>,
             <<"Africa/Kampala">>,
             <<"Africa/Khartoum">>,
             <<"Africa/Kigali">>,
             <<"Africa/Kinshasa">>,
             <<"Africa/Lagos">>,
             <<"Africa/Libreville">>,
             <<"Africa/Lome">>,
             <<"Africa/Luanda">>,
             <<"Africa/Lubumbashi">>,
             <<"Africa/Lusaka">>,
             <<"Africa/Malabo">>,
             <<"Africa/Maputo">>,
             <<"Africa/Maseru">>,
             <<"Africa/Mbabane">>,
             <<"Africa/Mogadishu">>,
             <<"Africa/Monrovia">>,
             <<"Africa/Nairobi">>,
             <<"Africa/Ndjamena">>,
             <<"Africa/Niamey">>,
             <<"Africa/Nouakchott">>,
             <<"Africa/Ouagadougou">>,
             <<"Africa/Porto-Novo">>,
             <<"Africa/Sao_Tome">>,
             <<"Africa/Timbuktu">>,
             <<"Africa/Tripoli">>,
             <<"Africa/Tunis">>,
             <<"Africa/Windhoek">>,
             <<"America/Adak">>,
             <<"America/Anchorage">>,
             <<"America/Anguilla">>,
             <<"America/Antigua">>,
             <<"America/Araguaina">>,
             <<"America/Aruba">>,
             <<"America/Asuncion">>,
             <<"America/Barbados">>,
             <<"America/Belem">>,
             <<"America/Belize">>,
             <<"America/Boa_Vista">>,
             <<"America/Bogota">>,
             <<"America/Boise">>,
             <<"America/Buenos_Aires">>,
             <<"America/Cambridge_Bay">>,
             <<"America/Cancun">>,
             <<"America/Caracas">>,
             <<"America/Catamarca">>,
             <<"America/Cayenne">>,
             <<"America/Cayman">>,
             <<"America/Chicago">>,
             <<"America/Chihuahua">>,
             <<"America/Cordoba">>,
             <<"America/Costa_Rica">>,
             <<"America/Cuiaba">>,
             <<"America/Curacao">>,
             <<"America/Danmarkshavn">>,
             <<"America/Dawson">>,
             <<"America/Dawson_Creek">>,
             <<"America/Denver">>,
             <<"America/Detroit">>,
             <<"America/Dominica">>,
             <<"America/Edmonton">>,
             <<"America/Eirunepe">>,
             <<"America/El_Salvador">>,
             <<"America/Fortaleza">>,
             <<"America/Glace_Bay">>,
             <<"America/Godthab">>,
             <<"America/Goose_Bay">>,
             <<"America/Grand_Turk">>,
             <<"America/Grenada">>,
             <<"America/Guadeloupe">>,
             <<"America/Guatemala">>,
             <<"America/Guayaquil">>,
             <<"America/Guyana">>,
             <<"America/Halifax">>,
             <<"America/Havana">>,
             <<"America/Hermosillo">>,
             <<"America/Indiana/Indianapolis">>,
             <<"America/Indiana/Knox">>,
             <<"America/Indiana/Marengo">>,
             <<"America/Indiana/Vevay">>,
             <<"America/Indianapolis">>,
             <<"America/Inuvik">>,
             <<"America/Iqaluit">>,
             <<"America/Jamaica">>,
             <<"America/Jujuy">>,
             <<"America/Juneau">>,
             <<"America/Kentucky/Louisville">>,
             <<"America/Kentucky/Monticello">>,
             <<"America/La_Paz">>,
             <<"America/Lima">>,
             <<"America/Los_Angeles">>,
             <<"America/Louisville">>,
             <<"America/Maceio">>,
             <<"America/Managua">>,
             <<"America/Manaus">>,
             <<"America/Martinique">>,
             <<"America/Mazatlan">>,
             <<"America/Mendoza">>,
             <<"America/Menominee">>,
             <<"America/Merida">>,
             <<"America/Mexico_City">>,
             <<"America/Miquelon">>,
             <<"America/Monterrey">>,
             <<"America/Montevideo">>,
             <<"America/Montreal">>,
             <<"America/Montserrat">>,
             <<"America/Nassau">>,
             <<"America/New_York">>,
             <<"America/Nipigon">>,
             <<"America/Nome">>,
             <<"America/Noronha">>,
             <<"America/North_Dakota/Center">>,
             <<"America/Panama">>,
             <<"America/Pangnirtung">>,
             <<"America/Paramaribo">>,
             <<"America/Phoenix">>,
             <<"America/Port-au-Prince">>,
             <<"America/Port_of_Spain">>,
             <<"America/Porto_Velho">>,
             <<"America/Puerto_Rico">>,
             <<"America/Rainy_River">>,
             <<"America/Rankin_Inlet">>,
             <<"America/Recife">>,
             <<"America/Regina">>,
             <<"America/Rio_Branco">>,
             <<"America/Rosario">>,
             <<"America/Santiago">>,
             <<"America/Santo_Domingo">>,
             <<"America/Sao_Paulo">>,
             <<"America/Scoresbysund">>,
             <<"America/Shiprock">>,
             <<"America/St_Johns">>,
             <<"America/St_Kitts">>,
             <<"America/St_Lucia">>,
             <<"America/St_Thomas">>,
             <<"America/St_Vincent">>,
             <<"America/Swift_Current">>,
             <<"America/Tegucigalpa">>,
             <<"America/Thule">>,
             <<"America/Thunder_Bay">>,
             <<"America/Tijuana">>,
             <<"America/Tortola">>,
             <<"America/Vancouver">>,
             <<"America/Whitehorse">>,
             <<"America/Winnipeg">>,
             <<"America/Yakutat">>,
             <<"America/Yellowknife">>,
             <<"Antarctica/Casey">>,
             <<"Antarctica/Davis">>,
             <<"Antarctica/DumontDUrville">>,
             <<"Antarctica/Mawson">>,
             <<"Antarctica/McMurdo">>,
             <<"Antarctica/Palmer">>,
             <<"Antarctica/South_Pole">>,
             <<"Antarctica/Syowa">>,
             <<"Antarctica/Vostok">>,
             <<"Arctic/Longyearbyen">>,
             <<"Asia/Aden">>,
             <<"Asia/Almaty">>,
             <<"Asia/Amman">>,
             <<"Asia/Anadyr">>,
             <<"Asia/Aqtau">>,
             <<"Asia/Aqtobe">>,
             <<"Asia/Ashgabat">>,
             <<"Asia/Baghdad">>,
             <<"Asia/Bahrain">>,
             <<"Asia/Baku">>,
             <<"Asia/Bangkok">>,
             <<"Asia/Beirut">>,
             <<"Asia/Bishkek">>,
             <<"Asia/Brunei">>,
             <<"Asia/Calcutta">>,
             <<"Asia/Choibalsan">>,
             <<"Asia/Chongqing">>,
             <<"Asia/Colombo">>,
             <<"Asia/Damascus">>,
             <<"Asia/Dhaka">>,
             <<"Asia/Dili">>,
             <<"Asia/Dubai">>,
             <<"Asia/Dushanbe">>,
             <<"Asia/Gaza">>,
             <<"Asia/Harbin">>,
             <<"Asia/Hong_Kong">>,
             <<"Asia/Hovd">>,
             <<"Asia/Irkutsk">>,
             <<"Asia/Istanbul">>,
             <<"Asia/Jakarta">>,
             <<"Asia/Jayapura">>,
             <<"Asia/Jerusalem">>,
             <<"Asia/Kabul">>,
             <<"Asia/Kamchatka">>,
             <<"Asia/Karachi">>,
             <<"Asia/Kashgar">>,
             <<"Asia/Katmandu">>,
             <<"Asia/Krasnoyarsk">>,
             <<"Asia/Kuala_Lumpur">>,
             <<"Asia/Kuching">>,
             <<"Asia/Kuwait">>,
             <<"Asia/Macao">>,
             <<"Asia/Macau">>,
             <<"Asia/Magadan">>,
             <<"Asia/Makassar">>,
             <<"Asia/Manila">>,
             <<"Asia/Muscat">>,
             <<"Asia/Nicosia">>,
             <<"Asia/Novosibirsk">>,
             <<"Asia/Omsk">>,
             <<"Asia/Oral">>,
             <<"Asia/Phnom_Penh">>,
             <<"Asia/Pontianak">>,
             <<"Asia/Pyongyang">>,
             <<"Asia/Qyzylorda">>,
             <<"Asia/Qatar">>,
             <<"Asia/Rangoon">>,
             <<"Asia/Riyadh">>,
             <<"Asia/Saigon">>,
             <<"Asia/Sakhalin">>,
             <<"Asia/Samarkand">>,
             <<"Asia/Seoul">>,
             <<"Asia/Shanghai">>,
             <<"Asia/Singapore">>,
             <<"Asia/Taipei">>,
             <<"Asia/Tashkent">>,
             <<"Asia/Tbilisi">>,
             <<"Asia/Tehran">>,
             <<"Asia/Thimphu">>,
             <<"Asia/Tokyo">>,
             <<"Asia/Ujung_Pandang">>,
             <<"Asia/Ulaanbaatar">>,
             <<"Asia/Urumqi">>,
             <<"Asia/Vientiane">>,
             <<"Asia/Vladivostok">>,
             <<"Asia/Yakutsk">>,
             <<"Asia/Yekaterinburg">>,
             <<"Asia/Yerevan">>,
             <<"Atlantic/Azores">>,
             <<"Atlantic/Bermuda">>,
             <<"Atlantic/Canary">>,
             <<"Atlantic/Cape_Verde">>,
             <<"Atlantic/Faeroe">>,
             <<"Atlantic/Jan_Mayen">>,
             <<"Atlantic/Madeira">>,
             <<"Atlantic/Reykjavik">>,
             <<"Atlantic/South_Georgia">>,
             <<"Atlantic/St_Helena">>,
             <<"Atlantic/Stanley">>,
             <<"Australia/Adelaide">>,
             <<"Australia/Brisbane">>,
             <<"Australia/Broken_Hill">>,
             <<"Australia/Darwin">>,
             <<"Australia/Hobart">>,
             <<"Australia/Lindeman">>,
             <<"Australia/Lord_Howe">>,
             <<"Australia/Melbourne">>,
             <<"Australia/Perth">>,
             <<"Australia/Sydney">>,
             <<"Europe/Amsterdam">>,
             <<"Europe/Andorra">>,
             <<"Europe/Athens">>,
             <<"Europe/Belfast">>,
             <<"Europe/Belgrade">>,
             <<"Europe/Berlin">>,
             <<"Europe/Bratislava">>,
             <<"Europe/Brussels">>,
             <<"Europe/Bucharest">>,
             <<"Europe/Budapest">>,
             <<"Europe/Chisinau">>,
             <<"Europe/Copenhagen">>,
             <<"Europe/Dublin">>,
             <<"Europe/Gibraltar">>,
             <<"Europe/Helsinki">>,
             <<"Europe/Istanbul">>,
             <<"Europe/Kaliningrad">>,
             <<"Europe/Kiev">>,
             <<"Europe/Lisbon">>,
             <<"Europe/Ljubljana">>,
             <<"Europe/London">>,
             <<"Europe/Luxembourg">>,
             <<"Europe/Madrid">>,
             <<"Europe/Malta">>,
             <<"Europe/Minsk">>,
             <<"Europe/Monaco">>,
             <<"Europe/Moscow">>,
             <<"Europe/Nicosia">>,
             <<"Europe/Oslo">>,
             <<"Europe/Paris">>,
             <<"Europe/Prague">>,
             <<"Europe/Riga">>,
             <<"Europe/Rome">>,
             <<"Europe/Samara">>,
             <<"Europe/San_Marino">>,
             <<"Europe/Sarajevo">>,
             <<"Europe/Simferopol">>,
             <<"Europe/Skopje">>,
             <<"Europe/Sofia">>,
             <<"Europe/Stockholm">>,
             <<"Europe/Tallinn">>,
             <<"Europe/Tirane">>,
             <<"Europe/Uzhgorod">>,
             <<"Europe/Vaduz">>,
             <<"Europe/Vatican">>,
             <<"Europe/Vienna">>,
             <<"Europe/Vilnius">>,
             <<"Europe/Warsaw">>,
             <<"Europe/Zagreb">>,
             <<"Europe/Zaporozhye">>,
             <<"Europe/Zurich">>,
             <<"Indian/Antananarivo">>,
             <<"Indian/Chagos">>,
             <<"Indian/Christmas">>,
             <<"Indian/Cocos">>,
             <<"Indian/Comoro">>,
             <<"Indian/Kerguelen">>,
             <<"Indian/Mahe">>,
             <<"Indian/Maldives">>,
             <<"Indian/Mauritius">>,
             <<"Indian/Mayotte">>,
             <<"Indian/Reunion">>,
             <<"Pacific/Apia">>,
             <<"Pacific/Auckland">>,
             <<"Pacific/Chatham">>,
             <<"Pacific/Easter">>,
             <<"Pacific/Efate">>,
             <<"Pacific/Enderbury">>,
             <<"Pacific/Fakaofo">>,
             <<"Pacific/Fiji">>,
             <<"Pacific/Funafuti">>,
             <<"Pacific/Galapagos">>,
             <<"Pacific/Gambier">>,
             <<"Pacific/Guadalcanal">>,
             <<"Pacific/Guam">>,
             <<"Pacific/Honolulu">>,
             <<"Pacific/Johnston">>,
             <<"Pacific/Kiritimati">>,
             <<"Pacific/Kosrae">>,
             <<"Pacific/Kwajalein">>,
             <<"Pacific/Majuro">>,
             <<"Pacific/Marquesas">>,
             <<"Pacific/Midway">>,
             <<"Pacific/Nauru">>,
             <<"Pacific/Niue">>,
             <<"Pacific/Norfolk">>,
             <<"Pacific/Noumea">>,
             <<"Pacific/Pago_Pago">>,
             <<"Pacific/Palau">>,
             <<"Pacific/Pitcairn">>,
             <<"Pacific/Ponape">>,
             <<"Pacific/Port_Moresby">>,
             <<"Pacific/Rarotonga">>,
             <<"Pacific/Saipan">>,
             <<"Pacific/Tahiti">>,
             <<"Pacific/Tarawa">>,
             <<"Pacific/Tongatapu">>,
             <<"Pacific/Truk">>,
             <<"Pacific/Wake">>,
             <<"Pacific/Wallis">>,
             <<"Pacific/Yap">>,
             <<"Universal">>]).

-define(MICROSECONDS_IN_SECOND, 1000000).

-define(MILLISECONDS_IN_SECOND, 1000).
-define(MILLISECONDS_IN_MINUTE, 60000).
-define(MILLISECONDS_IN_HOUR, 3600000).
-define(MILLISECONDS_IN_DAY, 86400000).

-define(SECONDS_IN_MINUTE, 60).
-define(SECONDS_IN_HOUR, 3600).
-define(SECONDS_IN_DAY, 86400).
-define(SECONDS_IN_WEEK, 604800).
-define(SECONDS_IN_YEAR, 31540000).

-define(BYTES_K, 1024).
-define(BYTES_M, 1048576).
-define(BYTES_G, 1073741824).
-define(BYTES_T, 1099511627776).


%% result of calendar:datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}}).
%% %% Subtract this value from a gregorian seconds version of a date
%% %% to get the Unix timestamp
%% %% datetime_to_gregorian_seconds({date(),time()}) - ?UNIX_EPOCH_IN_GREGORIAN.
%%
-define(UNIX_EPOCH_IN_GREGORIAN, 62167219200).

%% Kazo API tokens
-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(API_AUTH, <<"/api_auth">>).
-define(USER_AUTH, <<"/user_auth">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ACCOUNTS(Context), <<"/accounts/", (z_context:get_session('kazoo_account_id', Context))/binary>>).
-define(PHONE_NUMBERS, <<"/phone_numbers">>).
-define(FIX, <<"/fix">>).
-define(IDENTIFY, <<"/identify">>).
-define(REGISTRATIONS, <<"/registrations">>).
-define(COUNT, <<"/count">>).
-define(FAXES, <<"/faxes">>).
-define(FAXES_OUTGOING, <<"/faxes/outgoing/">>).
-define(FAXES_INCOMING, <<"/faxes/incoming/">>).
-define(ATTACHMENT, <<"/attachment">>).
-define(CONNECT, <<"/connect">>).
-define(CONNECTIVITY, <<"/connectivity">>).
-define(CLASSIFIERS, <<"/classifiers">>).
-define(USERS, <<"/users">>).
-define(CCCPS, <<"/cccps">>).
-define(AUTODIAL, <<"/autodial">>).
-define(CALLFLOWS, <<"/callflows">>).
-define(DEVICES, <<"/devices">>).
-define(DEVICES(DeviceId), <<"/devices/", (z_convert:to_binary(DeviceId))/binary>>).
-define(VMBOXES, <<"/vmboxes">>).
-define(CDRS, <<"/cdrs">>).
-define(MESSAGES, <<"/messages">>).
-define(RAW, <<"/raw">>).
-define(FILTER_OWNER, <<"filter_owner_id=">>).
-define(CREATED_FROM, <<"created_from=">>).
-define(CREATED_TO, <<"created_to=">>).
-define(AUTH_TOKEN, <<"auth_token=">>).
-define(RECOVERY, <<"/recovery">>).
-define(BRAINTREE, <<"/braintree">>).
-define(CREDITS, <<"/credits">>).
-define(STATUS, <<"/status">>).
-define(RATES, <<"/v1/rates">>).
-define(RECORDINGS, <<"/recordings">>).
-define(NUMBER, <<"/number">>).
-define(CUSTOMER, <<"/customer">>).
-define(TRANSACTIONS, <<"/transactions">>).
-define(SUBSCRIPTIONS, <<"/subscriptions">>).
-define(CREDIT, <<"/credit">>).
-define(DEBIT, <<"/debit">>).
-define(CARDS, <<"/cards">>).
-define(COUNTRY, <<"country=">>).
-define(PREFIX, <<"prefix=">>).
-define(QUANTITY, <<"quantity=">>).
-define(COLLECTION, <<"/collection">>).
-define(RESERVE, <<"/reserve">>).
-define(ACTIVATE, <<"/activate">>).
-define(SERVICE_PLANS, <<"/service_plans">>).
-define(CURRENT, <<"/current">>).
-define(GROUPS, <<"/groups">>).
-define(CHANNELS, <<"/channels">>).
-define(MEDIA, <<"/media">>).
-define(MENUS, <<"/menus">>).
-define(TEMPORAL_RULES, <<"/temporal_rules">>).
-define(CONFERENCES, <<"/conferences">>).
-define(PARTICIPANTS, <<"/participants">>).
-define(BLACKLISTS, <<"/blacklists">>).
-define(LISTS, <<"/lists">>).
-define(ENTRIES, <<"/entries">>).
-define(CHILDREN, <<"/children">>).
-define(PAGE_SIZE, <<"page_size=">>).
-define(START_KEY, <<"start_key=">>).
-define(WEBHOOKS, <<"/webhooks">>).
-define(NO_PAGINATION, <<"&paginate=false">>).
-define(RESOURCES, <<"/resources">>).
-define(NOTIFICATIONS, <<"/notifications">>).
-define(CUSTOMER_UPDATE, <<"/customer_update">>).
-define(PREVIEW, <<"/preview">>).
-define(SMTPLOG, <<"/smtplog">>).
-define(QUEUES, <<"/queues">>).
-define(EAVESDROP, <<"/eavesdrop">>).
-define(CLICKTOCALL, <<"/clicktocall">>).
-define(DIALPLANS, <<"/dialplans">>).
-define(MESSAGE, <<"/message">>).
-define(RESELLER, <<"/reseller">>).
-define(CURRENT_BALANCE, <<"/current_balance">>).
-define(AVAILABLE, <<"/available">>).
-define(SYNCHRONIZATION, <<"/synchronization">>).
-define(RECONCILIATION, <<"/reconciliation">>).
-define(INTERACTION, <<"/interaction">>).
-define(LEGS, <<"/legs">>).
-define(LEDGERS, <<"/ledgers">>).
-define(ACCESS_LISTS, <<"/access_lists">>).
-define(LIMITS, <<"/limits">>).
-define(ALLOTMENTS, <<"/allotments">>).
-define(CONSUMED, <<"/consumed">>).
-define(SERVICES, <<"/services">>).
-define(TASKS, <<"/tasks">>).
-define(METAFLOWS, <<"/metaflows">>).
-define(CONFIGS, <<"/configs">>).

-define(MK_TIME_FILTER(CreatedFrom, CreatedTo), <<?CREATED_FROM/binary, CreatedFrom/binary, <<"&">>/binary, ?CREATED_TO/binary, CreatedTo/binary>>).
-define(SET_REASON(Reason), case Reason of 'undefined' -> <<>>; _ -> <<"&reason=", ?TO_BIN(Reason)/binary>> end).
-define(SET_ACCEPT_CHARGES(AcceptCharges, Doc), modkazoo_util:set_value(<<"accept_charges">>, AcceptCharges, ?MK_DATABAG(Doc))).
-define(MATCH_ACCOUNT_RAW(Account), <<(Account):32/binary>>).
-define(ACTION_TUPLE(Action), {[{<<"action">>, ?TO_BIN(Action)}]}).

