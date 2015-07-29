%%
%% url: http://server/getprompt/id/prompt_id
%%

-module(controller_getprompt).
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

init(ConfigProps) ->
    {ok, ConfigProps}.

%% @doc Initialize the context for the request. Continue session when available.
service_available(ReqData, ConfigProps) ->
    Context = z_context:set_noindex_header(z_context:set(ConfigProps, z_context:new(ReqData))),
    Context1 = z_context:ensure_qs(z_context:continue_session(Context)),
    DocId = z_context:get_q("id", Context1),
    case byte_size(z_convert:to_binary(kazoo_util:kz_get_account_prompt_attachment(DocId, Context1))) of
        0 -> ?WM_REPLY(false, Context1);
        N when is_integer(N) ->
            PromptDoc = kazoo_util:kz_get_account_prompt(DocId, Context1),
            Mime = z_media_identify:guess_mime(inno_util:get_value(<<"description">>,PromptDoc)),
            ContextMime = z_context:set(mime, Mime, Context1),
            ContextSize = z_context:set([{file_size, N}], ContextMime), 
            ?WM_REPLY(true, ContextSize);
        _ ->
            ?WM_REPLY(false, Context1)
    end.

allowed_methods(ReqData, Context) ->
    {['HEAD', 'GET'], ReqData, Context}.

content_types_provided(ReqData, Context) ->
    {[{z_context:get(mime, Context), provide_content}], ReqData, Context}.

%% @doc Simple access control for rsc based files
forbidden(ReqData, Context) ->
    DocId = z_context:get_q("id", Context),
    case string:len(re:replace(z_convert:to_list(DocId), "[^A-Za-z0-9]", "", [global, {return, list}])) of
        32 ->
            case kazoo_util:kz_get_account_prompt_attachment(DocId, Context) of
                 <<"">> ->
                     {true, ReqData, Context};
                 _ ->
                     {false, ReqData, Context}
            end;
        _ ->
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
    DocId = z_context:get_q("id", Context),
    {kazoo_util:kz_get_account_prompt_attachment(DocId, Context) =/= <<>>, ReqData, Context}.

charsets_provided(ReqData, Context) ->
    case is_text(z_context:get(mime, Context)) of
        true -> {[{"utf-8", fun(X) -> X end}], ReqData, Context};
        _ -> {no_charset, ReqData, Context}
    end.
    
provide_content(ReqData, Context) ->
    DocId = z_context:get_q("id", Context),
    Filename = DocId ++ z_media_identify:extension(z_context:get(mime, Context),".mp3"),
    RD1 = case z_context:get(content_disposition, Context) of
              inline ->     wrq:set_resp_header("Content-Disposition", "inline; filename="++Filename, ReqData);
              attachment -> wrq:set_resp_header("Content-Disposition", "attachment; filename="++Filename, ReqData);
              undefined ->  ReqData
          end,
    case z_context:get(body, Context) of
        undefined ->
            Data = z_convert:to_binary(kazoo_util:kz_get_account_prompt_attachment(DocId, Context)),
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
