-module(modkazoo_notify).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([email_attachment/6
        ,send_invoice/2
]).

-include_lib("zotonic.hrl").

-define(HTML_TO_PDF, "/usr/local/bin/wkhtmltopdf --quiet").

email_attachment(CustomerEmail, FileName, Template, Vars, Data, Context) ->
    {ClientIP, _} = webmachine_request:peer(z_context:get_reqdata(Context)),
    Attachment = #upload{
        filename = z_convert:to_list(FileName),
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

