<html>
	<head>
		<title>
                {_ New E911 address addition _} {_ at _} {{ sender_name|vartrans }} 
                </title>
	</head>
	<body>
		<h3>{_ Howdy, platform administrators _}</h3>
                <br />
		<p>
                  {_ An account _} <strong>{{ account_name }}</strong>
                  {_ added new E911 address for the phone number _} <strong>{{ number }}</strong>
                </p>
                <p>
                  Configured address:
                  <strong>
                    {{ street_address }}
                    {{ extended_address }},
                    {{ locality }},
                    {{ region }}
                    {{ postal_code }}
                  </strong>
                </p>
                {% if initial_comment %}
                  <p>
                    User's comment:
                    <strong>
                      {{ initial_comment }}
                    </strong>
                  </p>
                {% endif %}
                <br />
		<p>{_ Best regards _},</p>
		<p>{{ sender_name|vartrans }}</p>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Login name used _}: {{ login_name }}</a>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Requester's IP address _}: {{ clientip }}</a>
	</body>
</html>
