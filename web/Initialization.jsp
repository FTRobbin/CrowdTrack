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
	<jsp:include page="PrivilegeLevelCheck.jsp">
		<jsp:param name="requiredPL" value="3"/>
	</jsp:include>
	
        <h1>Initialization</h1>
	<text>This JSP page drops all the tables in the remote server and initialize the tables needed for the CrowdTrack System.</text><br/>
	
	<%
	    System.err.println(request.getParameter("clicked"));
	    if (request.getParameter("clicked") != null) {
		if (request.getParameter("clicked").equals("0")) {
		    %>
		    <text>Now destroying the world!!!!</text>
		    <%= DatabaseInitializer.initialization("Initialization.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("1")) {
		    %>
		    <text>Now adding basic users.</text>
		    <%= DatabaseInitializer.initialization("BasicUserPack.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("2")) {
		    %>
		    <text>Now adding basic POIs.</text>
		    <%= DatabaseInitializer.initialization("BasicPOIPack.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("3")) {
		    %>
		    <text>Now adding World Wonders.</text>
		    <%= DatabaseInitializer.initialization("WorldWondersPack.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("4")) {
		    %>
		    <text>Now adding Turing Awards Winners.</text>
		    <%= DatabaseInitializer.initialization("TuringAwardsPack.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("5")) {
		    %>
		    <text>Now adding random generated feedbacks.</text>
		    <%= DatabaseInitializer.initialization("TravellingComputerScientists.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("6")) {
		    %>
		    <text>Now adding basic keywords.</text>
		    <%= DatabaseInitializer.initialization("AdjectiveKeywords.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("7")) {
		    %>
		    <text>Now adding other tables.</text>
		    <%= DatabaseInitializer.initialization("MoreInitialization.sql") %>
		    <%
		}
		if (request.getParameter("clicked").equals("8")) {
		    %>
		    <text>Now recreating all the wheels.</text>
		    <%= DatabaseInitializer.initialization("AddAll.sql") %>
		    <%
		}
	
	    }
	%>
	
	<form name="form1" method="POST">
	    <input type="hidden" name="clicked">
	    <input type="button" value="Restart" onclick="go(0)">
	    <input type="button" value="AddBasicUsers" onclick="go(1)">
	    <input type="button" value="AddBasicPOIs" onclick="go(2)">
	    <input type="button" value="AddWorldWonders" onclick="go(3)">
	    <input type="button" value="AddTuringAwards" onclick="go(4)">
	    <input type="button" value="AddFeedbacks" onclick="go(5)">
	    <input type="button" value="AddKeywords" onclick="go(6)">
	    <input type="button" value="AddOtherTables" onclick="go(7)">
	    <input type="button" value="CreateWorld" onclick="go(8)">
	</form>
	
	<script language="JavaScript">
		<!--
		function go(action) {
			document.form1.clicked.value = action;
			form1.submit();
		}
	</script>	
	
	<br/>
	<a href="index.jsp">Back</a>
    </body>
</html>