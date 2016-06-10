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
        <jsp:include page="PrivilegeLevel.jsp" />
        <div><a href="Initialization.jsp">Initialization</a></div>
	<div><a href="Register.jsp">Register</a></div>
	<div><a href="Login.jsp">Login</a></div>
        <div><a href="Visit.jsp">Visit</a></div>
        <div><a href="ModifyPoi.jsp">Modify POI</a></div>
        <div><a href="PoiList.jsp">POI List</a></div>
        <div><a href="Feedback.jsp">View Feedback</a></div>
	<div><a href="UserList.jsp">User List</a></div>
        <div><a href="degree.jsp">User Degree</a></div>
	<div><a href="Logout.jsp">Logout</a></div>
    </body>
</html>
