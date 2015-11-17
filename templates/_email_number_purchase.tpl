<html>
	<head>
		<title>
                {_ Number purchase attempt _} {_ at _} {{ sender_name|vartrans }} 
                </title>
	</head>
	<body>
		<h3>{_ Howdy, platform administrators _}</h3>
                <br />
		<p>{_ An account _} <strong>{{ account_name }}</strong></p>
                <p>{_ tries to purchase phone number _} <strong>{{ number }}</strong></p>
                <br />
                {% if not_creditable %}
                <br />
		<p><strong>{_ But account isn't creditable yet _}</strong></p>
                <br />
                {% endif %}
		<p>{_ Best regards _},</p>
		<p>{{ sender_name|vartrans }}</p>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Login name used _}: {{ login_name }}</a>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Requester's IP address _}: {{ clientip }}</a>
	</body>
</html>
