<html>
	<head>
		<title>
                {_ Pro-forma invoice _} {_ for _} {{ account_name }} 
                </title>
	</head>
	<body>
		<h3>{_ Dear _} {{ first_name }} {{ last_name }},</h3>
                <br />
		<p>{_ Requested pro-forma invoice attached to this email _}.</p>
                <p>{_ Customer _}: <strong>{{ account_name }}</strong></p>
                <p>{_ Amount _}: <strong>{{ m.config.mod_kazoo.local_currency_sign.value }}{{ amount|format_price }}</strong></p>
                <br />
		<p>{_ Best regards _},</p>
		<p>{_ OnNet Innovations Limited _}</p>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Requester's IP address _}: {{ clientip }}</a>
	</body>
</html>
