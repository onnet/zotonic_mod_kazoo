-module(modkazoo_notify).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([email_attachment/6
        ,send_invoice/2
        ,rs_send_customer_update/1
]).

-include_lib("zotonic.hrl").

-define(HTML_TO_PDF, "/usr/local/bin/wkhtmltopdf --quiet").

email_attachment(CustomerEmail, FileName, Template, Vars, Data, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    Attachment = #upload{
        filename = z_convert:to_list(FileName),
        tmpfile=FileName,
        data = Data,
        mime = "application/pdf"
    },
    Email = #email{
        from=m_config:get_value('mod_kazoo', sales_email, Context),
        to=CustomerEmail,
        html_tpl=z_convert:to_list(Template),
        vars=[{clientip, ClientIP}|Vars],
        attachments = [Attachment]
    },
    z_email:send(Email, Context).

send_invoice(Amount,Context) ->
    {'ok', InvoiceNumber} = create_invoice(Amount, Context),
    {'ok', Data} = file:read_file("/tmp/"++InvoiceNumber++".pdf"),
    email_attachment(kazoo_util:kz_user_doc_field(<<"email">>, Context)
                    ,InvoiceNumber++".pdf"
                    ,"_email_invoice.tpl"
                    ,[{'account_name', z_context:get_session('kazoo_account_name', Context)}
                     ,{'amount', Amount}
                     ,{'first_name', kazoo_util:kz_user_doc_field(<<"first_name">>, Context)}
                     ,{'last_name', kazoo_util:kz_user_doc_field(<<"last_name">>, Context)}
                    ]
                    ,Data
                    ,Context).

create_invoice(Amount, Context) ->
    {{Year, Month, Day}, {Hour, Minute, _}} = erlang:localtime(),
    InvoiceNumber = io_lib:format("IA~w~2..0w~2..0w~2..0w~2..0w",[Year, Month, Day, Hour, Minute]),
    {HTML, _} = z_template:render_to_iolist("invoice-pre.tpl",[{amount, Amount}
                                                              ,{invoicenumber, InvoiceNumber}
                                                              ,{'account_name', z_context:get_session('kazoo_account_name', Context)}
                                                              ], Context),
    HtmlFullPath = lists:flatten(["/tmp/",InvoiceNumber,".html"]),
    _ = file:write_file(HtmlFullPath, HTML),
    case os:cmd(lists:flatten([?HTML_TO_PDF, " ", HtmlFullPath, " ", "/tmp/"++InvoiceNumber++".pdf"])) of
        [] ->
            {'ok', InvoiceNumber};
        E ->
            {'error', E}
    end.

rs_send_customer_update(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    RecipientAccountId = z_context:get_q("account_id", Context),


    {'ok', ModHTML} = erlydtl:compile(z_convert:to_binary(z_context:get_q("html_body", Context))
                                      ,z_convert:to_list(AccountId) ++ "_html"
                                      ,Context),

    {'ok', ModText} = erlydtl:compile(z_convert:to_binary(z_context:get_q("text_body", Context))
                                      ,z_convert:to_list(AccountId) ++ "_text"
                                      ,Context),

    _ = file:write_file(lists:flatten(["/tmp/",z_convert:to_list(AccountId),"_subject.tpl"])
                        ,z_context:get_q("subject", Context)),
    _ = file:write_file(lists:flatten(["/tmp/",z_convert:to_list(AccountId),"_html.tpl"])
                        ,z_context:get_q("html_body", Context)),
    _ = file:write_file(lists:flatten(["/tmp/",z_convert:to_list(AccountId),"_text.tpl"])
                        ,z_context:get_q("text_body", Context)),

    RecipientsList = case modkazoo_util:get_q_bin("selected_user", Context) of
                         <<"all_users">> -> modkazoo_util:props_get_values(<<"id">>, kazoo_util:kz_list_account_users(RecipientAccountId, Context));
                         UserId -> [UserId]
                     end,

    RecipientAccountDoc = kazoo_util:kz_get_acc_doc_by_account_id(RecipientAccountId, Context),

    Vars = [
             {sender_name, m_config:get_value('mod_kazoo', 'sender_name', Context)}
            ,{accountname, modkazoo_util:get_value(<<"name">>, RecipientAccountDoc)}
           ],

    rs_send_users_update(RecipientsList, ModHTML, ModText, Vars, Context),
    lager:info("All variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("IAM RecipientsList ~p", [RecipientsList]).

rs_send_users_update([], _, _, _, _) ->
    'ok';
rs_send_users_update([H|T], ModHTML, ModText, CustomerVars, Context) ->
    rs_send_user_update(H, ModHTML, ModText, CustomerVars, Context), 
    rs_send_users_update(T, ModHTML, ModText, CustomerVars, Context).

rs_send_user_update(UserId, ModHTML, ModText, CustomerVars, Context) ->
    AccountId = modkazoo_util:get_q_bin("account_id", Context),
    UserDoc = kazoo_util:kz_get_user_doc(UserId, AccountId, Context),
    To = modkazoo_util:get_value_bin(<<"email">>, UserDoc),

    Vars = [
            {username, modkazoo_util:get_value_bin(<<"username">>, UserDoc)}
            ,{firstname, modkazoo_util:get_value_bin(<<"first_name">>, UserDoc)}
            ,{surname, modkazoo_util:get_value_bin(<<"last_name">>, UserDoc)}
           ] ++ CustomerVars,

    {'ok', HTML} = ModHTML:render(Vars, Context),
    {'ok', Text} = ModText:render(Vars, Context),

    Email = #email{
        subject=z_context:get_q("subject", Context),
        from=z_context:get_q("from", Context),
        to=To,
        html=HTML,
        text=Text,
        vars=Vars
    },

    z_email:send(Email, Context).

