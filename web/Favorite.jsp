<%-- 
    Document   : Favorite
    Created on : Jun 9, 2016, 10:08:20 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
	<%
	    if (ApplicationInterface.POIOperations.changeFav((String)session.getAttribute("login"), request.getParameter("pid")) == 0) {
		%>
		<script>
			location.href = 'PoiList.jsp';
		</script>
		<%
	    } else {
		%>
		<script>
			if (!alert("Change Favorite Status failed")) location.href='PoiList.jsp';
		</script>
		<%
	    }
	%>
    </body>
</html>
