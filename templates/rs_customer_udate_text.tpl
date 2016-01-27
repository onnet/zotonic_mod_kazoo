{% raw %}

{_ Dear _} {{ firstname }},
{_ Thank you for registering _}!
{_ We're pleased to confirm that your account has been created _}.
{_ As an account holder you now have access to our customer portal at _} https://{{ m.site.hostname }}
{_ The following access credentials are valid for portal _}:
                
{_ Username _}: {{ username }}
{_ Password _}: {{ password }}
{_ Account Name _}: {{ accountname }}


{_ Regards _},
{{ sender_name|vartrans }}

{% endraw %}
