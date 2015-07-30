<html>
	<head>
		<title>
                Welcome to OnNet Innovations
                </title>
	</head>
	<body>
                <h3>Dear {{ firstname }},</h3>
                <h3>Thank you for registering!</h3>
                <p>We're pleased to confirm that your account has been created.</p>
                <h4>As an account holder you now have access to our:</h4> 
                <ul>
                  <li>customer portal at <a href="https://onnet.info">https://onnet.info</a></li> 
                  <li>Hosted PBX portal at <a href="https://portal.onnet.info">https://portal.onnet.info</a></li>
                </ul> 
                <p>The following access credentials are valid for both portals:</p>
                <br />
                <table border="1" cellspacing="0" cellpadding="10">
                    <thead>
                        <td>{_ Account Name _}</td>
                        <td>{_ Username _}</td>
                        <td>{_ Password _}</td>
                    </thead>
                    <tbody>
                            <tr>
                                <td>{{ accountname }}</td>
                                <td>{{ username }}</td>
                                <td>{{ password }}</td>
                            </tr>
                    </tbody>
                </table>
                <br />
                <h4>Support Centre</h4>

                <p>You can also open support tickets in our Support Centre at <a href="https://helpdesk.onnet.info">https://helpdesk.onnet.info</a></p>
                <br />
		<p>{_ Regards _},</p>
		<p>{_ OnNet Innovations Limited _}</p>
                <br />
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Requester's IP address _}: {{ clientip }}</a>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Contact phone number provided _}: {{ phonenumber }}</a>
	</body>
</html>
