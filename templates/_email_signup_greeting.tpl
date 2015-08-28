<html>
	<head>
		<title>
                {_ Welcome to _} {_ OnNet Communications Inc._}
                </title>
	</head>
	<body>
                <h3>{_ Dear _} {{ firstname }},</h3>
                <h3>{_ Thank you for registering _}!</h3>
                <p>{_ We're pleased to confirm that your account has been created _}.</p>
                <h4>{_ As an account holder you now have access to our customer portal at _} &nbsp;<a href="https://onnet.su">https://onnet.su</a></h4> 
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
                <h4>{_ Support Centre _}</h4>

                <p>{_ You can also open support tickets in our Support Centre at _} &nbsp;<a href="https://helpdesk.onnet.info">https://helpdesk.onnet.info</a></p>
                <br />
		<p>{_ Regards _},</p>
		<p>{_ OnNet Communications Inc. _}</p>
                <br />
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Requester's IP address _}: {{ clientip }}</a>
                <br />
                <a style="font-size:small; color: #c0c0c0;" >{_ Contact phone number provided _}: {{ phonenumber }}</a>
	</body>
</html>
