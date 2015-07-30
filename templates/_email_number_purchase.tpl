<html>
	<head>
		<title>
                {_ Number purchase attempt _} {_ at _} {{ account_name }} 
                </title>
	</head>
	<body>
		<h3>Howdy, Inno citizens</h3>
                <br />
		<p>An account <strong>{{ account_name }}</strong></p>
                <p>tries to purchase phone number <strong>{{ number }}</strong></p>
                <br />
                {% if not_creditable %}
                <br />
		<p><strong>{_ But account isn't creditable yet _}</strong></p>
                <br />
                {% endif %}
		<p>{_ Best regards _},</p>
		<p>{_ OnNet Innovations Limited _}</p>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Login name used _}: {{ login_name }}</a>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Requester's IP address _}: {{ clientip }}</a>
	</body>
</html>
