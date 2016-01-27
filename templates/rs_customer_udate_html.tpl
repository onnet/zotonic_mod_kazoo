{% raw %}
<html>
	<head>
		<title>
                {_ Welcome to _} {{ sender_name|vartrans }}
                </title>
	</head>
	<body>
                <h3>{_ Dear _} {{ firstname }},</h3>
                <h3>{_ Thank you for registering _}!</h3>
                <p>{_ We're pleased to confirm that your account has been created _}.</p>
                <h4>{_ As an account holder you now have access to our customer portal at _} &nbsp;<a href="https://{{ m.site.hostname }}">https://{{ m.site.hostname }}</a></h4> 
                <p>{_ The following access credentials are valid for portal _}:</p>
                <br />
                <table border="1" cellspacing="0" cellpadding="10">
                    <thead>
                        <td>{_ Username _}</td>
                        <td>{_ Password _}</td>
                        <td>{_ Account Name _}</td>
                    </thead>
                    <tbody>
                            <tr>
                                <td>{{ username }}</td>
                                <td>{{ password }}</td>
                                <td>{{ accountname }}</td>
                            </tr>
                    </tbody>
                </table>
                <br />
                <br />
		<p>{_ Regards _},</p>
		<p>{{ sender_name|vartrans }}</p>
                <br />
	</body>
</html>
{% endraw %}
