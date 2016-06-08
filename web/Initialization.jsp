<%-- 
    Document   : Initialization
    Created on : Jun 8, 2016, 7:35:44 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Initialization</title>
    </head>
    <body>
        <h1>Initialization</h1>
	<text>This JSP page drops all the tables in the remote server and initialize the tables needed for the CrowdTrack System.</text><br/>
	
	<%
	    if (request.getParameter("clicked") != null) {
		%>
		<text>Now destroying the world!!!!</text>
		<%= DatabaseInitializer.initialization() %>
		<%
	    }
	%>
	
	<form name="form1" method="POST">
	    <input type="hidden" name="clicked">
	    <input type="button" value="Restart" onclick="restart()">
	</form>
	
	<script language="JavaScript">
		<!--
		function restart() {
			document.form1.clicked.value = "true";
			form1.submit();
		}
	</script>	
	
    </body>
</html>