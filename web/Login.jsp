<%-- 
    Document   : Login
    Created on : Jun 9, 2016, 3:07:46 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        
	<%
	    System.err.println(request.getParameter("clicked"));
	    if (request.getParameter("clicked") != null) {
		System.err.println(request.getParameter("clicked"));
		session.setAttribute("privilege", request.getParameter("clicked"));
	    }
	%>

	<jsp:include page="PrivilegeLevel.jsp"/>
	
	<form name="form1" method="POST">
	    <input type="hidden" name="clicked">
	    <input type="button" value="I'm a Guest!" onclick="setPrivilege(0)">
	    <input type="button" value="I'm a User!" onclick="setPrivilege(1)">
	    <input type="button" value="I'm an Admin!" onclick="setPrivilege(2)">
	    <input type="button" value="I'm a Lolicon!" onclick="setPrivilege(3)">
	</form>
	
	<script language="JavaScript">
		<!--
		function setPrivilege(lev) {
			document.form1.clicked.value = lev;
			form1.submit();
		}
	</script>	
	
	<br/>
	<a href="index.jsp">Back</a>
	
    </body>
</html>
