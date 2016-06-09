<%-- 
    Document   : RegisterSubmit
    Created on : Jun 9, 2016, 3:48:29 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submitting</title>
    </head>
    <body>
	<%
	    String login=(String)request.getParameter("login"),
		   name=(String)request.getParameter("name"),
		   pass=(String)request.getParameter("pass");
	    int ret = ApplicationInterface.Registration.registerUser(login, name, pass);
	    if (ret == 0) {
		session.setAttribute("login", login);
		session.setAttribute("name", name);
		session.setAttribute("privilege", "1");
		%>
		<script>
			if (!alert("Registration Success.")) location.href = 'index.jsp';
		</script>
		<%
	    } else {
		%>
		<script>
			if (!alert("The login has been used! Registration failed!")) location.href='Register.jsp';
		</script>
		<%
	    }
	%>
    </body>
</html>
