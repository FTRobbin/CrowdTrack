<%-- 
    Document   : index
    Created on : Jun 9, 2016, 3:00:24 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>CrowdTrack</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
	
	<jsp:include page="Header.jsp"/>
	
        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="3"/>
		<jsp:param name="content" value="<div><a href=\"Initialization.jsp\">Initialization</a></div>"/>
	</jsp:include>

	<%
	    if (session.getAttribute("login") != null && session.getAttribute("login") != "") {
	    } else {
		%>
			<div><a href="Register.jsp">Register</a></div>
			<div><a href="Login.jsp">Login</a></div>
		<%
	    }
	%>

	
        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="1"/>
		<jsp:param name="content" value="<div><a href=\"Visit.jsp\">New Visit</a></div>"/>
	</jsp:include>
	
        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="1"/>
		<jsp:param name="content" value="<div><a href=\"PoiList.jsp\">POI List</a></div>"/>
	</jsp:include>

        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="1"/>
		<jsp:param name="content" value="<div><a href=\"Feedback.jsp\">Feedback</a></div>"/>
	</jsp:include>

        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="1"/>
		<jsp:param name="content" value="<div><a href=\"UserList.jsp\">User List</a></div>"/>
	</jsp:include>

        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="1"/>
		<jsp:param name="content" value="<div><a href=\"degree.jsp\">User Degree</a></div>"/>
	</jsp:include>

        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="2"/>
		<jsp:param name="content" value="<div><a href=\"ModifyPoi.jsp\">Modify POI</a></div>"/>
	</jsp:include>

	
        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="2"/>
		<jsp:param name="content" value="<div><a href=\"UserAwards.jsp\">User Awards</a></div>"/>
	</jsp:include>
	
	
        <jsp:include page="PrivilegeLevelHide.jsp" >
		<jsp:param name="requiredPL" value="1"/>
		<jsp:param name="content" value="<div><a href=\"Logout.jsp\">Logout</a></div>"/>
	</jsp:include>
	
    </body>
</html>
