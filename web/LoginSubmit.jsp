<%-- 
    Document   : LoginSubmit
    Created on : Jun 9, 2016, 5:17:18 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submitting</title>
    </head>
    <body>
	<%
	    String login=(String)request.getParameter("login"),
		   pass=(String)request.getParameter("pass");
	    java.util.ArrayList<String[]> ret = ApplicationInterface.UserOperations.checkLogin(login, pass);
	    if (ret.size() == 1) {
		session.setAttribute("login", ret.get(0)[0]);
		session.setAttribute("name", ret.get(0)[2]);
		session.setAttribute("privilege", ret.get(0)[3]);
		%>
		<script>
			if (!alert("Login Success.")) location.href = 'index.jsp';
		</script>
		<%
	    } else {
		%>
		<script>
			if (!alert("Wrong combination of login and password! Login failed!")) location.href='Login.jsp';
		</script>
		<%
	    }
	%>
    </body>
</html>
