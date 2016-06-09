<%-- 
    Document   : Logout
    Created on : Jun 9, 2016, 5:25:12 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
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
