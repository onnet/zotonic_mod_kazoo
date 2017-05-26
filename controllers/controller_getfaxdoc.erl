%%
%% Shortened controller_file_readonly from mod_base to find path to a file 
%% by stored in external db id and provide this file for downloading
%% url: http://server/getfaxdoc/id/faxdoc_id
%%

-module(controller_getfaxdoc).
-export([
    service_available/1,
    allowed_methods/1,
    resource_exists/1,
    forbidden/1,
    content_types_provided/1,
    charsets_provided/1,
    encodings_provided/1,
    provide_content/1,
    finish_request/1
]).

-include_lib("zotonic.hrl").
-include("../include/mod_kazoo.hrl").

-define(FILE_DIR, <<"/tmp/">>).

service_available(Context0) ->
    Context = z_context:set_noindex_header(Context0),
    Context1 = z_context:continue_session(z_context:ensure_qs(Context)),
    DocId = z_context:get_q('id', Context1),
    ContextMime = z_context:set(mime, z_media_identify:guess_mime(DocId), Context1),
    case file:read_file(<<?FILE_DIR/binary, DocId/binary>>) of
        {ok, FileBody} ->
            case byte_size(?TO_BIN(FileBody)) of
                0 -> 
                    {false, Context1};
                N when is_integer(N) ->
                    ContextSize = z_context:set([{file_size, N}], ContextMime), 
                    {true, ContextSize};
                _ ->
                    {false, Context1}
            end;
        _ ->
            {false, Context1}
    end.

allowed_methods(Context) ->
    {[<<"HEAD">>, <<"GET">>], Context}.

forbidden(Context) ->
    case file_exists(Context) of
        'true' ->
            {false, Context};
        'false' ->
            {true, Context}
    end.

content_types_provided(Context) ->
    {[{?TO_BIN(z_context:get(mime, Context)), provide_content}], Context}.

encodings_provided(Context) ->
    Mime = z_context:get(mime, Context),
    Encodings = case z_media_identify:is_mime_compressed(Mime) of
        true -> [{<<"identity">>, fun(Data) -> Data end}];
        _    -> [{<<"identity">>, fun(Data) -> decode_data(identity, Data) end}
                ,{<<"gzip">>, fun(Data) -> decode_data(gzip, Data) end}]
    end,
    {Encodings, z_context:set(encode_data, length(Encodings) > 1, Context)}.

resource_exists(Context) ->
    {file_exists(Context), Context}.

charsets_provided(Context) ->
    case is_text(z_context:get(mime, Context)) of
        true -> {[{<<"utf-8">>, fun(X) -> X end}], Context};
        _ -> {no_charset, Context}
    end.

provide_content(Context0) ->
    FileName = z_context:get_q('id', Context0),
    Context = case z_context:get(content_disposition, Context0) of
                  inline ->
                      z_context:set_resp_header(<<"content-disposition">>
                                               ,<<"inline; filename=", FileName/binary>>
                                               ,Context0);
                  attachment ->
                      z_context:set_resp_header(<<"content-disposition">>
                                               ,<<"attachment; filename=", FileName/binary>>
                                               ,Context0);
                  undefined ->  Context0
              end,
    case z_context:get(body, Context) of
        undefined ->
            {'ok', Data} = file:read_file(<<?FILE_DIR/binary, FileName/binary>>),
            Body = case z_context:get(encode_data, Context, false) of 
                true -> encode_data(Data);
                false -> Data
            end,
            {Body, z_context:set(body, Body, Context)};
        Body -> 
            {Body, Context}
    end.
    
finish_request(Context) ->
    {ok, Context}.

%%%%%%%%%%%%%% Helper functions %%%%%%%%%%%%%%

file_exists(Context) ->
    case z_context:get_q('id', Context) of
        <<"faxout-", _:32/binary, "-", _:24/binary, ".pdf">> = DocId ->
            case file:read_file_info(<<?FILE_DIR/binary, DocId/binary>>) of
                 {'ok',_} -> 'true';
                 _ -> 'false'
            end;
        _ -> 'false'
    end.

%% @spec is_text(Mime) -> bool()
%% @doc Check if a mime type is textual
is_text("text/" ++ _) -> true;
is_text("application/x-javascript") -> true;
is_text("application/xhtml+xml") -> true;
is_text("application/xml") -> true;
is_text(_Mime) -> false.

%% Encode the data so that the identity variant comes first and then the gzip'ed variant
encode_data(Data) when is_binary(Data) ->
    {Data, zlib:gzip(Data)}.

decode_data(gzip, Data) when is_binary(Data) ->
    zlib:gzip(Data);
decode_data(identity, Data) when is_binary(Data) ->
    Data;
decode_data(identity, {Data, _Gzip}) ->
    Data;
decode_data(gzip, {_Data, Gzip}) ->
    Gzip.
