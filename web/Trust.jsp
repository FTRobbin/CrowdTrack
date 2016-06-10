<%-- 
    Document   : Trust
    Created on : Jun 10, 2016, 3:10:44 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
	<%
	    if (ApplicationInterface.UserOperations.changeTrust((String)session.getAttribute("login"), request.getParameter("login")) == 0) {
		%>
		<script>
			location.href = 'UserList.jsp';
		</script>
		<%
	    } else {
		%>
		<script>
			if (!alert("Change Favorite Status failed")) location.href='UserList.jsp';
		</script>
		<%
	    }
	%>
    </body>
</html>
