<%-- 
    Document   : PrivilegeLevel
    Created on : Jun 9, 2016, 2:56:20 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
	    String privilege = (String)session.getAttribute("privilege");
	    String message = "Privilege Level : ";
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
