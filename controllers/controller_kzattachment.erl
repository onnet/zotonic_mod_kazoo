-module(controller_kzattachment).
-export([service_available/1
        ,allowed_methods/1
        ,resource_exists/1
        ,forbidden/1
        ,content_types_provided/1
        ,encodings_provided/1
        ,charsets_provided/1
        ,provide_content/1
        ,finish_request/1
]).

-include_lib("zotonic.hrl").
-include("../include/mod_kazoo.hrl").

-define(CSV_CONTENT_TYPES, [{<<"text/csv">>, provide_content}
                           ]).

-define(PDF_CONTENT_TYPES, [{<<"application/pdf">>, provide_content}
                           ,{<<"application/x-pdf">>, provide_content}
                           ]).

-define(IMAGE_CONTENT_TYPES, [{<<"image/jpg">>, provide_content}
                             ,{<<"image/jpeg">>, provide_content}
                             ,{<<"image/png">>, provide_content}
                             ,{<<"image/gif">>, provide_content}
                             ]).

service_available(Context0) ->
    Context = z_context:set_noindex_header(Context0),
    Context1 = z_context:continue_session(z_context:ensure_qs(Context)),
    z_context:lager_md(Context1),
    {true, Context1}.

allowed_methods(Context) ->
    {[<<"HEAD">>, <<"GET">>], Context}.

forbidden(Context) ->
    {false, Context}.

content_types_provided(Context) ->
    case z_context:get_q(<<"doc_type">>, Context) of
        <<"onbill">> ->
            {[{<<"application/pdf">>, provide_content}], Context};
        <<"onbill_modb">> ->
            {[{<<"application/pdf">>, provide_content}], Context};
        <<"onbill_e911_address_proof">> ->
            {?PDF_CONTENT_TYPES ++ ?IMAGE_CONTENT_TYPES, Context};
        <<"tasks_csv">> ->
            {?CSV_CONTENT_TYPES, Context};
        <<"call_recording">> ->
            {[{<<"audio/mpeg">>, provide_content}], Context}
    end.

encodings_provided(Context) ->
    Mime = z_context:get(mime, Context),
    Encodings = case z_media_identify:is_mime_compressed(Mime) of
        true -> [{<<"identity">>, fun(Data) -> Data end}];
        _    -> [{<<"identity">>, fun(Data) -> modkazoo_util2:decode_data(identity, Data) end}
                ,{<<"gzip">>, fun(Data) -> modkazoo_util2:decode_data(gzip, Data) end}]
    end,
    {Encodings, z_context:set(encode_data, length(Encodings) > 1, Context)}.

charsets_provided(Context) ->
    case modkazoo_util2:is_text(z_context:get(mime, Context)) of
        true -> {[{<<"utf-8">>, fun(X) -> X end}], Context};
        _ -> {no_charset, Context}
    end.

resource_exists(Context) ->
    {true , Context}.

provide_content(Context) ->
    case z_context:get_q(<<"doc_type">>, Context) of
        <<"onbill">> ->
            case onbill_attachment(Context) of
                {'ok', Data} ->
                    MediaName = z_context:get_q(<<"att_name">>, Context),
                    Context1 = z_context:set_resp_header(<<"content-disposition">>
                                                        ,<<"attachment; filename=", MediaName/binary>>
                                                        ,Context),
                    Body = modkazoo_util2:maybe_encode_data(Data, Context),
                    {Body, z_context:set(body, Body, Context1)};
                _ -> api_error(404, 0, "No attachment found", Context)
            end;
        <<"onbill_modb">> ->
            case onbill_modb_attachment(Context) of
                {'ok', Data} ->
                    MediaName = z_context:get_q(<<"doc_id">>, Context),
                    Context1 = z_context:set_resp_header(<<"content-disposition">>
                                                        ,<<"attachment; filename=", MediaName/binary, ".pdf">>
                                                        ,Context),
                    Body = modkazoo_util2:maybe_encode_data(Data, Context),
                    {Body, z_context:set(body, Body, Context1)};
                _ -> api_error(404, 0, "No attachment found", Context)
            end;
        <<"onbill_e911_address_proof">> ->
            DocId = z_context:get_q(<<"doc_id">>, Context),
            AccountId = z_context:get_q(<<"account_id">>, Context),
            case onbill_util:get_e911_attachment(DocId, AccountId, Context) of
                {'ok', [50,_,_], Headers, Data} ->
                    Context1 = z_context:set_resp_header(<<"content-disposition">>
                                                        ,?TO_BIN(proplists:get_value("content-disposition", Headers))
                                                        ,Context),
                    Body = modkazoo_util2:maybe_encode_data(Data, Context),
                    {Body, z_context:set(body, Body, Context1)};
                _E ->
                    lager:info("provide_content eror: ~p",[_E]),
                    api_error(404, 0, "No attachment found", Context)
            end;
        <<"tasks_csv">> ->
            AttName = z_context:get_q(<<"att_name">>, Context),
            TaskId = z_context:get_q(<<"doc_id">>, Context),
            AccountId = z_context:get_q(<<"account_id">>, Context),
            case kazoo_util:get_tasks_csv(AttName, TaskId, AccountId, Context) of
                {'ok', [50,_,_], Headers, Data} ->
                    Context1 = z_context:set_resp_header(<<"content-disposition">>
                                                        ,?TO_BIN(proplists:get_value("content-disposition", Headers))
                                                        ,Context),
                    Body = modkazoo_util2:maybe_encode_data(Data, Context),
                    {Body, z_context:set(body, Body, Context1)};
                _E ->
                    lager:info("provide_content eror: ~p",[_E]),
                    api_error(404, 0, "No attachment found", Context)
            end;
        <<"call_recording">> ->
            MediaName = z_context:get_q(<<"recording_id">>, Context),
            Context1 = z_context:set_resp_header(<<"content-disposition">>
                                                ,<<"attachment; filename=", MediaName/binary, ".mp3">>
                                                ,Context),
            {'ok', Data} = call_recording_attachment(Context),
            Body = modkazoo_util2:maybe_encode_data(Data, Context),
            {Body, z_context:set(body, Body, Context1)};
        _ ->
            {<<>>, Context}
    end.

finish_request(Context) ->
    {ok, Context}.

onbill_attachment(Context) ->
    AccountId = z_context:get_q("account_id", Context),
    AttachmentId = z_context:get_q("att_name", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    case onbill_util:onbill_attachment(AttachmentId, AccountId, AuthToken, Context) of
        <<>> -> {error, <<>>};
        Body -> {ok, Body}
    end.

onbill_modb_attachment(Context) ->
    AccountId = z_context:get_q("account_id", Context),
    DocId = z_context:get_q("doc_id", Context),
    AuthToken = z_context:get_q("auth_token", Context),
    case onbill_util:onbill_modb_attachment(AccountId, DocId, AuthToken, Context) of
        <<>> -> {error, <<>>};
        Body -> {ok, Body}
    end.

call_recording_attachment(Context) ->
    AccountId = z_context:get_q(account_id, Context),
    RecordingId = z_context:get_q(recording_id, Context),
    AuthToken = z_context:get_q(auth_token, Context),
    Body = kazoo_util:call_recording_attachment(AccountId, RecordingId, AuthToken, Context),
    {ok, Body}.

api_error(HttpCode, ErrCode, Message, Context) ->
    R = {struct, [{error, {struct, [{code, ErrCode}, {message, Message}]}}]},
    {{halt, HttpCode}, cowmachine_req:set_resp_body(mochijson:encode(R), Context)}.
