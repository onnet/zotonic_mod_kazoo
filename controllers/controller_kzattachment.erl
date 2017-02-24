-module(controller_kzattachment).
-export([
    init/1,
    service_available/2,
    allowed_methods/2,
    resource_exists/2,
    forbidden/2,
    content_types_provided/2,
    charsets_provided/2,
    encodings_provided/2,
    provide_content/2,
    finish_request/2
]).

-include_lib("controller_webmachine_helper.hrl").
-include_lib("zotonic.hrl").

-define(CSV_CONTENT_TYPES, [{"text/csv", provide_content}
                           ]).

-define(PDF_CONTENT_TYPES, [{"application/pdf", provide_content}
                           ,{"application/x-pdf", provide_content}
                           ]).

-define(IMAGE_CONTENT_TYPES, [{"image/jpg", provide_content}
                             ,{"image/jpeg", provide_content}
                             ,{"image/png", provide_content}
                             ,{"image/gif", provide_content}
                             ]).


init(ConfigProps) ->
    {ok, ConfigProps}.

service_available(ReqData, DispatchArgs) ->
    Context  = z_context:new(ReqData, ?MODULE),
    Context1 = z_context:set(DispatchArgs, Context),
    Context2 = z_context:ensure_all(Context1),
    ?WM_REPLY(true, Context2).

allowed_methods(ReqData, Context) ->
    {['HEAD', 'GET'], ReqData, Context}.

forbidden(ReqData, Context) ->
    {false, ReqData, Context}.

content_types_provided(ReqData, Context) ->
    case z_context:get_q("doc_type", Context) of
        "onbill_modb" ->
            {[{"application/pdf", provide_content}], ReqData, Context};
        "onbill_e911_address_proof" ->
            {?PDF_CONTENT_TYPES ++ ?IMAGE_CONTENT_TYPES, ReqData, Context};
        "tasks_csv" ->
            {?CSV_CONTENT_TYPES, ReqData, Context};
        "call_recording" ->
            {[{"audio/mpeg", provide_content}], ReqData, Context}
    end.

encodings_provided(ReqData, Context) ->
    Encodings = [{"identity", fun(Data) -> Data end}], 
    {Encodings, ReqData, z_context:set(encode_data, length(Encodings) > 1, Context)}.

resource_exists(ReqData, Context) ->
    {true , ReqData, Context}.

charsets_provided(ReqData, Context) ->
    {no_charset, ReqData, Context}.

provide_content(ReqData, Context) ->
    case z_context:get_q("doc_type", Context) of
        "onbill_modb" ->
            MediaName = z_context:get_q("doc_id", Context),
            ReqData1 = wrq:set_resp_header("Content-Disposition", "attachment; filename=" ++ MediaName ++ ".pdf", ReqData),
            case onbill_modb_attachment(Context) of
                {'ok', Body} -> {Body, ReqData1, z_context:set(body, Body, Context)};
                _ -> api_error(404, 0, "No attachment found", ReqData, Context)
            end;
        "onbill_e911_address_proof" ->
            DocId = z_context:get_q("doc_id", Context),
            AccountId = z_context:get_q("account_id", Context),
            case onbill_util:get_e911_attachment(DocId, AccountId, Context) of
                {'ok', [50,_,_], Headers, Body} ->
                    ReqData1 = wrq:set_resp_header("Content-Disposition", proplists:get_value("content-disposition", Headers), ReqData),
                    {Body, ReqData1, z_context:set(body, Body, Context)};
                _E ->
                    lager:info("IAM provide_content eror: ~p",[_E]),
                    api_error(404, 0, "No attachment found", ReqData, Context)
            end;
        "tasks_csv" ->
            AttName = z_context:get_q("att_name", Context),
            TaskId = z_context:get_q("doc_id", Context),
            AccountId = z_context:get_q("account_id", Context),
            case kazoo_util:get_tasks_csv(AttName, TaskId, AccountId, Context) of
                {'ok', [50,_,_], Headers, Body} ->
                    ReqData1 = wrq:set_resp_header("Content-Disposition", proplists:get_value("content-disposition", Headers), ReqData),
                    {Body, ReqData1, z_context:set(body, Body, Context)};
                _E ->
                    lager:info("IAM provide_content eror: ~p",[_E]),
                    api_error(404, 0, "No attachment found", ReqData, Context)
            end;
        "call_recording" ->
            MediaName = z_context:get_q("recording_id", Context),
            ReqData1 = wrq:set_resp_header("Content-Disposition", "attachment; filename=" ++ MediaName ++ ".mp3", ReqData),
            {'ok', Body} = call_recording_attachment(Context),
            {Body, ReqData1, z_context:set(body, Body, Context)};
        _ ->
            {<<>>, ReqData, Context}
    end.

finish_request(ReqData, Context) ->
    {ok, ReqData, Context}.

onbill_modb_attachment(Context) ->
    AccountId = z_context:get_q("account_id", Context),
    DocId = z_context:get_q("doc_id", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    Year = z_context:get_q("year", Context),
    Month = z_context:get_q("month", Context),
    case onbill_util:onbill_modb_attachment(AccountId, DocId, AuthToken, Year, Month, Context) of
        <<>> -> {error, <<>>};
        Body -> {ok, Body}
    end.

call_recording_attachment(Context) ->
    AccountId = z_context:get_q("account_id", Context),
    RecordingId = z_context:get_q("recording_id", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    Body = kazoo_util:call_recording_attachment(AccountId, RecordingId, AuthToken, Context),
    {ok, Body}.

api_error(HttpCode, ErrCode, Message, ReqData, Context) ->
    R = {struct, [{error, {struct, [{code, ErrCode}, {message, Message}]}}]},
    {{halt, HttpCode}, wrq:set_resp_body(mochijson:encode(R), ReqData), Context}.

