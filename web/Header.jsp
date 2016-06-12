<%-- 
    Document   : Header
    Created on : Jun 12, 2016, 6:45:11 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
	    String message = "Welcome, ";
	    String login = (String)session.getAttribute("login");
	    if (login == null || login == "") {
		message += "Guest";
	    } else {
		message += login;
	    }
	    
	    String privilege = (String)session.getAttribute("privilege"); 
	    message += "! Privilege Level : ";
	    if (privilege == null) {
		message += "Guest";
	    } else {
		Integer p = Integer.valueOf(privilege);
		if (p == 0) {
		    message += "Guest";
		} else if (p == 1) {
			message += "User";
		} else if (p == 2) {
			message += "Administrator";
		} else if (p == 3) {
			message += "SystemDeveloper";
		}
	    }
	%>
	<h2> <%= message %> </h2>
    </body>
</html>
