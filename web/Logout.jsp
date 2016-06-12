<%-- 
    Document   : Logout
    Created on : Jun 9, 2016, 5:25:12 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
			<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
                <title>Logout</title>


	<!-- Bootstrap core CSS -->
	<link href="Style/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap theme -->
	<link href="Style/css/bootstrap-theme.min.css" rel="stylesheet">

    </head>
    <body>
	<%
		if (session.getAttribute("login") == null || session.getAttribute("login") == "") {
		%>
		<script>
			if (!alert("You haven't logged in.")) location.href='index.jsp';
		</script>
		<%
	    }

	%>
	
	<%
		session.setAttribute("login", null);
		session.setAttribute("name", null);
		session.setAttribute("privilege", null);
	%>
	<script>
			if (!alert("Logout Success.")) location.href = 'index.jsp';
	</script>
    </body>
</html>
