%%
%% Shortened controller_file_readonly from mod_base to find path to a file 
%% by stored in external db id and provide this file for downloading
%% url: http://server/getfaxdoc/id/faxdoc_id
%%

-module(controller_getfaxdoc).
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

-define(FILE_DIR, <<"/tmp/">>).

init(ConfigProps) ->
    {ok, ConfigProps}.

%% @doc Initialize the context for the request. Continue session when available.
service_available(ReqData, ConfigProps) ->
    Context = z_context:set_noindex_header(z_context:set(ConfigProps, z_context:new(ReqData))),
    Context1 = z_context:ensure_qs(z_context:continue_session(Context)),
    DocId = z_context:get_q("id", Context1),
    ContextMime = z_context:set(mime, z_media_identify:guess_mime(DocId), Context1),
    case file:read_file(<<?FILE_DIR/binary, (z_convert:to_binary(DocId))/binary>>) of
        {ok, FileBody} ->
            case byte_size(z_convert:to_binary(FileBody)) of
                0 -> 
                    ?WM_REPLY(false, Context1);
                N when is_integer(N) ->
                    ContextSize = z_context:set([{file_size, N}], ContextMime), 
                    ?WM_REPLY(true, ContextSize);
                _ ->
                    ?WM_REPLY(false, Context1)
            end;
        _ ->
            ?WM_REPLY(false, Context1)
    end.

allowed_methods(ReqData, Context) ->
    {['HEAD', 'GET'], ReqData, Context}.

content_types_provided(ReqData, Context) ->
    {[{z_context:get(mime, Context), provide_content}], ReqData, Context}.

%% @doc Simple access control for rsc based files
forbidden(ReqData, Context) ->
    case file_exists(Context) of
        'true' ->
            {false, ReqData, Context};
        'false' ->
            {true, ReqData, Context}
    end.

encodings_provided(ReqData, Context) ->
    Mime = z_context:get(mime, Context),
    Encodings = case z_media_identify:is_mime_compressed(Mime) of
        true -> [{"identity", fun(Data) -> Data end}];
        _    -> [{"identity", fun(Data) -> decode_data(identity, Data) end},
                {"gzip",     fun(Data) -> decode_data(gzip, Data) end}]
    end,
    {Encodings, ReqData, z_context:set(encode_data, length(Encodings) > 1, Context)}.

resource_exists(ReqData, Context) ->
    {file_exists(Context), ReqData, Context}.

charsets_provided(ReqData, Context) ->
    case is_text(z_context:get(mime, Context)) of
        true -> {[{"utf-8", fun(X) -> X end}], ReqData, Context};
        _ -> {no_charset, ReqData, Context}
    end.
    
provide_content(ReqData, Context) ->
    Filename = z_context:get_q("id", Context),
    RD1 = case z_context:get(content_disposition, Context) of
              inline ->     wrq:set_resp_header("Content-Disposition", "inline; filename="++Filename, ReqData);
              attachment -> wrq:set_resp_header("Content-Disposition", "attachment; filename="++Filename, ReqData);
              undefined ->  ReqData
          end,
    case z_context:get(body, Context) of
        undefined ->
            {'ok', Data} = file:read_file(<<?FILE_DIR/binary, (z_convert:to_binary(z_context:get_q("id", Context)))/binary>>),
            Body = case z_context:get(encode_data, Context, false) of 
                true -> encode_data(Data);
                false -> Data
            end,
            {Body, RD1, z_context:set(body, Body, Context)};
        Body -> 
            {Body, RD1, Context}
    end.
    
finish_request(ReqData, Context) ->
    {ok, ReqData, Context}.

%%%%%%%%%%%%%% Helper functions %%%%%%%%%%%%%%

file_exists(Context) ->
    DocId = z_context:get_q("id", Context),
    case string:len(re:replace(z_convert:to_list(DocId), "[^A-Za-z0-9]", "", [global, {return, list}])) of
        65 ->
            case file:read_file_info(<<?FILE_DIR/binary, (z_convert:to_binary(DocId))/binary>>) of
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
